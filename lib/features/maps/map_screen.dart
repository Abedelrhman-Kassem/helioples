import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:negmt_heliopolis/controller/map/address_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/handlingdataviwe.dart';
import 'package:negmt_heliopolis/features/maps/widget/shaimmer_botton_widget.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:negmt_heliopolis/features/Widgets/bluer_dilog.dart';
import 'package:negmt_heliopolis/features/maps/widget/add_location.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class MapScreen extends StatefulWidget {
  final bool? isUsOne;
  const MapScreen({super.key, this.isUsOne});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String? _mapStyle;

  @override
  void initState() {
    super.initState();
    _initializeMapRenderer();
    _loadMapStyle();
  }

  void _initializeMapRenderer() {
    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = true;
    }
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_style.json');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<AddressControllerImpl>();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AddressControllerImpl());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<AddressControllerImpl>(
        builder: (getxcontroller) {
          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                onTap: (position) {
                  getxcontroller.ubdataCameraPosition(
                    isontap: true,
                    latLngg: position,
                  );
                },
                markers: getxcontroller.newmarker,
                style: _mapStyle,
                onMapCreated: (controller) {
                  getxcontroller.mapController = controller;
                  getxcontroller.ubdataCameraPosition();
                },

                initialCameraPosition: getxcontroller.initialCameraPosition,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 50.h),
                decoration: BoxDecoration(
                  // color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5.h),
                    SizedBox(
                      height: 40.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            returnArrow(
                              context: context,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                StringTranslateExtension(
                                  LocaleKeys.set_location_screen_skip,
                                ).tr(),
                                style: Styles.styles16w400grey.copyWith(
                                  color: const Color.fromRGBO(0, 126, 143, 1),
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      StringTranslateExtension(
                        LocaleKeys.set_location_screen_choose_delivery_location,
                      ).tr(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Handlingdataviwe(
                  statusrequest: getxcontroller.mapstatusrequest,
                  shimmer: LocationInfoShimmer(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  widget: SizedBox(
                    width: double.infinity,
                    // height: 220.h,
                    child: Material(
                      elevation: 8.0.sp,
                      shape: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          strokeAlign: 3,
                        ),
                      ),
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 25.w,
                                    top: 15.h,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringTranslateExtension(
                                          LocaleKeys
                                              .set_location_screen_location_info,
                                        ).tr(),
                                        style: Styles.styles14w400NormalBlack
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        "${getxcontroller.country}, ${getxcontroller.city}",
                                        style: Styles.styles11w600Black
                                            .copyWith(
                                              fontSize: 26,
                                              color: const Color.fromRGBO(
                                                40,
                                                40,
                                                40,
                                                1,
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  getxcontroller.ubdataCameraPosition();
                                },
                                child: Image.asset(
                                  "assets/Icons_logos/location.png",
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: Text(
                              "${getxcontroller.street}, ${getxcontroller.administrativeArea}, ${getxcontroller.city}",
                              style: Styles.styles14w400NormalBlack.copyWith(
                                color: const Color.fromRGBO(70, 70, 70, 1),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Center(
                            child: SignUpCustomButton(
                              buttonText: StringTranslateExtension(
                                LocaleKeys.add_location_confirm_location,
                              ).tr(),
                              onPressed: () {
                                blurDilog(
                                  Addlocattion(
                                    latLngg: getxcontroller.latLng,
                                    isUsOne: widget.isUsOne ?? false,
                                  ),
                                  context,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              GetBuilder<AddressControllerImpl>(
                id: "search",
                builder: (cont) {
                  return cont.isSearch
                      ? Positioned(
                          top: 200.h,
                          left: 0.w,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),

                            height: 950.h,
                            child: Column(
                              children: [
                                // SizedBox(height: 10.h),
                                Expanded(
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      final place = cont.predictions[index];
                                      return ListTile(
                                        trailing: Icon(
                                          Icons.arrow_circle_right_outlined,
                                          color: MyColors.mainColor,
                                        ),
                                        leading: Icon(
                                          Icons.fmd_good_sharp,
                                          color: MyColors.mainColor,
                                        ),
                                        title: Text(
                                          place.description.toString(),
                                        ),

                                        onTap: () async {
                                          cont.fetchPlaceDetails(
                                            place.placeId.toString(),
                                          );
                                          cont.closeSearch();
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Divider(),

                                    itemCount: cont.predictions.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container();
                },
              ),

              Positioned(
                top: 145.h,
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
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: getxcontroller.searchController,
                          focusNode: getxcontroller.searchFocusNode,
                          decoration: InputDecoration(
                            hintText: StringTranslateExtension(
                              LocaleKeys.set_location_screen_find_a_place,
                            ).tr(),
                            hintStyle: Styles.styles14w400NormalBlack.copyWith(
                              color: const Color.fromRGBO(141, 145, 150, 1),
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color.fromRGBO(41, 45, 50, 1),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                          ),
                          onChanged: (query) {
                            if (query.isNotEmpty) {
                              getxcontroller.search(query);
                            } else {
                              getxcontroller.closeSearch();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
