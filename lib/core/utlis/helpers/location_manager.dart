import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';

class LocationManager {
  /// Orchestrates the entire permission flow:
  /// 1. Check current status.
  /// 2. If denied/unknown, show custom rationale dialog.
  /// 3. If user agrees, request system permission.
  /// 4. If granted, get location and save to storage.
  static Future<void> handlePermissionFlow(BuildContext context) async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // 1. Check if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log('Location services are disabled.');
        // Optionally ask user to enable location services
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // 2. Show custom rationale dialog
        if (context.mounted) {
          final bool userAgreed = await showRationaleDialog(context);
          if (!userAgreed) {
            log('User declined custom rationale dialog.');
            return;
          }
        }

        // 3. Request system permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        log(
          'Location permissions are permanently denied, we cannot request permissions.',
        );
        return;
      }

      // 4. Get location and save
      await _getLocationAndSave();
    } catch (e) {
      log('Error in location permission flow: $e');
    }
  }

  static Future<bool> showRationaleDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Location Access Required'),
              content: const Text(
                'We need your location to show you products available in your area. Products and offers may vary by location.',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Later'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text('Allow'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  static Future<void> _getLocationAndSave() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      log('Location obtained: ${position.latitude}, ${position.longitude}');

      // Save to secure storage
      await CacheHelper.instance.saveLocal(
        'user_lat',
        position.latitude.toString(),
      );
      await CacheHelper.instance.saveLocal(
        'user_long',
        position.longitude.toString(),
      );

      log('Location saved to secure storage.');
    } catch (e) {
      log('Error getting or saving location: $e');
    }
  }
}
