import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/handlingdata.dart';
import 'package:negmt_heliopolis/core/utlis/services/location_servisess.dart';
import 'package:negmt_heliopolis/core/utlis/services/map_places_serviese.dart';
import 'package:negmt_heliopolis/features/maps/model/map_place_detalis_model.dart';
import 'package:negmt_heliopolis/features/maps/model/map_places_model.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/statusrequest.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';
import 'package:negmt_heliopolis/features/maps/repo/add_address_repo.dart';
import 'package:negmt_heliopolis/features/maps/repo/add_address_repo_impl.dart';
import 'package:uuid/uuid.dart';

abstract class AddressController extends GetxController {
  Future<void> addAddress(Address address);
}

class AddressControllerImpl extends AddressController {
  TextEditingController searchController = .new();
  FocusNode searchFocusNode = .new();
  final AddAddressRepo addAddressRepo = AddAddressRepoImpl(
    Get.find<ApiService>(),
  );
  MapPlacesServiese mapPlacesServiese = MapPlacesServiese(Get.find());

  Statusrequest addAddressesstatusrequest = Statusrequest.none;
  Statusrequest autoCompletestatusrequest = Statusrequest.none;
  Statusrequest placeDetailsstatusrequest = Statusrequest.none;
  Statusrequest mapstatusrequest = Statusrequest.loading;
  List<Prediction> predictions = [];
  Result? resultDetails;

  bool isSearch = false;
  bool _isDisposed = false;

  late LocationServisess locationServisess;
  late CameraPosition initialCameraPosition;
  GoogleMapController? _mapController;
  late CameraPosition cameraPosition;

  GoogleMapController get mapController => _mapController!;
  set mapController(GoogleMapController controller) =>
      _mapController = controller;
  String country = '';
  String city = '';
  String administrativeArea = '';
  String street = '';
  LatLng latLng = const LatLng(0, 0);

  Set<Marker> newmarker = {};
  late Uuid uUid;
  String? sessionToken;
  BitmapDescriptor? customMarker;

  @override
  void onClose() {
    _isDisposed = true;
    searchController.dispose();
    searchFocusNode.dispose();
    _mapController?.dispose();
    _mapController = null;
    newmarker.clear();
    predictions.clear();
    resultDetails = null;
    country = '';
    city = '';
    administrativeArea = '';
    street = '';
    sessionToken = null;
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    locationServisess = LocationServisess();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
    uUid = const Uuid();
    loadCustomMarker();
  }

  Future<void> loadCustomMarker() async {
    customMarker = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(45.w, 45.h)),
      "assets/Icons_logos/location_marker.png",
    );
    update();
  }

  void ubdataCameraPosition({
    bool isontap = false,
    LatLng? latLngg,
    bool skipGeocoding = false,
  }) async {
    mapstatusrequest = Statusrequest.loading;
    update();
    LocationData locationData;

    if (isontap) {
      latLng = latLngg!;
    } else {
      locationData = await locationServisess.getlocation();
      latLng = LatLng(locationData.latitude!, locationData.longitude!);
    }
    try {
      Marker marker = Marker(
        markerId: const MarkerId("1"),
        position: latLng,
        icon: customMarker ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: "My Location"),
      );

      newmarker.clear();
      newmarker.add(marker);

      cameraPosition = CameraPosition(zoom: 12, target: latLng);
      if (!_isDisposed && _mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
      }
      if (!skipGeocoding) {
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            latLng.latitude,
            latLng.longitude,
          );
          if (placemarks.isNotEmpty) {
            Placemark place = placemarks[0];
            country = place.country ?? '';
            city = place.locality ?? place.subAdministrativeArea ?? '';
            administrativeArea = place.administrativeArea ?? '';
            street = place.street ?? '';
          }
        } catch (e) {
          log("error placemarks $e");
        }
      }

      mapstatusrequest = Statusrequest.success;
      update();
    } on LocationServisessException catch (e) {
      showCustomGetSnack(isGreen: false, text: e.toString());
    } on LocationPermissionException catch (e) {
      showCustomGetSnack(isGreen: false, text: e.toString());
    }
  }

  @override
  addAddress(Address address) async {
    addAddressesstatusrequest = Statusrequest.loading;
    update();

    final result = await addAddressRepo.addAddress(address: address);

    result.fold(
      (failure) {
        addAddressesstatusrequest = Statusrequest.failuer;
        showCustomGetSnack(
          isGreen: false,
          text: failure.errorMessage,
          duration: const Duration(minutes: 5),
        );
      },
      (successMessage) {
        addAddressesstatusrequest = Statusrequest.success;
        Get.back();
        showCustomGetSnack(isGreen: true, text: successMessage);
        Get.find<AddressesControllerImpl>().fetchAddresses().then((value) {
          update(['addressId']);
        });
      },
    );
    update();
  }

  placesAutocomplete(String text) async {
    autoCompletestatusrequest = Statusrequest.loading;
    sessionToken ??= const Uuid().v4();

    // log("sessionToken: $sessionToken");
    var response = await mapPlacesServiese.fetchPredictions(
      text,
      sessionToken!,
      detectLangFromQuery(searchController.text),
    );

    if (response['status'] == 'OK') {
      final places = MapPlacesModel.fromJson(response);
      predictions.clear();
      predictions = places.predictions;

      autoCompletestatusrequest = Statusrequest.success;
    } else {
      autoCompletestatusrequest = Statusrequest.failuer;
    }
    update(['search']);
  }

  fetchPlaceDetails(String id) async {
    searchFocusNode.unfocus();
    placeDetailsstatusrequest = Statusrequest.loading;
    var response = await mapPlacesServiese.getPlaceDetails(
      id,
      sessionToken!,
      detectLangFromQuery(searchController.text),
    );
    final status = handlingData(response);
    if (status == Statusrequest.success) {
      if (response['status'] == 'OK') {
        final details = MapPlacesDetailsModel.fromJson(response);
        resultDetails = details.result!;

        ubdataCameraPosition(
          isontap: true,
          latLngg: LatLng(
            resultDetails!.geometry!.location!.lat!,
            resultDetails!.geometry!.location!.lng!,
          ),
          skipGeocoding: true,
        );

        country = resultDetails?.addressComponents.last.longName ?? "";
        city = resultDetails?.addressComponents.first.longName ?? "";
        update();
        sessionToken = null;

        placeDetailsstatusrequest = Statusrequest.success;
      } else {
        placeDetailsstatusrequest = Statusrequest.failuer;
      }
    }
  }

  search(String text) {
    if (text.length % 2 == 0 && text.isNotEmpty) {
      placesAutocomplete(text);
    }
    if (isSearch == false) {
      startInitShow();
      isSearch = true;
      update(['search']);
    }
  }

  closeSearch() {
    if (isSearch) {
      isSearch = false;
      initShow = false;
      update(['search']);
    }
  }

  bool initShow = false;

  startInitShow({int delayMs = 160}) {
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (!initShow) {
        initShow = true;
        update(['search']);
      }
    });
  }
}
