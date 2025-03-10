import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/CustomButton.dart';
import 'package:shimmer/shimmer.dart';

import 'Loading.dart';

class Helper {
  static ImageProvider loadImageProvider(String url, String assetsPath) {
    if (url.isNotEmpty) {
      bool validUrl = Uri.parse(url).isAbsolute;
      if (validUrl) {
        return CachedNetworkImageProvider(url);
      } else {
        return AssetImage('assets/images/$assetsPath');
      }
    } else {
      return AssetImage('assets/images/$assetsPath');
    }
  }

  static Widget loadNetworkImage({
    String url = '',
    required String assetsErrorPath,
    BoxFit fit = BoxFit.cover,
    double width = double.infinity,
    double minShimmerHeight = 50,
    double? imageHeight,
  }) {
    if (imageHeight != null) {
      minShimmerHeight = imageHeight;
    }

    Widget errorWidget() => Image(
          height: imageHeight,
          width: width,
          fit: fit,
          image: AssetImage(
            assetsErrorPath,
          ),
        );

    if (url.isNotEmpty) {
      bool validUrl = Uri.parse(url).isAbsolute;
      if (validUrl) {
        return CachedNetworkImage(
          height: imageHeight,
          imageUrl: url,
          fit: fit,
          width: width,
          placeholder: (ctx, str) => Container(
            constraints: BoxConstraints(minHeight: minShimmerHeight),
            child: Shimmer(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade300,
                  Colors.grey.shade400,
                ],
              ),
              child: const SizedBox(),
            ),
          ),
          errorWidget: (ctx, str, obj) => errorWidget(),
        );
      } else {
        return errorWidget();
      }
    } else {
      return errorWidget();
    }
  }

  static Widget buildShimmer({
    required double width,
    required double height,
    required double roundness,
  }) {
    return Shimmer(
      gradient: LinearGradient(colors: [
        Colors.grey.shade300,
        Colors.grey.shade400,
        Colors.grey.shade300,
      ]),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(roundness),
        ),
        width: width,
        height: height,
      ),
    );
  }

  static FutureOr<T> showLoading<T>(
    String title,
    String content,
    Future<T> Function() future,
  ) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          content: Loading(
            title: title,
            content: content,
          ),
        ),
      ),
    );

    T res = await future();
    Get.back();
    return res;
  }

  static bool isValidEmail(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  static void showSnackBarMessage(
    BuildContext context,
    String content,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      showCloseIcon: true,
    ));
  }

  static Future<void> showMessage(
    String title,
    String message, {
    IconData? icon,
    Color? iconColor,
  }) async {
    await showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(Get.context!).cardColor,
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: 90,
                      color: iconColor,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "حسنا",
                verticalPadding: 10,
                borderWidth: 1,
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showBottomSheetWidget(
    Widget child,
  ) async {
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (ctx) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            expand: false,
            maxChildSize: 1,
            builder: (ctx, ctrl) => SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                controller: ctrl,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool> showYesNoMessage(
    String title,
    String message, {
    IconData? icon,
    Color? iconColor,
  }) async {
    bool? ok = await showDialog<bool>(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(Get.context!).cardColor,
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: 90,
                      color: iconColor,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "نعم",
                      onTap: () {
                        Get.back<bool>(result: true);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomButton(
                      text: 'لا',
                      onTap: () {
                        Get.back<bool>(result: false);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return ok ?? false;
  }

  static Size size(BuildContext context) => MediaQuery.of(context).size;

  static Widget loadingWidget() => Center(
        child: CircularProgressIndicator(
          color: MyColors.mainColor,
        ),
      );
}
