import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/widgets/custom_button.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Features'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upgrade to Premium',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Get access to all premium features and create unlimited resumes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            _buildPricingCard(
              context,
              title: 'Monthly',
              price: '\$9.99',
              period: 'month',
              features: const [
                'Unlimited Resume Creation',
                'AI-Powered Resume Analysis',
                'Premium Templates',
                'Cover Letter Generator',
                'Priority Support',
              ],
              isPopular: false,
            ),
            const SizedBox(height: 16),
            _buildPricingCard(
              context,
              title: 'Annual',
              price: '\$89.99',
              period: 'year',
              features: const [
                'All Monthly Features',
                '2 Months Free',
                'Resume Performance Analytics',
                'Interview Preparation Tools',
                'LinkedIn Profile Optimization',
              ],
              isPopular: true,
              savings: 'Save 25%',
            ),
            const SizedBox(height: 32),
            const Text(
              'All plans include:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFeatureList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingCard(
    BuildContext context, {
    required String title,
    required String price,
    required String period,
    required List<String> features,
    required bool isPopular,
    String? savings,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              isPopular ? Theme.of(context).primaryColor : Colors.grey.shade300,
          width: 2,
        ),
        color:
            isPopular ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      ),
      child: Column(
        children: [
          if (isPopular) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: const Text(
                'Most Popular',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (savings != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          savings,
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '/$period',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ...features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Text(feature),
                        ],
                      ),
                    )),
                const SizedBox(height: 24),
                CustomButton(
                  text: isPopular ? 'Start Free Trial' : 'Choose Plan',
                  onPressed: () {
                    // TODO: Implement subscription logic
                  },
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList() {
    return Column(
      children: const [
        _FeatureItem(
          icon: Iconsax.cloud,
          title: 'Cloud Storage',
          description: 'Securely store all your resumes and documents',
        ),
        SizedBox(height: 16),
        _FeatureItem(
          icon: Iconsax.document_download,
          title: 'Multiple Export Formats',
          description: 'Export your resume in PDF, DOCX, and more',
        ),
        SizedBox(height: 16),
        _FeatureItem(
          icon: Iconsax.brush_2,
          title: 'Customization',
          description: 'Customize every aspect of your resume',
        ),
        SizedBox(height: 16),
        _FeatureItem(
          icon: Iconsax.headphone,
          title: '24/7 Support',
          description: 'Get help whenever you need it',
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
