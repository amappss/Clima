import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/networking.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();

  LocationScreen(this.data);
  final data;
}

class _LocationScreenState extends State<LocationScreen> {
  int condition;
  String city;
  int temp;
  String weatherIcon;
  String message;
  @override
  void initState() {
    super.initState();
    updateUI(widget.data);
  }

  void updateUI(dynamic data) {
    setState(() {
      if (data == null) {
        condition = 0;
        city = "Error";
        temp = 0;
        weatherIcon = "";
        message = "";
        return;
      }
      condition = data['weather'][0]['id'];
      city = data['name'];
      double tmp = data['main']['temp'];
      temp = tmp.toInt();
      weatherIcon = WeatherModel().getWeatherIcon(condition);
      message = WeatherModel().getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      Location location = new Location();
                      await location.getCurrentLocation();
                      double latitude = location.latitude ?? 0.0;
                      double longitude = location.latitude ?? 0.0;
                      var data = await NetworkingHelper()
                          .getLocationData(latitude, longitude);
                      updateUI(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (result != null) {
                        print(result);
                        var data = await NetworkingHelper().getCityData(result);
                        updateUI(data);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
