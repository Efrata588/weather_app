class WeatherModel {
  final double latitude;
  final double longitude;
  final double temperature;
  final double apparentTemperature;
  final double windSpeed;
  final int humidity;
  final double precipitation;
  final int weatherCode;
  // final List<HourlyForecast>? hourlyForecasts;

  WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.apparentTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.precipitation,
    // this.hourlyForecasts,
  });

  //now to the method that converts json/map to wethermodel object

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final lat = json['latitude']?.toDouble() ?? 0.0;
    final lon = json['longitude']?.toDouble() ?? 0.0;
    final current = json['current'];

    return WeatherModel(
      latitude: lat,
      longitude: lon,
      temperature: current['temperature_2m']?.toDouble() ?? 0.0,
      apparentTemperature: current['apparent_temperature']?.toDouble() ?? 0.0,
      humidity: current['relative_humidity_2m'] ?? 0,
      windSpeed: current['wind_speed_10m']?.toDouble() ?? 0.0,
      precipitation: current['precipitation']?.toDouble() ?? 0.0,
      weatherCode: current['weather_code'] ?? 0,
    );
  }

  //for shared prefferences

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'temperature': temperature,
    'apparentTemperature': apparentTemperature,
    'humidity': humidity,
    'windSpeed': windSpeed,
    'precipitation': precipitation,
    'weatherCode': weatherCode,
  };
}

class HourlyForecast {
  final double temprature;
  final String time;
  final int weatherCode;

  HourlyForecast({
    required this.temprature,
    required this.time,
    required this.weatherCode,
  });
}
