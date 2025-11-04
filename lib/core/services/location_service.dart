import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

final locationService = Provider(
  (ref) => LocationService(Location(), GeolocatorPlatform.instance),
);

class LocationService {
  final Location _location;
  final GeolocatorPlatform _geoLocator;
  const LocationService(Location location, GeolocatorPlatform geoLocator)
    : _location = location,
      _geoLocator = geoLocator;

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    try {
      serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
      }

      permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied ||
          permissionGranted == PermissionStatus.deniedForever) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      final token = RootIsolateToken.instance;

      /// add a isolate to get the current location
      final currentPosition = await Isolate.run(() {
        BackgroundIsolateBinaryMessenger.ensureInitialized(token!);
        return _geoLocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            distanceFilter: 100,
            timeLimit: Duration(seconds: 20),
          ),
        );
      });
      LocalAppStorage.location = {
        'latitude': currentPosition.latitude,
        'longitude': currentPosition.longitude,
      };
      // [currentPosition.longitude, currentPosition.latitude];
      log.d('currentPosition: $currentPosition');
      return currentPosition;
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: 'User cant get current location',
      );
      return null;
    }
  }

  Stream<LocationData> onLocationChange() {
    return _location.onLocationChanged;
  }
}
