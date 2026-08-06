class WeatherModel {
  final double latitude;
  final double longitude;
  final double temperature;
  final double apparentTemperature;
  final double windSpeed;
  final int humidity;
  final double precipitation;
  final int weatherCode;
  final String currentTime;
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
    required this.currentTime,
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
      currentTime: current['time']?.toString() ?? '',
    );
  }

  //for shared prefferences

  // Map<String, dynamic> toJson() => {
  //   'latitude': latitude,
  //   'longitude': longitude,
  //   'temperature': temperature,
  //   'apparentTemperature': apparentTemperature,
  //   'humidity': humidity,
  //   'windSpeed': windSpeed,
  //   'precipitation': precipitation,
  //   'weatherCode': weatherCode,
  // };
}

class HourlyForecast {
  final double temperature;
  final String time;
  final int weatherCode;

  HourlyForecast({
    required this.temperature,
    required this.time,
    required this.weatherCode,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    final time = json['time']?.toDouble() ?? 0.0;
    final temperature = json['temperature']?.toDouble() ?? 0.0;
    final weathercode = json['weatherCode'];

    return HourlyForecast(
      temperature: temperature,
      time: time,
      weatherCode: weathercode,
    );
  }
  Map<String, dynamic> toJson() => {
    'time': time,
    'temperature': temperature,
    'weatherCode': weatherCode,
  };
}
