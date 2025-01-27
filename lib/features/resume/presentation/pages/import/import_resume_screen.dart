import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../dashboard/presentation/widgets/notification_badge.dart';

class ImportResumeScreen extends StatelessWidget {
  const ImportResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Resume'),
        actions: const [
          NotificationBadge(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Import from',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildImportCard(
              context,
              title: 'PDF Document',
              description: 'Import from an existing PDF resume',
              icon: Iconsax.document_upload,
              color: AppTheme.primaryColor,
              onTap: () {
                // TODO: Implement PDF import
              },
            ),
            const SizedBox(height: 16),
            _buildImportCard(
              context,
              title: 'LinkedIn Profile',
              description: 'Import directly from your LinkedIn profile',
              icon: Iconsax.link,
              color: const Color(0xFF0A66C2), // LinkedIn blue
              onTap: () {
                // TODO: Implement LinkedIn import
              },
            ),
            const SizedBox(height: 16),
            _buildImportCard(
              context,
              title: 'Word Document',
              description: 'Import from a .docx or .doc file',
              icon: Iconsax.document_text,
              color: const Color(0xFF2B579A), // Word blue
              onTap: () {
                // TODO: Implement Word import
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Recently Imported',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildRecentImportsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImportCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Iconsax.arrow_right_3,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentImportsList(BuildContext context) {
    // Placeholder data for recently imported resumes
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildRecentImportItem(
          context,
          title: 'Software Engineer Resume',
          source: 'PDF Document',
          date: '2 days ago',
          icon: Iconsax.document,
        );
      },
    );
  }

  Widget _buildRecentImportItem(
    BuildContext context, {
    required String title,
    required String source,
    required String date,
    required IconData icon,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(
          '$source • $date',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Iconsax.refresh),
          onPressed: () {
            // TODO: Implement re-import
          },
        ),
      ),
    );
  }
}
