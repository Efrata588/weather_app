// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../providers/weather_provider.dart';

// class WeatherScreen extends ConsumerWidget {
//   const WeatherScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final weatherAsync = ref.watch(weatherProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFF131520),
//       appBar: AppBar(
//         leading: Icon(Icons.menu),
//         actions: [Icon(Icons.calendar_month_rounded)],
//       ),
//       drawer: Drawer(
//         child: ListView(children: [DrawerHeader(child: Text('Weather app'))]),
//       ),
//       body: weatherAsync.when(
//         loading: () =>
//             const Center(child: CircularProgressIndicator(color: Colors.white)),
//         error: (err, stack) => Center(
//           child: Text(
//             "Error loading weather: $err",
//             style: const TextStyle(color: Colors.white),
//           ),
//         ),
//         data: (data) {
//           final weather = data.currentWeather;
//           final hourlyHistory = data.hourlyHistory;

//           return Padding(
//             padding: EdgeInsets.only(bottom: 40),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xFF2C222B),
//                     Color(0xFF131520),
//                     Color(0xFF0D0F17),
//                   ],
//                 ),
//               ),
//               child: SafeArea(
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24.0,
//                         vertical: 10.0,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Top Header Navigation Icons
//                           const SizedBox(height: 10),

//                           // Location Text
//                           const Text(
//                             "Addis Ababa, Ethiopia",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 30),

//                           // Main Weather 3D Illustration/Icon
//                           const Icon(
//                             Icons.cloudy_snowing,
//                             size: 130,
//                             color: Colors.amberAccent,
//                           ),
//                           const SizedBox(height: 15),

//                           // Large Temperature Display
//                           Text(
//                             weather != null
//                                 ? "${weather.temperature.toStringAsFixed(0)}° c"
//                                 : "29° c",
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 68,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 5),

//                           // Weather Subtitle Description
//                           Text(
//                             "Expect high rain today.",
//                             style: TextStyle(
//                               color: Colors.white.withValues(alpha: 0.7),
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 35),

//                           // Stats Row (Wind, Humidity, Sunlight/Precipitation)
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               _buildStatItem(
//                                 Icons.air,
//                                 weather != null
//                                     ? "${weather.windSpeed}km/hr"
//                                     : "11km/hr",
//                               ),
//                               _buildStatItem(
//                                 Icons.water_drop_outlined,
//                                 weather != null
//                                     ? "${weather.humidity}%"
//                                     : "02%",
//                               ),
//                               _buildStatItem(Icons.wb_sunny_outlined, "8hr"),
//                             ],
//                           ),
//                           const SizedBox(height: 40),

//                           // Hourly Forecast Header
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Row(
//                               children: const [
//                                 Icon(
//                                   Icons.access_time_rounded,
//                                   color: Colors.white,
//                                   size: 18,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   "Hourly Forecast",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 15),

//                           // Horizontal Hourly Forecast Cards List
//                           SizedBox(
//                             height: 130,
//                             child: hourlyHistory.isEmpty
//                                 ? const Center(
//                                     child: Text(
//                                       "No history logged yet.",
//                                       style: TextStyle(color: Colors.white54),
//                                     ),
//                                   )
//                                 : ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: hourlyHistory.length,
//                                     itemBuilder: (context, index) {
//                                       final item = hourlyHistory[index];
//                                       String timeLabel = index == 0
//                                           ? "Now"
//                                           : "${index + 4}pm";

//                                       return Container(
//                                         width: 80,
//                                         margin: const EdgeInsets.only(
//                                           right: 14,
//                                         ),
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 14,
//                                           horizontal: 8,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white.withValues(
//                                             alpha: 0.07,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             20,
//                                           ),
//                                           border: Border.all(
//                                             color: Colors.white.withValues(
//                                               alpha: 0.05,
//                                             ),
//                                           ),
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             const Icon(
//                                               Icons.cloud_queue_rounded,
//                                               color: Colors.lightBlueAccent,
//                                               size: 28,
//                                             ),
//                                             Text(
//                                               timeLabel,
//                                               style: TextStyle(
//                                                 color: Colors.white.withValues(
//                                                   alpha: 0.7,
//                                                 ),
//                                                 fontSize: 13,
//                                               ),
//                                             ),
//                                             Text(
//                                               "${item.temperature.toStringAsFixed(0)}°",
//                                               style: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Floating Bottom Navigation Bar
//                     Positioned(
//                       bottom: 20,
//                       left: 24,
//                       right: 24,
//                       child: Container(
//                         height: 65,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withValues(alpha: 0.08),
//                           borderRadius: BorderRadius.circular(35),
//                           border: Border.all(
//                             color: Colors.white.withValues(alpha: 0.1),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: const [
//                             Icon(
//                               Icons.home_rounded,
//                               color: Colors.white,
//                               size: 26,
//                             ),
//                             Icon(
//                               Icons.search_rounded,
//                               color: Colors.white54,
//                               size: 26,
//                             ),
//                             Icon(
//                               Icons.notifications_outlined,
//                               color: Colors.white54,
//                               size: 26,
//                             ),
//                             Icon(
//                               Icons.map_outlined,
//                               color: Colors.white54,
//                               size: 26,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildStatItem(IconData icon, String value) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.white70, size: 18),
//         const SizedBox(width: 6),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/weather_provider.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF131520),
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: const [Icon(Icons.calendar_month_rounded)],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Weather app')),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('View History'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),

      // Proper Scaffold Bottom Navigation Bar implementation
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.home_rounded, color: Colors.white, size: 26),
              Icon(Icons.search_rounded, color: Colors.white54, size: 26),
              Icon(
                Icons.notifications_outlined,
                color: Colors.white54,
                size: 26,
              ),
              Icon(Icons.map_outlined, color: Colors.white54, size: 26),
            ],
          ),
        ),
      ),

      body: weatherAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (err, stack) => Center(
          child: Text(
            "Error loading weather: $err",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        data: (data) {
          final weather = data.currentWeather;
          final hourlyHistory = data.hourlyHistory;

          // Removed bottom padding since bottomNavigationBar now handles spacing safely
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2C222B),
                  Color(0xFF131520),
                  Color(0xFF0D0F17),
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top Header Navigation Icons
                    const SizedBox(height: 10),

                    // Location Text
                    const Text(
                      "Addis Ababa, Ethiopia",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Main Weather 3D Illustration/Icon
                    const Icon(
                      Icons.cloudy_snowing,
                      size: 130,
                      color: Colors.amberAccent,
                    ),
                    const SizedBox(height: 15),

                    // Large Temperature Display
                    Text(
                      weather != null
                          ? "${weather.temperature.toStringAsFixed(0)}° c"
                          : "29° c",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 68,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Weather Subtitle Description
                    Text(
                      "Expect high rain today.",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 35),

                    // Stats Row (Wind, Humidity, Sunlight/Precipitation)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem(
                          Icons.air,
                          weather != null
                              ? "${weather.windSpeed}km/hr"
                              : "11km/hr",
                        ),
                        _buildStatItem(
                          Icons.water_drop_outlined,
                          weather != null ? "${weather.humidity}%" : "02%",
                        ),
                        _buildStatItem(Icons.wb_sunny_outlined, "8hr"),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Hourly Forecast Header
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Hourly Forecast",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Horizontal Hourly Forecast Cards List
                    SizedBox(
                      height: 130,
                      child: hourlyHistory.isEmpty
                          ? const Center(
                              child: Text(
                                "No history logged yet.",
                                style: TextStyle(color: Colors.white54),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: hourlyHistory.length,
                              itemBuilder: (context, index) {
                                final item = hourlyHistory[index];
                                String timeLabel = index == 0
                                    ? "Now"
                                    : "${index + 4}pm";

                                return Container(
                                  width: 80,
                                  margin: const EdgeInsets.only(right: 14),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.07),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.05,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.cloud_queue_rounded,
                                        color: Colors.lightBlueAccent,
                                        size: 28,
                                      ),
                                      Text(
                                        timeLabel,
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.7,
                                          ),
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        "${item.temperature.toStringAsFixed(0)}°",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(
                      height: 30,
                    ), // Extra space at bottom so content doesn't get hidden behind the bar
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
