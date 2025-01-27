import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/constants/app_routes.dart';

class QuickActionsScreen extends StatelessWidget {
  const QuickActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Actions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Actions Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildActionCard(
                  context,
                  title: 'Create New Resume',
                  icon: Iconsax.add_circle,
                  description: 'Start from scratch',
                  onTap: () => context.push(AppRoute.createResume.path),
                  color: const Color(0xFF1E88E5), // Professional blue
                ),
                _buildActionCard(
                  context,
                  title: 'Import Resume',
                  icon: Iconsax.import,
                  description: 'Import from PDF or LinkedIn',
                  onTap: () {
                    // TODO: Implement import
                  },
                  color: const Color(0xFF43A047), // Success green
                ),
                _buildActionCard(
                  context,
                  title: 'Cover Letters',
                  icon: Iconsax.document_text,
                  description: 'Create & manage cover letters',
                  onTap: () {
                    // TODO: Implement cover letters
                  },
                  color: const Color(0xFF8E24AA), // Royal purple
                ),
                _buildActionCard(
                  context,
                  title: 'ATS Friendly Test',
                  icon: Iconsax.chart_success,
                  description: 'Check resume compatibility',
                  onTap: () {
                    // TODO: Implement ATS test
                  },
                  color: const Color(0xFFEF6C00), // Warm orange
                ),
              ],
            ),

            const SizedBox(height: 32),

            // AI Tools Section
            Text(
              'AI Tools',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildActionCard(
                  context,
                  title: 'Resume Review',
                  icon: Iconsax.magic_star,
                  description: 'Get AI suggestions',
                  onTap: () {
                    // TODO: Implement AI review
                  },
                  color: const Color(0xFFD81B60), // Vibrant magenta
                ),
                _buildActionCard(
                  context,
                  title: 'Job Matcher',
                  icon: Iconsax.search_status,
                  description: 'Find matching jobs',
                  onTap: () {
                    // TODO: Implement job matcher
                  },
                  color: const Color(0xFF00897B), // Deep teal
                ),
                _buildActionCard(
                  context,
                  title: 'Skills Analyzer',
                  icon: Iconsax.graph,
                  description: 'Analyze your skills',
                  onTap: () {
                    // TODO: Implement skills analyzer
                  },
                  color: const Color(0xFF3949AB), // Rich indigo
                ),
                _buildActionCard(
                  context,
                  title: 'Interview Prep',
                  icon: Iconsax.message_question,
                  description: 'Practice with AI',
                  onTap: () {
                    // TODO: Implement interview prep
                  },
                  color: const Color(0xFFFFB300), // Bright amber
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Professional Tools
            Text(
              'Professional Tools',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildActionCard(
                  context,
                  title: 'LinkedIn Optimizer',
                  icon: Iconsax.link,
                  description: 'Enhance your profile',
                  onTap: () {
                    // TODO: Implement LinkedIn optimizer
                  },
                  color: const Color(0xFF0288D1), // LinkedIn blue
                ),
                _buildActionCard(
                  context,
                  title: 'Portfolio Builder',
                  icon: Iconsax.briefcase,
                  description: 'Showcase your work',
                  onTap: () {
                    // TODO: Implement portfolio builder
                  },
                  color: const Color(0xFF5E35B1), // Deep purple
                ),
                _buildActionCard(
                  context,
                  title: 'Network Manager',
                  icon: Iconsax.people,
                  description: 'Manage connections',
                  onTap: () {
                    // TODO: Implement network manager
                  },
                  color: const Color(0xFF00ACC1), // Bright cyan
                ),
                _buildActionCard(
                  context,
                  title: 'Career Planner',
                  icon: Iconsax.task_square,
                  description: 'Plan your growth',
                  onTap: () {
                    // TODO: Implement career planner
                  },
                  color: const Color(0xFFF4511E), // Sunset orange
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Learning Resources
            Text(
              'Learning Resources',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildActionCard(
                  context,
                  title: 'Resume Tips',
                  icon: Iconsax.teacher,
                  description: 'Expert guidance',
                  onTap: () {
                    // TODO: Implement resume tips
                  },
                  color: const Color(0xFF2E7D32), // Forest green
                ),
                _buildActionCard(
                  context,
                  title: 'Interview Guide',
                  icon: Iconsax.message_programming,
                  description: 'Preparation tips',
                  onTap: () {
                    // TODO: Implement interview guide
                  },
                  color: const Color(0xFF7B1FA2), // Deep purple
                ),
                _buildActionCard(
                  context,
                  title: 'Skill Courses',
                  icon: Iconsax.book_1,
                  description: 'Learn new skills',
                  onTap: () {
                    // TODO: Implement skill courses
                  },
                  color: const Color(0xFF795548), // Rich brown
                ),
                _buildActionCard(
                  context,
                  title: 'Career Blog',
                  icon: Iconsax.document_text_1,
                  description: 'Latest insights',
                  onTap: () {
                    // TODO: Implement career blog
                  },
                  color: const Color(0xFFD32F2F), // Elegant red
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: color.withOpacity(0.6),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
