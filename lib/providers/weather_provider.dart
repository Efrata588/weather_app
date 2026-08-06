import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasource/datasource.dart';
import '../data/models/weather_model.dart';

// 1. Instantiate the Datasource
final weatherDatasourceProvider = Provider((ref) => WeatherDatasource());

// 2. The Modern AsyncNotifier to manage weather and hourly history state
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

  // Fetch live weather and reload local history
  Future<void> refreshWeather() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchAndLoadHistory());
  }

  Future<({WeatherModel? currentWeather, List<HourlyForecast> hourlyHistory})>
  _fetchAndLoadHistory() async {
    final datasource = ref.read(weatherDatasourceProvider);

    WeatherModel? weather;
    try {
      weather = await datasource.fetchWeather();
    } catch (_) {
      // If network fails, we can still load local history
    }

    final history = await datasource.getStoredHourlyHistory(historyKey);

    return (currentWeather: weather, hourlyHistory: history);
  }
}

// 3. Global Riverpod Provider using AsyncNotifierProvider
final weatherProvider =
    AsyncNotifierProvider<
      WeatherNotifier,
      ({WeatherModel? currentWeather, List<HourlyForecast> hourlyHistory})
    >(() {
      return WeatherNotifier();
    });
