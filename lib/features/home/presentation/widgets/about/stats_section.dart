import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  final bool isMobile;
  const StatsSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {'val': '12+', 'label': 'Glorious years'},
      {'val': '2k+', 'label': 'Happy clients'},
      {'val': '5k+', 'label': 'Projects complete'},
      {'val': '145+', 'label': 'Team advisor'},
      {'val': '26+', 'label': 'Products Sale'},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 40),
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1200&auto=format&fit=crop'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
      ),
      child: isMobile
          ? Column(children: stats.map((s) => _buildStatItem(s)).toList())
          : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: stats.map((s) => _buildStatItem(s)).toList()),
    );
  }

  Widget _buildStatItem(Map<String, String> stat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(stat['val']!, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 5),
          Text(stat['label']!, style: const TextStyle(fontSize: 18, color: Colors.white70)),
        ],
      ),
    );
  }
}
