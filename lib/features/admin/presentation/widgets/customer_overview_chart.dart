import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';

class CustomerOverviewChart extends StatelessWidget {
  const CustomerOverviewChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Customer Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                ),
              ),
              Row(
                children: [
                  _buildTab('This week', true),
                  _buildTab('Last week', false),
                  const SizedBox(width: 8),
                  const Icon(Icons.more_vert, color: AppColors.textBody, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildStatsRow(context),
          const SizedBox(height: 30),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                        if (value >= 0 && value < days.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(days[value.toInt()],
                                style: const TextStyle(color: AppColors.textBody, fontSize: 12)),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      reservedSize: 35,
                      getTitlesWidget: (value, meta) {
                        return Text('${value.toInt()}k',
                            style: const TextStyle(color: AppColors.textBody, fontSize: 12));
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 50,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 15),
                      FlSpot(1, 18),
                      FlSpot(2, 35),
                      FlSpot(3, 25),
                      FlSpot(4, 45),
                      FlSpot(5, 30),
                      FlSpot(6, 45),
                    ],
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => AppColors.primary,
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        return LineTooltipItem(
                          'Thursday\n25,409',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final stats = [
      _buildStat('25k', 'Active Customers', true),
      _buildStat('5.6k', 'Repeat Customers', false),
      _buildStat('250k', 'Shop Visitor', false),
      _buildStat('5.5%', 'Conversion Rate', false),
    ];

    if (Responsive.isMobile(context)) {
      return Wrap(
        spacing: 20,
        runSpacing: 16,
        children: stats,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: stats,
    );
  }

  Widget _buildTab(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryLight : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? AppColors.primary : AppColors.textBody,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label, bool isActive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.heading),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textBody),
        ),
        const SizedBox(height: 4),
        if (isActive)
          Container(
            height: 2,
            width: 30,
            color: AppColors.primary,
          ),
      ],
    );
  }
}
