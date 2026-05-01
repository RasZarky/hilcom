import 'package:flutter/material.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/web_secondary_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/mobile_drawer.dart';
import '../widgets/layout/footer.dart';
import '../widgets/layout/bottom_banner.dart';
import '../widgets/common/breadcrumb.dart';
import '../widgets/contact/contact_header.dart';
import '../widgets/contact/contact_info_grid.dart';
import '../widgets/contact/contact_map.dart';
import '../widgets/contact/contact_locations.dart';
import '../widgets/contact/contact_form_section.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: isMobile ? 90 : 110),
            if (!isMobile) const WebSecondaryHeader(currentPage: 'Contact'),
            Breadcrumb(currentPage: 'Contact', isMobile: isMobile),
            ContactHeader(isMobile: isMobile),
            ContactInfoGrid(isMobile: isMobile),
            ContactMap(isMobile: isMobile),
            ContactLocations(isMobile: isMobile),
            ContactFormSection(isMobile: isMobile),
            BottomBanner(isMobile: isMobile),
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}
