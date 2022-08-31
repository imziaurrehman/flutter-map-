import 'package:flutter/material.dart';
import 'package:location/location.dart';

class UserLocation with ChangeNotifier {
  bool? _serviceEnabled;
  PermissionStatus? _permissionStatus;
  final Location _location = Location();
  double? lat;
  double? lon;
  double? get getLat => lat;
  double? get getLon => lon;
  Future getUserCurrentLoc() async {
    LocationData locationData;
    locationData = await _location.getLocation();
    lat = locationData.latitude;
    lon = locationData.longitude;
    print(lat.toString());
    print(lon.toString());
    notifyListeners();
  }

  Future userLocationStatus() async {
    _serviceEnabled = await _location.serviceEnabled();
    _serviceEnabled ??= await _location.requestService();
    if (_serviceEnabled == null) {
      return;
    }
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      return _permissionStatus;
    }
    if (_permissionStatus != PermissionStatus.granted) {
      return;
    }
    // _locationData =await _location.getLocation();
    notifyListeners();
  }
}
