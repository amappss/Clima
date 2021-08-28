import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const key = '273714cc0474033ce7700d9a8eda2b1b';

class NetworkingHelper {
  Future<dynamic> getCityData(String city) async {
    http.Response response = await http.get(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$key&units=metric',
    );
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> getLocationData(double latitude, double longitude) async {
    http.Response response = await http.get(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$key&units=metric',
    );
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
  }
}
