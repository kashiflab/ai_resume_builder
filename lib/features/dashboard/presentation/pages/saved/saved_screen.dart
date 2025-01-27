import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../widgets/notification_badge.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Saved'),
      //   actions: const [
      //     NotificationBadge(),
      //   ],
      // ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Placeholder count
        itemBuilder: (context, index) {
          return _buildResumeCard(context);
        },
      ),
    );
  }

  Widget _buildResumeCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Iconsax.document_text,
            color: Colors.grey,
          ),
        ),
        title: Text(
          'Software Engineer Resume',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Last edited: 2 hours ago',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTag(context, 'Draft'),
                const SizedBox(width: 8),
                _buildTag(context, 'Professional'),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Iconsax.more),
          onPressed: () {
            // TODO: Show options menu
          },
        ),
      ),
    );
  }

  Widget _buildTag(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[700],
            ),
      ),
    );
  }
}
