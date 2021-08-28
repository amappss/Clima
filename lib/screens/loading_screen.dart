import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = new Location();
    await location.getCurrentLocation();
    latitude = location.latitude ?? 0.0;
    longitude = location.latitude ?? 0.0;
    var data = await NetworkingHelper().getLocationData(latitude, longitude);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen(data)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
