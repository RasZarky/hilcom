import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/web_secondary_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/mobile_drawer.dart';
import '../widgets/layout/footer.dart';

class SellToHilcomPage extends StatefulWidget {
  const SellToHilcomPage({super.key});

  @override
  State<SellToHilcomPage> createState() => _SellToHilcomPageState();
}

class _SellToHilcomPageState extends State<SellToHilcomPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _conditions = ['New', 'Open Box', 'Like New', 'Gently Used', 'Fair'];
  String? _selectedCondition;
  
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
            SizedBox(height: isMobile ? 110 : 120),
            if (!isMobile) const WebSecondaryHeader(currentPage: 'Sell to Hilcom'),
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 100,
                vertical: 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(context, isMobile),
                  const SizedBox(height: 50),
                  _buildForm(isMobile),
                ],
              ),
            ),
            
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'DIRECT PURCHASE PROGRAM',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Turn Your Quality Items into Cash',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.w900,
            color: AppColors.heading,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 700,
          child: Text(
            'Fill out the form below with your item details. Our team will review your submission and get back to you with an offer within 24-48 hours.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textBody,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(bool isMobile) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 900),
      padding: EdgeInsets.all(isMobile ? 25 : 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Item Visuals'),
            const SizedBox(height: 20),
            _buildImagePicker(isMobile),
            const SizedBox(height: 40),
            
            _buildSectionTitle('2. Item Details'),
            const SizedBox(height: 25),
            _buildResponsiveFields(
              isMobile,
              children: [
                _buildTextField('Product Name', 'e.g. iPhone 13 Pro Max'),
                _buildDropdownField('Condition', _conditions),
              ],
            ),
            const SizedBox(height: 20),
            _buildResponsiveFields(
              isMobile,
              children: [
                _buildTextField('Asking Price (GH₵)', 'e.g. 5,500', isNumber: true),
                _buildTextField('Category', 'e.g. Electronics'),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField('Item Description', 'Tell us more about the item (brand, age, defects, etc.)', maxLines: 4),
            
            const SizedBox(height: 40),
            _buildSectionTitle('3. Contact Information'),
            const SizedBox(height: 25),
            _buildResponsiveFields(
              isMobile,
              children: [
                _buildTextField('Full Name', 'John Doe'),
                _buildTextField('Phone Number', '024 XXX XXXX'),
              ],
            ),
            
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showSuccessDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                child: const Text(
                  'Submit Request for Review',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.heading,
      ),
    );
  }

  Widget _buildImagePicker(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildImagePlaceholder(isAdd: true),
            const SizedBox(width: 15),
            Expanded(
              child: SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(width: 15),
                  itemBuilder: (_, index) => _buildImagePlaceholder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Add at least 3 high-quality photos (Front, Back, and Sides)',
          style: TextStyle(fontSize: 12, color: AppColors.textBody),
        ),
      ],
    );
  }

  Widget _buildImagePlaceholder({bool isAdd = false}) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: isAdd ? AppColors.primaryLight : AppColors.border.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isAdd ? AppColors.primary.withOpacity(0.3) : AppColors.border,
          style: isAdd ? BorderStyle.solid : BorderStyle.solid,
        ),
      ),
      child: Icon(
        isAdd ? Icons.add_a_photo_outlined : Icons.image_outlined,
        color: isAdd ? AppColors.primary : AppColors.textBody.withOpacity(0.5),
      ),
    );
  }

  Widget _buildResponsiveFields(bool isMobile, {required List<Widget> children}) {
    if (isMobile) {
      return Column(children: children.map((e) => Padding(padding: const EdgeInsets.only(bottom: 20), child: e)).toList());
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.map((e) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: e))).toList(),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1, bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.heading, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.textBody.withOpacity(0.5), fontSize: 14),
            filled: true,
            fillColor: AppColors.border.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          validator: (value) => value == null || value.isEmpty ? 'This field is required' : null,
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.heading, fontSize: 14)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCondition,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => setState(() => _selectedCondition = val),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.border.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
          ),
          validator: (value) => value == null ? 'Please select a condition' : null,
        ),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Request Submitted'),
        content: const Text('Thank you! Your request has been received. Our team will review the details and contact you shortly.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
            },
            child: const Text('Back to Home', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
