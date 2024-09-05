import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';

import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/place.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/place_suggestion.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view%20model/set_location_cubit/set_location_cubit.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/place_item.dart';

import 'package:uuid/uuid.dart';

import '../view model/set_location_cubit/set_location_state.dart';
import 'widgets/sign_up_custom_button.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  List<PlaceSuggestion> places = [];
  late GoogleMapController googleMapController;
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSuggestionsVisible = false;
  Completer<GoogleMapController> _mapController = Completer();

  // these variables for getPlaceLocation
  Set<Marker> markers = Set();
  late PlaceSuggestion placeSuggestion;
  late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;
  static Position? position;
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position?.latitude ?? 30.0, position?.longitude ?? 31.0),
    tilt: 0.0,
    zoom: 17,
  );

  late Future<String> locationFuture = Future.value('');


// Future<void> customMarker() async {
//   try {
//     print("ana gwa el try");
//     BitmapDescriptor custom = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(48, 48)),
//       "assets/Icons_logos/location marker.png",
//     );

//     setState(() {
//       customIcon = custom;
//     });
//   } catch (e) {
//     print("Error loading custom marker icon: $e");
//   }
// }

  getCurrentLocation() async {
    bool serviceIsEnabled;
    LocationPermission permission;

    serviceIsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceIsEnabled) {
      // Handle the case when location services are not enabled
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case when location permission is denied
        return;
      }
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      print("Latitude: ${position.latitude}");
      print("Longitude: ${position.longitude}");

      // Load the custom marker icon and update the UI
      BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(100, 100)),
        "assets/Icons_logos/current_location_marker.png",
      );

      setState(() {
        currentLocationMarker = Marker(
          markerId: MarkerId("current_location"),
          position: LatLng(position.latitude, position.longitude),
          icon: customIcon,
          infoWindow: InfoWindow(title: "My Location"),
        );

        markers.add(currentLocationMarker);

        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 17,
        );

        // Move the camera to the current location
        googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        locationFuture = codingLocation(position.latitude, position.longitude);
      });
    }
  }

  Future<String> codingLocation(double x, double y) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(x, y);
    String loc =
        "${placemarks[0].subAdministrativeArea} ${placemarks[0].locality} ";
    return loc;
  }

  void buildCamerNewPosition() {
    goToSearchedForPlace = CameraPosition(
        target: LatLng(selectedPlace.result.geometry.location.lat,
            selectedPlace.result.geometry.location.lng),
        zoom: 14);
  }

  Widget buildSuggestionBloc() {
    return BlocBuilder<MapsCubit, MapsState>(builder: (context, state) {
      if (state is PlacesLoaded) {
        places = state.places;
        if (places.isNotEmpty && isSuggestionsVisible) {
          return buildPlacesList();
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    });
  }

  Widget buildPlacesList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              placeSuggestion = places[index];
              getSelectedPlaceLocation();

              searchController.text = places[index].description;
              searchController.clear();
              focusNode.unfocus();
              setState(() {
                isSuggestionsVisible = false;
              });
            },
            child: PlaceItem(
              suggestion: places[index],
            ),
          );
        },
        itemCount: places.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }

  void getPlacesSuggestions(String query) {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceSuggestions(query, sessionToken);
  }

  void getSelectedPlaceLocation() {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceLocation(placeSuggestion.placeId, sessionToken);
  }

  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          selectedPlace = (state).place;

          goToMySearchedForLocation();
        }
      },
      child: Container(),
    );
  }

  Future<void> goToMySearchedForLocation() async {
    buildCamerNewPosition();
    final GoogleMapController controller = await _mapController.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
    buildSearchedPlaceMarker();
  }

  buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      position: goToSearchedForPlace.target,
      markerId: MarkerId('1'),
      infoWindow: InfoWindow(title: "${placeSuggestion.description}"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
      locationFuture = codingLocation(goToSearchedForPlace.target.latitude,
          goToSearchedForPlace.target.longitude);
    });
  }

  @override
  void initState() {
    super.initState();

    getCurrentLocation();

    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        getPlacesSuggestions(searchController.text);
        setState(() {
          isSuggestionsVisible = true;
        });
      } else {
        setState(() {
          isSuggestionsVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _myCurrentLocationCameraPosition,
            onMapCreated: (controller) async {
              _mapController.complete(controller);
              googleMapController = controller;
              //customMarker();
              
              String style = await DefaultAssetBundle.of(context)
                  .loadString('assets/map_style.json');
              googleMapController.setMapStyle(style);
            },
            markers: markers,
            onTap: (LatLng latlng) {
 
              
              
              searchedPlaceMarker = Marker(
      position: latlng,
      markerId: MarkerId('1'),
      infoWindow: InfoWindow(title: "${placeSuggestion.description}"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
     
    );
     addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
              
            },
          ),
          Column(
            children: [
              SizedBox(height: 70.h),
              SizedBox(
                height: 40.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            size: 36, color: Color.fromRGBO(41, 45, 50, 1)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle skip action
                        },
                        child: GestureDetector(
                          onTap: (){
                             Navigator.of(context).pushNamed(notificationScreen);
                          },
                          child: Text(
                            "Skip",
                            style: Styles.styles16w400grey.copyWith(
                                color: const Color.fromRGBO(0, 126, 143, 1) , fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Choose Delivery Location",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child:
                      Container()), // Filler to push the TextField to the bottom
            ],
          ),
          Positioned(
            top: 150.h,
            left: 20.w,
            right: 20.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        hintText: 'Find a place...',
                        hintStyle: Styles.styles14w400NormalBlack.copyWith(
                            color: const Color.fromRGBO(141, 145, 150, 1)),
                        prefixIcon: Icon(Icons.search,
                            color: const Color.fromRGBO(41, 45, 50, 1)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                      onSubmitted: (query) {
                        getPlacesSuggestions(query);
                      },
                    ),
                  ),
                  if (isSuggestionsVisible) 
                  buildSuggestionBloc(),
                  buildSelectedPlaceLocationBloc(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: 230.h,
              child: Material(
                elevation: 8.0.sp,
                shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                    strokeAlign: 3 ,
                  )
                ),

                color: Colors.white,
                shadowColor: Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25.w , top: 15.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Location Info",
                                style: Styles.styles14w400NormalBlack.copyWith(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Cairo, Egypt",
                                style: Styles.styles11w600Black
                                    .copyWith(fontSize: 26 , color: const  Color.fromRGBO(40, 40, 40, 1)),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Image.asset("assets/Icons_logos/location.png")
                      ],
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: 25.w),
                      child: FutureBuilder<String>(
                          future: locationFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Loading location...",
                                    style: Styles.styles14w400NormalBlack),
                              );
                            } else if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Error: ${snapshot.error}",
                                    style: Styles.styles14w400NormalBlack),
                              );
                            } else if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: Styles.styles14w400NormalBlack.copyWith(color: const Color.fromRGBO(70, 70, 70, 1)),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No location found",
                                    style: Styles.styles14w400NormalBlack),
                              );
                            }
                          }),
                    ),
                        SizedBox(
                          height: 16.h,
                        ),
                      Center(child: SignUpCustomButton(buttonText: "Continue", onPressed: (){
                         Navigator.of(context).pushNamed(notificationScreen);
                      }))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
