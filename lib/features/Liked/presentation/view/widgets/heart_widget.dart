import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/liked_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Liked/data/models/liked_model.dart';
import 'package:negmt_heliopolis/features/Liked/data/repo/liked_repo_imp.dart';

// ignore: must_be_immutable
class HeartWidget extends StatefulWidget {
  final bool isFavorite;
  final double width;
  final double height;
  final String productId;

  const HeartWidget({
    super.key,
    required this.isFavorite,
    required this.width,
    required this.height,
    required this.productId,
  });

  @override
  State<HeartWidget> createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget>
    with TickerProviderStateMixin {
  late AnimationController _favoriteAnimationController;
  late Animation<double> _favoriteScaleAnimation;

  late LikedRepoImp likedRepoImp;
  late PostLikedModel postLikedModel;

  LikedNotifier likedNotifier = LikedNotifier();

  @override
  void initState() {
    super.initState();

    likedRepoImp = LikedRepoImp(ApiService());
    postLikedModel = PostLikedModel.fromJson({});
    postLikedModel.data = widget.isFavorite;

    _favoriteAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _favoriteScaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _favoriteAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void postLike() async {
    try {
      var res = await likedRepoImp.postLikedProduct(widget.productId);
      log(res.data.toString());

      if (res.statusCode! < 400) {
        postLikedModel = PostLikedModel.fromJson(res.data);
        likedNotifier.productValue = widget.productId;
        likedNotifier.triggerNotification();
      }
    } catch (e) {
      postLikedModel.data = !postLikedModel.data!;
      if (e is DioException) {
        showCustomGetSnack(
            duration: const Duration(seconds: 10),
            isGreen: false,
            text: ServerFailure.fromDioError(e).errorMessage);

        // CustomSnackBar.show(
        //   context: context,
        //   duration: const Duration(seconds: 10),
        //   text: ServerFailure.fromDioError(e).errorMessage,
        //   isGreen: false,
        // );
        return;
      }
      showCustomGetSnack(
          duration: const Duration(seconds: 10),
          isGreen: false,
          text: ServerFailure(e.toString()).errorMessage);

      // CustomSnackBar.show(
      //   context: context,
      //   duration: const Duration(seconds: 10),
      //   text: ServerFailure(e.toString()).errorMessage,
      //   isGreen: false,
      // );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _favoriteAnimationController.dispose();
  }

  void _toggleFavorite() {
    postLikedModel.data = !postLikedModel.data!;

    if (postLikedModel.data!) {
      _favoriteAnimationController
          .forward()
          .then((_) => _favoriteAnimationController.reverse());
    } else {
      _favoriteAnimationController.reverse();
    }

    postLike();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _favoriteScaleAnimation,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _toggleFavorite();
          });
        },
        child: svgIcon(
          path: 'assets/svg_icons/white-heart.svg',
          color: postLikedModel.data!
              ? MyColors.mainColor
              : const Color.fromRGBO(181, 185, 190, 1),
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}
