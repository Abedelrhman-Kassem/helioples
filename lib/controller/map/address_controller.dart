import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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
  // Future<void> fetchAddresses();
  Future<void> addAddress(Address address);
  // Future<void> updateAddress(Address address);
  // Future<void> deleteAddress({required int addressId});
}

class AddressControllerImpl extends AddressController {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = .new();
  final AddAddressRepo addAddressRepo = AddAddressRepoImpl(
    Get.find<ApiService>(),
  );
  MapPlacesServiese mapPlacesServiese = MapPlacesServiese(Get.find());
  // MyServises myServises = Get.find();
  // GetAddressesData getAddressesData = GetAddressesData(Get.find());
  // AddAddressesData addAddressesData = AddAddressesData(Get.find());
  // UpdateAddressesData updateAddressesData = UpdateAddressesData(Get.find());
  // RemoveAddresseData removeAddresseData = RemoveAddresseData(Get.find());
  // MapPlacesServiese mapPlacesServiese = MapPlacesServiese(Get.find());

  Statusrequest fetchAddressesstatusrequest = Statusrequest.loading;
  Statusrequest addAddressesstatusrequest = Statusrequest.none;
  Statusrequest updateAddressesstatusrequest = Statusrequest.none;
  Statusrequest deleteAddressesstatusrequest = Statusrequest.none;
  Statusrequest autoCompletestatusrequest = Statusrequest.none;
  Statusrequest placeDetailsstatusrequest = Statusrequest.none;
  Statusrequest mapstatusrequest = Statusrequest.loading;
  // List<Datum> addresses = [];
  List<Prediction> predictions = [];
  Result? resultDetails;

  // String? userId;
  bool isSearch = false;

  late LocationServisess locationServisess;
  late CameraPosition initialCameraPosition;
  late GoogleMapController mapController;
  late CameraPosition cameraPosition;
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
    super.onClose();
    searchController.dispose();
    searchFocusNode.dispose();
    mapController.dispose();
    newmarker.clear();
    predictions.clear();
    resultDetails = null;
    country = '';
    city = '';
    administrativeArea = '';
    street = '';
    sessionToken = null;
  }

  @override
  void onInit() {
    super.onInit();
    // userId = myServises.sharedPreferences.getString("user_id");
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

  // Future<BitmapDescriptor> svgToBitmapDescriptor(
  //   String assetPath,
  //   Size size,
  // ) async {
  //   final String svgString = await rootBundle.loadString(assetPath);
  //   final PictureInfo pictureInfo = await vg.loadPicture(
  //     SvgStringLoader(svgString),
  //     null,
  //   );

  //   final ui.Image image = await pictureInfo.picture.toImage(
  //     size.width.toInt(),
  //     size.height.toInt(),
  //   );
  //   final ByteData? bytes = await image.toByteData(
  //     format: ui.ImageByteFormat.png,
  //   );

  //   return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
  // }

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
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
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

  // @override
  // fetchAddresses() async {
  //   userId = myServises.sharedPreferences.getString("user_id");
  //   log("userId $userId");
  //   try {
  //     if (userId == null) return;
  //     fetchAddressesstatusrequest = Statusrequest.loading;
  //     final response = await getAddressesData.getAddress(userId: userId!);

  //     fetchAddressesstatusrequest = handlingData(response);
  //     log("fetchAddressesstatusrequest $fetchAddressesstatusrequest");

  //     if (fetchAddressesstatusrequest == Statusrequest.success) {
  //       if (response['status'] == 'success' && response['data'].isNotEmpty) {
  //         addresses.clear();

  //         if (response['data'] is List) {
  //           addresses = (response['data'] as List)
  //               .map((e) => Datum.fromJson(e as Map<String, dynamic>))
  //               .toList();
  //           int myaddressId =
  //               myServises.sharedPreferences.getInt("default_address") ?? 0;
  //           if (myaddressId != addresses[0].addressId!) {
  //             myServises.sharedPreferences.setInt(
  //               "default_address",
  //               addresses[0].addressId!,
  //             );
  //           }
  //           log(
  //             "myaddressId ${myServises.sharedPreferences.getInt("default_address")}",
  //           );
  //         } else if (response['data'] is Map) {
  //           addresses = [
  //             Datum.fromJson(response['data'] as Map<String, dynamic>),
  //           ];
  //         }

  //         fetchAddressesstatusrequest = Statusrequest.success;
  //       }
  //       //  else {
  //       //   fetchAddressesstatusrequest = Statusrequest.failuer;
  //       // }
  //     }

  //     update();
  //   } catch (e) {
  //     fetchAddressesstatusrequest = Statusrequest.failuer;
  //     update();
  //   }
  //   log("fetchAddressesstatusrequest $fetchAddressesstatusrequest");
  // }

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
      },
    );
    update();
  }

  // @override
  // updateAddress(Datum address) async {
  //   if (userId == null) return;

  //   try {
  //     fetchAddressesstatusrequest = Statusrequest.loading;
  //     update();

  //     final response = await updateAddressesData.updateAddress(
  //       data: address.toJson(),
  //     );

  //     fetchAddressesstatusrequest = handlingData(response);

  //     if (fetchAddressesstatusrequest == Statusrequest.success) {
  //       if (response['status'] == 'success' && response['data'] != null) {
  //         Future.delayed(const Duration(seconds: 1), () {
  //           showCustomGetSnack(isGreen: true, text: "تم التعديل بنجاح");
  //         });
  //         fetchAddresses();
  //         fetchAddressesstatusrequest = Statusrequest.success;
  //       }
  //     } else {
  //       fetchAddressesstatusrequest = Statusrequest.failuer;
  //     }

  //     // update();
  //   } catch (e) {
  //     print(e);
  //     fetchAddressesstatusrequest = Statusrequest.failuer;
  //     update();
  //   }
  // }

  // @override
  // deleteAddress({required int addressId}) async {
  //   if (userId == null) return;
  //   int defaultAddressId =
  //       myServises.sharedPreferences.getInt("default_address") ?? 0;
  //   if (addressId == defaultAddressId) {
  //     myServises.sharedPreferences.setInt(
  //       "default_address",
  //       addresses[0].addressId!,
  //     );
  //     updateAddress(Datum(isDefault: 1, addressId: addresses[0].addressId!));
  //   }

  //   try {
  //     updateAddressesstatusrequest = Statusrequest.loading;

  //     final response = await removeAddresseData.removeAddresse(
  //       addressId: addressId,
  //     );

  //     updateAddressesstatusrequest = handlingData(response);

  //     if (updateAddressesstatusrequest == Statusrequest.success) {
  //       if (response['status'] == 'success') {
  //         fetchAddresses();
  //         updateAddressesstatusrequest = Statusrequest.success;
  //       }
  //     } else {
  //       updateAddressesstatusrequest = Statusrequest.failuer;
  //     }

  //     // update();
  //   } catch (e) {
  //     print(e);
  //     updateAddressesstatusrequest = Statusrequest.failuer;
  //     update();
  //   }
  // }

  // @override
  // void addAddess() {
  //   Get.toNamed(AppRoutesname.addAddresses);
  // }

  placesAutocomplete(String text) async {
    autoCompletestatusrequest = Statusrequest.loading;
    sessionToken ??= const Uuid().v4();

    // log("sessionToken: $sessionToken");
    var response = await mapPlacesServiese.fetchPredictions(
      text,
      sessionToken!,
      detectLangFromQuery(searchController.text),
    );
    // log("response: $response");
    // final status = handlingData(response);
    // if (status == Statusrequest.success) {
    if (response['status'] == 'OK') {
      final places = MapPlacesModel.fromJson(response);
      predictions.clear();
      predictions = places.predictions;

      autoCompletestatusrequest = Statusrequest.success;
    } else {
      autoCompletestatusrequest = Statusrequest.failuer;
      // }
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
        searchController.clear();
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

  // @override
  // Future<void> updateAddress(Address address) async{

  //   updateAddressesstatusrequest = Statusrequest.loading;
  //   update();

  //   final result = await addAddressRepo.updateAddress(address: address);

  //   result.fold(
  //     (failure) {
  //       updateAddressesstatusrequest = Statusrequest.failuer;
  //       update();
  //       showCustomGetSnack(isGreen: false, text: failure.errorMessage);
  //     },
  //     (successMessage) {
  //       updateAddressesstatusrequest = Statusrequest.success;
  //       update();
  //       showCustomGetSnack(isGreen: true, text: successMessage);
  //     },
  //   );
  // }
}
