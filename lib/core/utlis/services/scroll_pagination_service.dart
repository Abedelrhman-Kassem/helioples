import 'package:flutter/material.dart';

class ScrollPaginationService {
  /// Check if scroll position is near the end and trigger pagination
  ///
  /// [scrollController] - The scroll controller to monitor
  /// [onLoadMore] - Callback function to trigger when near the end
  /// [offset] - Distance from bottom to trigger loading (default: 300)
  static void checkAndLoadMore({
    required ScrollController scrollController,
    required VoidCallback onLoadMore,
    double offset = 300,
  }) {
    if (scrollController.position.pixels >=
        (scrollController.position.maxScrollExtent - offset)) {
      onLoadMore();
    }
  }

  /// Add a listener to scroll controller for automatic pagination
  ///
  /// [scrollController] - The scroll controller to attach listener
  /// [onLoadMore] - Callback function to trigger when near the end
  /// [isLoading] - Whether data is currently being loaded
  /// [offset] - Distance from bottom to trigger loading (default: 300)
  static void addPaginationListener({
    required ScrollController scrollController,
    required VoidCallback onLoadMore,
    required bool Function() isLoading,
    double offset = 300,
  }) {
    scrollController.addListener(() {
      if (isLoading()) return;

      if (scrollController.position.pixels >=
          (scrollController.position.maxScrollExtent - offset)) {
        onLoadMore();
      }
    });
  }
}
