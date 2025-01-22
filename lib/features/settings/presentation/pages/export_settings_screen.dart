import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/widgets/custom_button.dart';

class ExportSettingsScreen extends StatefulWidget {
  const ExportSettingsScreen({super.key});

  @override
  State<ExportSettingsScreen> createState() => _ExportSettingsScreenState();
}

class _ExportSettingsScreenState extends State<ExportSettingsScreen> {
  String _selectedQuality = 'High';
  String _selectedFormat = 'PDF';
  bool _includeMetadata = true;
  bool _optimizeForPrinting = true;
  bool _compressImages = true;

  final List<String> _qualities = ['Low', 'Medium', 'High', 'Ultra'];
  final List<String> _formats = ['PDF', 'DOCX', 'PNG', 'JPG'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Export Configuration',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Configure how your resume will be exported',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Quality Settings',
              icon: Iconsax.setting_4,
              children: [
                _buildQualitySelector(),
                const SizedBox(height: 24),
                _buildFormatSelector(),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'Advanced Options',
              icon: Iconsax.code,
              children: [
                _buildSwitchTile(
                  title: 'Include Metadata',
                  subtitle: 'Add document properties and tags',
                  value: _includeMetadata,
                  onChanged: (value) {
                    setState(() {
                      _includeMetadata = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Optimize for Printing',
                  subtitle: 'Ensure best quality when printed',
                  value: _optimizeForPrinting,
                  onChanged: (value) {
                    setState(() {
                      _optimizeForPrinting = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Compress Images',
                  subtitle: 'Reduce file size while maintaining quality',
                  value: _compressImages,
                  onChanged: (value) {
                    setState(() {
                      _compressImages = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'File Size Estimate',
              icon: Iconsax.document_1,
              children: [
                _buildInfoTile(
                  'Estimated Size',
                  '2.4 MB',
                  subtitle: 'Based on current settings',
                ),
              ],
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Save Settings',
              onPressed: () {
                // TODO: Implement save settings
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
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildQualitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Export Quality',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: _qualities.map((quality) {
              final isSelected = quality == _selectedQuality;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedQuality = quality;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: quality != _qualities.last
                          ? BorderSide(color: Colors.grey.shade300)
                          : BorderSide.none,
                    ),
                    color: isSelected
                        ? Theme.of(context).primaryColor.withOpacity(0.1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quality,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getQualityDescription(quality),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
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
        ),
      ],
    );
  }

  Widget _buildFormatSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Export Format',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: _formats.map((format) {
              final isSelected = format == _selectedFormat;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedFormat = format;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: format != _formats.last
                          ? BorderSide(color: Colors.grey.shade300)
                          : BorderSide.none,
                    ),
                    color: isSelected
                        ? Theme.of(context).primaryColor.withOpacity(0.1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          format,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _getFormatDescription(format),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
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
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    String title,
    String value, {
    String? subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getQualityDescription(String quality) {
    switch (quality) {
      case 'Low':
        return 'Smaller file size, reduced quality';
      case 'Medium':
        return 'Balanced size and quality';
      case 'High':
        return 'Best for most uses';
      case 'Ultra':
        return 'Maximum quality, larger file size';
      default:
        return '';
    }
  }

  String _getFormatDescription(String format) {
    switch (format) {
      case 'PDF':
        return 'Best for sharing and printing';
      case 'DOCX':
        return 'Editable in Microsoft Word';
      case 'PNG':
        return 'High-quality image with transparency';
      case 'JPG':
        return 'Compressed image format';
      default:
        return '';
    }
  }
}
