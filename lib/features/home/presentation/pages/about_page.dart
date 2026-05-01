import 'package:flutter/material.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/web_secondary_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/mobile_drawer.dart';
import '../widgets/layout/footer.dart';
import '../widgets/layout/bottom_banner.dart';
import '../widgets/common/breadcrumb.dart';
import '../widgets/about/welcome_section.dart';
import '../widgets/about/what_we_provide.dart';
import '../widgets/about/performance_section.dart';
import '../widgets/about/mission_section.dart';
import '../widgets/about/stats_section.dart';
import '../widgets/about/team_section.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!isMobile) const WebSecondaryHeader(currentPage: 'About'),
            Breadcrumb(currentPage: 'About Us', isMobile: isMobile),
            WelcomeSection(isMobile: isMobile),
            WhatWeProvide(isMobile: isMobile),
            PerformanceSection(isMobile: isMobile),
            MissionSection(isMobile: isMobile),
            StatsSection(isMobile: isMobile),
            TeamSection(isMobile: isMobile),
            BottomBanner(isMobile: isMobile),
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}
