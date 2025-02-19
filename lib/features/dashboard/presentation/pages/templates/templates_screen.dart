import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  final List<ResumeTemplate> _templates = [
    ResumeTemplate(
      id: '1',
      name: 'Professional Modern',
      description: 'Clean and modern design for professional use',
      previewUrl:
          'https://example.com/template1.png', // Replace with actual URL
      category: 'Professional',
      features: ['ATS-Friendly', 'Mobile-Optimized'],
    ),
    ResumeTemplate(
      id: '2',
      name: 'Creative Designer',
      description: 'Stand out with a creative and unique layout',
      previewUrl:
          'https://example.com/template2.png', // Replace with actual URL
      category: 'Creative',
      features: ['Portfolio Section', 'Custom Colors'],
    ),
    ResumeTemplate(
      id: '3',
      name: 'Executive Classic',
      description: 'Traditional layout for senior positions',
      previewUrl:
          'https://example.com/template3.png', // Replace with actual URL
      category: 'Executive',
      features: ['Multi-Page', 'Reference Section'],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Template',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Swipe to preview different designs',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: _templates.length,
              itemBuilder: (context, index) {
                final template = _templates[index];
                final isActive = index == _currentPage;
                return AnimatedScale(
                  scale: isActive ? 1.0 : 0.9,
                  duration: const Duration(milliseconds: 300),
                  child: _buildTemplatePreview(template),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _templates.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: index == _currentPage ? 24 : 8,
                  decoration: BoxDecoration(
                    color: index == _currentPage
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (_currentPage < _templates.length)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _templates[_currentPage].name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _templates[_currentPage].description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _templates[_currentPage]
                        .features
                        .map((feature) => _buildFeatureChip(feature))
                        .toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Navigate to resume editor with selected template
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Use This Template'),
        ),
      ),
    );
  }

  Widget _buildTemplatePreview(ResumeTemplate template) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Template Preview Image
            CachedNetworkImage(
              imageUrl: template.previewUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(
                    Iconsax.document,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            // Category Label
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  template.category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureChip(String feature) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Iconsax.tick_circle,
            size: 16,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 4),
          Text(
            feature,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ResumeTemplate {
  final String id;
  final String name;
  final String description;
  final String previewUrl;
  final String category;
  final List<String> features;

  const ResumeTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.previewUrl,
    required this.category,
    required this.features,
  });
}
