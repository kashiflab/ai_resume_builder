import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/widgets/custom_button.dart';

class FontSettingsScreen extends StatefulWidget {
  const FontSettingsScreen({super.key});

  @override
  State<FontSettingsScreen> createState() => _FontSettingsScreenState();
}

class _FontSettingsScreenState extends State<FontSettingsScreen> {
  String _selectedHeadingFont = 'Poppins';
  String _selectedBodyFont = 'Inter';
  double _headingSize = 24;
  double _subheadingSize = 18;
  double _bodySize = 14;

  final List<String> _fontOptions = [
    'Poppins',
    'Inter',
    'Roboto',
    'Montserrat',
    'Open Sans',
    'Lato',
    'Raleway',
    'Source Sans Pro',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Font Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Typography Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Customize fonts and sizes for your resume',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Heading Font',
              child: _buildFontSelector(
                selectedFont: _selectedHeadingFont,
                onFontChanged: (font) {
                  setState(() {
                    _selectedHeadingFont = font;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Body Font',
              child: _buildFontSelector(
                selectedFont: _selectedBodyFont,
                onFontChanged: (font) {
                  setState(() {
                    _selectedBodyFont = font;
                  });
                },
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Font Sizes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFontSizeSlider(
              title: 'Heading Size',
              value: _headingSize,
              min: 20,
              max: 32,
              onChanged: (value) {
                setState(() {
                  _headingSize = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildFontSizeSlider(
              title: 'Subheading Size',
              value: _subheadingSize,
              min: 16,
              max: 24,
              onChanged: (value) {
                setState(() {
                  _subheadingSize = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildFontSizeSlider(
              title: 'Body Text Size',
              value: _bodySize,
              min: 12,
              max: 18,
              onChanged: (value) {
                setState(() {
                  _bodySize = value;
                });
              },
            ),
            const SizedBox(height: 32),
            _buildPreview(),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Save Changes',
              onPressed: () {
                // TODO: Implement save changes
              },
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildFontSelector({
    required String selectedFont,
    required ValueChanged<String> onFontChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: _fontOptions.map((font) {
          final isSelected = font == selectedFont;
          return InkWell(
            onTap: () => onFontChanged(font),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: font != _fontOptions.last
                      ? BorderSide(color: Colors.grey.shade300)
                      : BorderSide.none,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'The quick brown fox',
                      style: GoogleFonts.getFont(
                        font,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFontSizeSlider({
    required String title,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${value.round()}px',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: ((max - min) * 2).toInt(),
          label: '${value.round()}px',
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Preview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Iconsax.eye,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'John Doe',
            style: GoogleFonts.getFont(
              _selectedHeadingFont,
              fontSize: _headingSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Senior Software Engineer',
            style: GoogleFonts.getFont(
              _selectedHeadingFont,
              fontSize: _subheadingSize,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Experienced software engineer with a passion for creating elegant solutions to complex problems. Skilled in Flutter, React, and Node.js.',
            style: GoogleFonts.getFont(
              _selectedBodyFont,
              fontSize: _bodySize,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
