import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasource/datasource.dart';
import '../data/models/weather_model.dart';

final weatherDatasourceProvider = Provider((ref) => WeatherDatasource());

class WeatherNotifier
    extends
        AsyncNotifier<
          ({WeatherModel? currentWeather, List<HourlyForecast> hourlyHistory})
        > {
  static const String historyKey = "HOURLY_WEATHER_HISTORY";

  @override
  Future<({WeatherModel? currentWeather, List<HourlyForecast> hourlyHistory})>
  build() async {
    return _fetchAndLoadHistory();
  }

  Future<void> refreshWeather() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchAndLoadHistory());
  }

  Future<({WeatherModel? currentWeather, List<HourlyForecast> hourlyHistory})>
  _fetchAndLoadHistory() async {
    final datasource = ref.read(weatherDatasourceProvider);

    WeatherModel? weather;

    weather = await datasource.fetchWeather();

    final history = await datasource.getStoredHourlyHistory(historyKey);

    for (var record in history) {}

    return (currentWeather: weather, hourlyHistory: history);
  }
}

final weatherProvider =
    AsyncNotifierProvider<
      WeatherNotifier,
      ({WeatherModel? currentWeather, List<HourlyForecast> hourlyHistory})
    >(() {
      return WeatherNotifier();
    });
