// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unnecessary_new, no_leading_underscores_for_local_identifiers, unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/main.dart';
import 'package:weatherapp/shared/gradient_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _apiKey = '4175174f9f561eb404ce5dc34ab95555';
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double? lat = 35.19899;
  double? lon = -97.44490;

  // Date
  DateTime? _date;

  // Location
  String? _location;
  double? _latitude;
  double? _longitude;

  // Temperature readings
  double? _currentTemperature;
  double? _maxTemperature;
  double? _minTemperature;
  double? _feelsLikeTemperature;

  // Weather pattern
  String? _weatherDescription;
  int? _weatherConditionCode;
  double? _windSpeed;

  // Sunrise and sunset
  DateTime? _sunrise;
  DateTime? _sunset;

  // Timer for querying weather after every 5 minutes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    ws = new WeatherFactory(_apiKey);
    //queryWeather(); // Query weather when the app starts
    _timer = Timer.periodic(Duration(minutes: 5), (Timer t) => queryWeather());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void queryWeather() async {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByLocation(lat!, lon!);

    setState(() {
      _data = [weather];
      _date = weather.date;
      _location = weather.areaName;
      _latitude = weather.latitude;
      _longitude = weather.longitude;
      _currentTemperature = weather.temperature!.celsius;
      _maxTemperature = weather.tempMax!.celsius;
      _minTemperature = weather.tempMin!.celsius;
      _feelsLikeTemperature = weather.tempFeelsLike!.celsius;
      _weatherDescription = weather.weatherDescription;
      _weatherConditionCode = weather.weatherConditionCode;
      _windSpeed = weather.windSpeed;
      _sunrise = weather.sunrise;
      _sunset = weather.sunset;
      
      _state = AppState.FINISHED_DOWNLOADING;

    });


  }

  // Method to getWeatherCondition Code and return the path of an image
    String getImagePath(int? _weatherConditionCode) {
      if (_weatherConditionCode == null) {
        return 'assets/cloudy-sunny.png';
      } else if (_weatherConditionCode >= 300 && _weatherConditionCode <= 321) {
        return 'assets/light-rain.png';
      } else if (_weatherConditionCode >= 300 && _weatherConditionCode <= 321) {
        return 'assets/light-rain.png';
      } else if (_weatherConditionCode >= 500 && _weatherConditionCode <= 531) {
        return 'assets/rain.png';
      } else if (_weatherConditionCode >= 600 && _weatherConditionCode <= 622) {
        return 'assets/sunny-clear.png';
      } else if (_weatherConditionCode >= 701 && _weatherConditionCode <= 781) {
        return 'assets/cloudy-sunny.png';
      } else if (_weatherConditionCode == 800) {
        return 'assets/sunny-clear.png';
      } else /*if (_weatherConditionCode >= 801 && _weatherConditionCode <= 804) */ {
        return 'assets/cloudy-sunny.png';
      }
    }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GradientScaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            queryWeather();
          },
          // The FutureBilder performs an asynchronous operation and update the UI based on the result
          // It has solved the issue of weather not being queried in the 'initState' of the app
          // The issue probably arised because when the app starts, Flutter builds the UI before the queryWeather method
          // has a chance to finish, so the inital data shown might be outdated
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                // Row of texts
                child: Column(
                  children: [
                  Text(
                    _location ?? "Searching...",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
                    ),

                    Text(
                    "March 20, 2024",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ]
                ),
              ),

              SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(getImagePath(_weatherConditionCode))
                ),

              Center(
                child: Text(
                  _currentTemperature != null ? "${_currentTemperature?.toStringAsFixed(0)}°C" : "Searching...",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 55),
                ),
              ),

              SizedBox(height: 10),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      GlassContainer(
                        height: 200,
                        width: 180,
                        blur: 5,
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(35),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.blue.withOpacity(0.3)
                          ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Location",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                  trailing: Icon(Icons.location_on_outlined, color: Colors.white,),
                                ),
          
                                Text(
                                    _location ?? "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                Text(
                                    _latitude != null ? "Latitude: ${_latitude?.toStringAsFixed(2)}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                Text(
                                    _longitude != null ? "Longitude: ${_longitude?.toStringAsFixed(2)}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                              ],
                            ),
                          ),
                      ),
          
                      SizedBox(height: 20),
          
                      GlassContainer(
                        height: 160,
                        width: 180,
                        blur: 5,
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(35),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.blue.withOpacity(0.3)
                          ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Weather",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                  trailing: Icon(Icons.wb_cloudy_outlined, color: Colors.white,),
                                ),
          
                                Text(
                                    _weatherDescription ?? "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),

                                Text(
                                    _weatherConditionCode != null ? "Code: ${_weatherConditionCode?.toString()}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                              ],
                            ),
                          ),
                      ),
          
                      SizedBox(height: 20),
          
                      GlassContainer(
                        height: 300,
                        width: 180,
                        blur: 5,
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(35),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.blue.withOpacity(0.3)
                          ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Sunrise",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                  trailing: Icon(Icons.wb_twilight_rounded, color: Colors.white,),
                                ),
          
                                Text(
                                    _sunrise != null ? "Sunrise: ${_sunrise?.toString()}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                Text(
                                    _sunset != null ? "Sunset: ${_sunset?.toString()}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                
                              ],
                            ),
                          ),
                      ),
          
                    ],
                  ),
          
                  // Second column of boxes inside the row
                  Column(
                    children: [
                      GlassContainer(
                        height: 300,
                        width: 180,
                        blur: 5,
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(35),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.blue.withOpacity(0.3)
                          ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Temp",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                  trailing: Icon(Icons.water_drop_outlined, color: Colors.white,),
                                ),
          
                                Text(
                                    _currentTemperature != null ? "Temperature: ${_currentTemperature?.toStringAsFixed(2)}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                Text(
                                    _minTemperature != null ? "Min Temp: ${_minTemperature?.toStringAsFixed(2)}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                Text(
                                    _maxTemperature != null ? "Max Temp: ${_maxTemperature?.toStringAsFixed(2)}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                              ],
                            ),
                          ),
                      ),
          
                      SizedBox(height: 20),
          
                     GlassContainer(
                        height: 200,
                        width: 180,
                        blur: 5,
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(35),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.blue.withOpacity(0.3)
                          ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Feels like",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                  trailing: Icon(Icons.hot_tub, color: Colors.white,),
                                ),
          
                                Text(
                                    _feelsLikeTemperature != null ? "${_feelsLikeTemperature?.toStringAsFixed(2)}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                              ],
                            ),
                          ),
                      ),
          
                      SizedBox(height: 20),
          
                      GlassContainer(
                        height: 160,
                        width: 180,
                        blur: 5,
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(35),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.blue.withOpacity(0.3)
                          ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Date",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                  trailing: Icon(Icons.date_range_outlined, color: Colors.white,),
                                ),
          
                                Text(
                                    _date != null ? "Date: ${_date?.toString()}" : "Searching...",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                              ],
                            ),
                          ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )
      ),
    )
    );
  }
  
}