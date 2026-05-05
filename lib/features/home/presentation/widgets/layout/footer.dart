import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class Footer extends StatelessWidget {
  final bool isMobile;
  const Footer({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 50),
      color: Colors.white,
      child: Column(
        children: [
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Hilcom',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 32,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      const Text('Awesome grocery store website\ntemplate'),
                      const SizedBox(height: 20),
                      _buildFooterContactItem(Icons.location_on_outlined,
                          'Address: 5171 W Campbell Ave undefined Kent, Utah 53127 United States'),
                      _buildFooterContactItem(Icons.headset_mic_outlined,
                          'Call Us: (+91) - 540-025-124553'),
                      _buildFooterContactItem(Icons.email_outlined,
                          'Email: sale@hilcom.com'),
                      _buildFooterContactItem(
                          Icons.access_time, 'Hours: 10:00 - 18:00, Mon - Sat'),
                    ],
                  ),
                ),
                _buildFooterColumn('Company', [
                  'About Us',
                  'Delivery Information',
                  'Privacy Policy',
                  'Terms & Conditions',
                  'Contact Us',
                  'Support Center'
                ]),
                _buildFooterColumn('Account', [
                  'Sign In',
                  'View Cart',
                  'My Wishlist',
                  'My Products',
                  'Track My Order',
                  'Help Ticket',
                  'Shipping Details'
                ]),
                _buildFooterColumn('Corporate', [
                  'Affiliate Program',
                  'Farm Business',
                  'Farm Careers',
                  'Our Suppliers',
                  'Accessibility'
                ]),
                _buildFooterColumn('Popular', [
                  'Milk & Flavoured Milk',
                  'Butter and Margarine',
                  'Eggs Substitutes',
                  'Marmalades',
                  'Sour Cream and Dips',
                  'Tea & Kombucha'
                ]),
              ],
            ),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                  '© 2024, Hilcom - Flutter Ecommerce\nAll rights reserved'),
              if (!isMobile)
                Row(
                  children: [
                    const Icon(Icons.phone_in_talk, color: AppColors.primary),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1900 - 6666',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        Text('Working 8:00 - 22:00',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(width: 40),
                    const Icon(Icons.phone_in_talk, color: AppColors.primary),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1900 - 8888',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        Text('24/7 Support Center',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(String title, List<String> links) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          ...links.map((link) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child:
                    Text(link, style: const TextStyle(color: AppColors.textBody)),
              )),
        ],
      ),
    );
  }
}
