import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather_model.dart';

class WeatherDatasource {
  final Dio _dio = Dio();

  final String apiUrl =
      "https://api.open-meteo.com/v1/forecast?latitude=8.9806&longitude=38.7578&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m,wind_direction_10m";

  Future<WeatherModel> fetchWeather() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;
        final weather = WeatherModel.fromJson(jsonData);

        //cach

        final currentHourRecord = HourlyForecast(
          time: weather.currentTime,
          temperature: weather.temperature,
          weatherCode: weather.weatherCode,
        );

        await _saveHourlyRecordLocally(
          currentHourRecord,
          "HOURLY_WEATHER_HISTORY",
        );
        return weather;
      } else {
        throw Exception("Failed to load server data");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  Future<void> _saveHourlyRecordLocally(
    HourlyForecast newRecord,
    String hourlyHistoryKey,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> existingList = prefs.getStringList(hourlyHistoryKey) ?? [];

    // Avoid duplicates: check if the last record has the same time
    if (existingList.isNotEmpty) {
      final lastRecord = HourlyForecast.fromJson(
        jsonDecode(existingList.last) as Map<String, dynamic>,
      );
      if (lastRecord.time == newRecord.time) {
        return; // Skip duplicate
      }
    }

    existingList.add(jsonEncode(newRecord.toJson()));

    // Keep only the last 24 records to prevent unlimited growth
    if (existingList.length > 24) {
      existingList = existingList.sublist(existingList.length - 24);
    }

    await prefs.setStringList(hourlyHistoryKey, existingList);
  }

  Future<List<HourlyForecast>> getStoredHourlyHistory(
    String hourlyHistoryKey,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedStrings = prefs.getStringList(hourlyHistoryKey) ?? [];

    return savedStrings.map((item) {
      final Map<String, dynamic> decodedData = jsonDecode(item);
      return HourlyForecast.fromJson(decodedData);
    }).toList();
  }
}
