// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, unnecessary_new, no_leading_underscores_for_local_identifiers, unused_element, sized_box_for_whitespace, prefer_final_fields, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/main.dart';
import 'package:weatherapp/shared/gradient_scaffold.dart';
import 'package:weatherapp/shared/key.dart';
import 'package:weatherapp/shared/locationpermission.dart';
import 'package:weatherapp/shared/search_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Stuff for the Geocoding API
  final TextEditingController _cityNameController = TextEditingController();
  String _output = '';
  

  // Stuff for the OpenWeatherMap API
  //String _apiKey = '4175174f9f561eb404ce5dc34ab95555';
  String _apiKey = OpenWeatherMapAPI.API_KEY;
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double? lat, lon;

  // Date
  DateTime? _date;

  // Location
  String? _city;
  String? _country;
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
  double? _windGust;
  double ? _windDegree;
  double? _humidity;
  double? _pressure;

  // Sunrise and sunset
  DateTime? _sunrise;
  DateTime? _sunset;

  // Timer for querying weather after every 5 minutes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    ws = new WeatherFactory(_apiKey);

    determinePosition().then((position) {
      queryWeather(position.latitude, position.longitude);
    });
    // queryWeather(null, null); // Query weather when the app starts
    // _timer = Timer.periodic(Duration(minutes: 5), (Timer t) => queryWeather(null, null));
    _timer = Timer.periodic(Duration(minutes: 5), (Timer t) => determinePosition().then((position) {
    queryWeather(position.latitude, position.longitude);
  }));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void queryWeather(double? lat, double? lon) async {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    // Get the current location of the device
    if (lat == null || lon == null) {
    Position position = await determinePosition();
    lat = position.latitude;
    lon = position.longitude;
    }


    Weather weather = await ws.currentWeatherByLocation(lat, lon);

    setState(() {
      _data = [weather];
      _date = weather.date;
      _city = weather.areaName;
      _country = weather.country;
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
      _humidity = weather.humidity;
      _pressure = weather.pressure;
      _windGust = weather.windGust;
      _windDegree = weather.windDegree;
      
      _state = AppState.FINISHED_DOWNLOADING;

    });
  }

  //Method to format the Date from 2024-03-21 18:40:34:00 to MMMM d, y
  String formatDate(DateTime? dateTime) {
  if (dateTime == null) {
    return "Unknown";
  }
    // Use 'MMMM d, y' for 'March 21, 2024' format
    return DateFormat('MMMM d, y').format(dateTime);
  }


  // Method to format DateTime to HH:MM instead of Date HH:MM:SS:
    String formatTime(DateTime? dateTime) {
      if (dateTime == null) {
        return "Unknown";
      }
        return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    }

  Widget actionButton(TextEditingController _cityNameController){
  return Padding(
    padding: const EdgeInsets.only(right: 25, top: 25),
    child: FloatingActionButton.small(
      onPressed: () async {
        List<Location> locations = await locationFromAddress(_cityNameController.text);
        //lat = locations.first.latitude;
        //lon = locations.first.longitude;
        queryWeather(locations.first.latitude, locations.first.longitude);
        setState(() {  
        });
        _cityNameController.clear();
      },
      child: Icon(Icons.search),
    ),
  );
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

    return GradientScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          queryWeather(null, null);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: searchBox(_cityNameController)),
              actionButton(_cityNameController)
            ],
          ),
          
  
            
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              // Row of texts
              child: Column(
                children: [
                Text(
                  (_city != null && _country != null ) ? '$_city, $_country' : "Searching..." ,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
                  ),
    
                  Text(
                  _date != null ? "${formatDate(_date).toString()}" : "Searching...",
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

            Center(
              child: Text(
                _weatherDescription ?? "Searching...",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GlassContainer(
                height: 80,
                width: 350,
                blur: 4,
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _windSpeed != null ? "${_windSpeed?.toStringAsFixed(2)} m/s" : "Searching",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                
                        Text("Wind")
                      ],
                    ),
                
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 0.3,
                      ),
                    ),

                    
                
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _humidity != null ? "${_humidity?.toStringAsFixed(0)}%" : "Searching",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                
                        Text("Humidity")
                      ],
                    ),
                
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 0.3,
                      ),
                    ),
                
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _pressure != null ? "${_pressure?.toStringAsFixed(0)} hPa" : "Searching",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                
                        Text("Pressure")
                      ],
                    ),
                    ]
                  ),
              ),
                ),
            ),
    
            SizedBox(height: 20),
        
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
                          padding: const EdgeInsets.all(7),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "Location",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                trailing: Icon(Icons.location_on, color: Colors.redAccent[700],size: 30,),
                              ),
        
                              Image.asset('assets/icons8-map-62.png', scale: 1),


                              Text(
                                  _latitude != null ? "Latitude: ${_latitude?.toStringAsFixed(4)}" : "Searching...",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                                  ),
                              Text(
                                  _longitude != null ? "Longitude: ${_longitude?.toStringAsFixed(4)}" : "Searching...",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
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
                                trailing: Icon(Icons.wb_cloudy, color: Colors.blue[300], size: 25,),
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
                      height: 180,
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
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(
                                  'Sunrise:',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    '${formatTime(_sunrise)}',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
                                  ),
                                trailing: Icon(Icons.wb_twilight_rounded, color: Colors.yellow, size: 35,),
                              ),

                              ListTile(
                                title: Text(
                                  'Sunset:',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    '${formatTime(_sunset)}',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
                                    ),
                                trailing: Icon(Icons.wb_twilight_rounded, color: Colors.yellow, size: 35,),
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
                      height: 240,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTile(
                                title: Text(
                                  "Temp",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                trailing: Icon(Icons.water_drop, color: Colors.white,),
                              ),

        
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      _currentTemperature != null ? "${_currentTemperature?.toStringAsFixed(0)}°C" : "Searching...",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 35),
                                      ),
                                  
                                  Image.asset(
                                    "assets/icons8-temperature-100-2.png",
                                    scale: 2,
                                    ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      'Min:',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                      ),
                                  
                                  Text(
                                  _minTemperature != null ? "${_minTemperature?.toStringAsFixed(0)}°C" : "Searching...",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      'Max:',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                      ),
                                  
                                  Text(
                                  _maxTemperature != null ? "${_maxTemperature?.toStringAsFixed(0)}°C" : "Searching...",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),
                                  ),
                                ],
                              ),
                                  
                            ],
                          ),
                        ),
                    ),
        
                    SizedBox(height: 20),
        
                   GlassContainer(
                      height: 140,
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
                                  _feelsLikeTemperature != null ? "${_feelsLikeTemperature?.toStringAsFixed(0)}°C" : "Searching...",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
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
                                  "Wind",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                trailing: Icon(Icons.wind_power, color: Colors.white,),
                              ),
        
                              Text(
                                  _windDegree != null ? "Degree: ${_windDegree?.toStringAsFixed(0)} m/s" : "Searching",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                                  ),

                              Text(
                                  _windGust != null ? "Gust: ${_windGust?.toStringAsFixed(0)} m/s" : "Searching",
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
        );
  }
  
}