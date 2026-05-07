import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/core/utils/responsive.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      drawer: !Responsive.isDesktop(context) ? const AdminSidebar() : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              flex: 1,
              child: AdminSidebar(),
            ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const AdminHeader(title: 'Add Product'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopActionRow(context),
                        const SizedBox(height: 24),
                        _buildMainContent(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopActionRow(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add New Product',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Publish Product', style: TextStyle(fontSize: 12)),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.heading,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Save to draft', style: TextStyle(fontSize: 12)),
              ),
              _buildIconButton(Icons.add),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        const Text(
          'Add New Product',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading),
        ),
        const Spacer(),
        if (Responsive.isDesktop(context)) ...[
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search product for add',
                hintStyle: const TextStyle(fontSize: 13),
                prefixIcon: const Icon(Icons.search, size: 18),
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Publish Product'),
        ),
        const SizedBox(width: 12),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.heading,
            backgroundColor: Colors.white,
            side: const BorderSide(color: AppColors.border),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Save to draft'),
        ),
        const SizedBox(width: 12),
        _buildIconButton(Icons.add),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Icon(icon, size: 18, color: AppColors.textBody),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(
        children: [
          _buildBasicDetailsForm(),
          const SizedBox(height: 24),
          _buildUploadImageSection(),
          const SizedBox(height: 24),
          _buildPricingSection(context),
          const SizedBox(height: 24),
          _buildCategoriesSection(),
          const SizedBox(height: 24),
          _buildInventorySection(context),
          const SizedBox(height: 32),
          _buildBottomActions(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _buildBasicDetailsForm(),
              const SizedBox(height: 24),
              _buildPricingSection(context),
              const SizedBox(height: 24),
              _buildInventorySection(context),
              const SizedBox(height: 32),
              _buildBottomActions(),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildUploadImageSection(),
              const SizedBox(height: 24),
              _buildCategoriesSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBasicDetailsForm() {
    return _buildCard(
      title: 'Basic Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Product Name', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildTextField(hintText: 'iPhone 15'),
          const SizedBox(height: 20),
          const Text('Product Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                const Text(
                  'The iPhone 15 delivers cutting-edge performance with the A16 Bionic chip, an immersive Super Retina XDR display, advanced dual-camera system, and exceptional battery life, all encased in stunning aerospace-grade aluminum.',
                  style: TextStyle(fontSize: 13, color: AppColors.textBody),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.edit_outlined, size: 18, color: AppColors.textBody),
                    SizedBox(width: 12),
                    Icon(Icons.brush_outlined, size: 18, color: AppColors.textBody),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    return _buildCard(
      title: 'Pricing',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Product Price', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildTextField(
            hintText: r'$999.89',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.flag_circle, color: Colors.blue, size: 20),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (isMobile) ...[
            const Text('Discounted Price (Optional)', style: TextStyle(fontSize: 12, color: AppColors.textBody)),
            const SizedBox(height: 8),
            _buildTextField(hintText: r'$ 99', prefixIcon: const Icon(Icons.attach_money, size: 16)),
            const SizedBox(height: 16),
            const Text('Sale = \$900.89', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.heading)),
            const SizedBox(height: 16),
            const Text('Tax Included', style: TextStyle(fontSize: 12, color: AppColors.textBody)),
            Row(
              children: [
                Radio(value: true, groupValue: true, onChanged: (v) {}, activeColor: Colors.indigo),
                const Text('Yes', style: TextStyle(fontSize: 13)),
                Radio(value: false, groupValue: true, onChanged: (v) {}),
                const Text('No', style: TextStyle(fontSize: 13)),
              ],
            ),
          ] else
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Discounted Price (Optional)', style: TextStyle(fontSize: 12, color: AppColors.textBody)),
                      const SizedBox(height: 8),
                      _buildTextField(hintText: r'$ 99', prefixIcon: const Icon(Icons.attach_money, size: 16)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 20),
                      Text('Sale = \$900.89', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.heading)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tax Included', style: TextStyle(fontSize: 12, color: AppColors.textBody)),
                      Row(
                        children: [
                          Radio(value: true, groupValue: true, onChanged: (v) {}, activeColor: Colors.indigo),
                          const Text('Yes', style: TextStyle(fontSize: 13)),
                          Radio(value: false, groupValue: true, onChanged: (v) {}),
                          const Text('No', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(height: 20),
          const Text('Expiration', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildTextField(hintText: 'Start', suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16))),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField(hintText: 'End', suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInventorySection(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    return _buildCard(
      title: 'Inventory',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile) ...[
            const Text('Stock Quantity', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildTextField(hintText: 'Unlimited'),
            const SizedBox(height: 16),
            const Text('Stock Status', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildStockDropdown(),
          ] else
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Stock Quantity', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildTextField(hintText: 'Unlimited'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Stock Status', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildStockDropdown(),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              Switch(value: true, onChanged: (v) {}, activeColor: AppColors.primary),
              const Text('Unlimited', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
          Row(
            children: [
              Checkbox(value: true, onChanged: (v) {}, activeColor: AppColors.primary),
              const Expanded(child: Text('Highlight this product in a featured section.', style: TextStyle(fontSize: 13, color: AppColors.textBody))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
      ),
      items: const [DropdownMenuItem(child: Text('In Stock', style: TextStyle(fontSize: 13)), value: 'in_stock')],
      onChanged: (v) {},
    );
  }

  Widget _buildUploadImageSection() {
    return _buildCard(
      title: 'Upload Product Image',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Product Image', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network('https://images.unsplash.com/photo-1696446701796-da61225697cc?q=80&w=400&auto=format&fit=crop', fit: BoxFit.contain),
                PositionBag(
                  bottom: 12,
                  left: 12,
                  child: _buildActionChip(Icons.image_outlined, 'Browse'),
                ),
                PositionBag(
                  bottom: 12,
                  right: 12,
                  child: _buildActionChip(Icons.refresh, 'Replace'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildThumbnail('https://images.unsplash.com/photo-1696446701796-da61225697cc?q=80&w=100&auto=format&fit=crop'),
              const SizedBox(width: 12),
              _buildThumbnail('https://images.unsplash.com/photo-1695653422718-9b8ff0915614?q=80&w=100&auto=format&fit=crop'),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(border: Border.all(color: AppColors.primary, style: BorderStyle.none), borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_circle, color: AppColors.primary, size: 24),
                        SizedBox(height: 4),
                        Text('Add Image', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return _buildCard(
      title: 'Categories',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Product Categories', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildDropdown('Select your product'),
          const SizedBox(height: 20),
          const Text('Product Tag', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildDropdown('Select your product'),
          const SizedBox(height: 20),
          const Text('Select your color', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildColorDot(Colors.green[100]!),
              _buildColorDot(Colors.pink[50]!),
              _buildColorDot(Colors.blueGrey[50]!),
              _buildColorDot(Colors.yellow[50]!),
              _buildColorDot(Colors.black87),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.heading,
              side: const BorderSide(color: AppColors.border),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.save_outlined, size: 18),
                SizedBox(width: 8),
                Text('Save to draft'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Publish Product'),
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.heading)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField({String? hintText, Widget? suffixIcon, Widget? prefixIcon}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 13),
        isDense: true,
        filled: true,
        fillColor: Colors.grey[50],
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.border)),
      ),
      hint: Text(hint, style: const TextStyle(fontSize: 13)),
      items: const [],
      onChanged: (v) {},
    );
  }

  Widget _buildActionChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textBody),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildThumbnail(String url) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)),
          child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(url, fit: BoxFit.cover)),
        ),
        Positioned(
          top: -8,
          right: -8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.cancel, color: Colors.grey[400], size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildColorDot(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
    );
  }
}

class PositionBag extends StatelessWidget {
  final double? top, bottom, left, right;
  final Widget child;
  const PositionBag({super.key, this.top, this.bottom, this.left, this.right, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(top: top, bottom: bottom, left: left, right: right, child: child);
  }
}
