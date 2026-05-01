import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class MissionSection extends StatelessWidget {
  final bool isMobile;
  const MissionSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final missions = [
      {'title': 'Who we are', 'desc': 'Volutpat diam ut venenatis tellus in metus. Vivamus at augue eget arcu dictum varius duis at velit.'},
      {'title': 'Our history', 'desc': 'Volutpat diam ut venenatis tellus in metus. Vivamus at augue eget arcu dictum varius duis at velit.'},
      {'title': 'Our mission', 'desc': 'Volutpat diam ut venenatis tellus in metus. Vivamus at augue eget arcu dictum varius duis at velit.'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 40),
      child: isMobile
          ? Column(children: missions.map((m) => _buildMissionItem(m)).toList())
          : Row(children: missions.map((m) => Expanded(child: _buildMissionItem(m))).toList()),
    );
  }

  Widget _buildMissionItem(Map<String, String> mission) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mission['title']!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.heading)),
          const SizedBox(height: 15),
          Text(mission['desc']!, style: const TextStyle(color: AppColors.textBody, height: 1.6)),
        ],
      ),
    );
  }
}
