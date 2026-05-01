import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ContactFormSection extends StatelessWidget {
  final bool isMobile;
  const ContactFormSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 60),
      child: isMobile
          ? Column(
              children: [
                _buildContactForm(context, true),
                const SizedBox(height: 50),
                _buildContactImage(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildContactForm(context, false)),
                const SizedBox(width: 50),
                Expanded(child: _buildContactImage()),
              ],
            ),
    );
  }

  Widget _buildContactForm(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Contact form',
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Text('Drop Us a Line',
            style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 10),
        const Text('Your email address will not be published. Required fields are marked *',
            style: TextStyle(color: AppColors.textBody)),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(child: _buildTextField('First Name')),
            const SizedBox(width: 20),
            Expanded(child: _buildTextField('Your Email')),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildTextField('Your Phone')),
            const SizedBox(width: 20),
            Expanded(child: _buildTextField('Subject')),
          ],
        ),
        const SizedBox(height: 20),
        _buildTextField('Your Message', maxLines: 5),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF253D4E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Send message'),
        ),
      ],
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }

  Widget _buildContactImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?q=80&w=800&auto=format&fit=crop',
        fit: BoxFit.cover,
      ),
    );
  }
}
