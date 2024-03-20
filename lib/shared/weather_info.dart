class WeatherInfo {
  //Location
  // Date
  DateTime? date;

  // Location
  String? location;
  double? latitude;
  double? longitude;

  // Temperature readings
  double? currentTemperature;
  double? maxTemperature;
  double? minTemperature;
  double? feelsLikeTemperature;

  // Weather pattern
  String? weatherDescription;
  double? windSpeed;

  // Sunrise and sunset
  DateTime? sunrise;
  DateTime? sunset;

  WeatherInfo ({
    this.date,
    this.location,
    this.latitude,
    this.longitude,
    this.currentTemperature,
    this.maxTemperature,
    this.minTemperature,
    this.feelsLikeTemperature,
    this.weatherDescription,
    this.windSpeed,
    this.sunrise,
    this.sunset
  });

}