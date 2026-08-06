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
    // Safely parse temperature whether it's stored as double, int, or missing
    double parsedTemp = 0.0;
    if (json['temperature'] != null) {
      parsedTemp = double.tryParse(json['temperature'].toString()) ?? 0.0;
    }

    return HourlyForecast(
      time: json['time']?.toString() ?? '',
      temperature: parsedTemp,
      weatherCode: json['weatherCode'] is int
          ? json['weatherCode']
          : int.tryParse(json['weatherCode']?.toString() ?? '0') ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
    'time': time,
    'temperature': temperature,
    'weatherCode': weatherCode,
  };
}
