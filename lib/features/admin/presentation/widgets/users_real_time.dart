import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class UsersRealTime extends StatelessWidget {
  const UsersRealTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3333FF), // Indigo blue from image
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Users in last 30 minutes',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const Icon(Icons.more_vert, color: Colors.white, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '21.5K',
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Users per minute',
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                barTouchData: BarTouchData(enabled: false),
                titlesData: const FlTitlesData(show: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(20, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: (i % 5 + 5).toDouble() + (i % 3 * 3),
                        color: Colors.white.withOpacity(i == 15 ? 1.0 : 0.4),
                        width: 4,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
