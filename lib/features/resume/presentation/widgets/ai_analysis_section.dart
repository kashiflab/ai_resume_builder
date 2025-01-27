import 'package:flutter/material.dart';
import '../../domain/models/resume_model.dart';

class AIAnalysisSection extends StatelessWidget {
  final List<String>? suggestedKeywords;
  final AtsScore? atsScore;
  final String? generatedSummary;
  final Map<String, List<String>>? improvementSuggestions;
  final bool isAnalyzing;

  const AIAnalysisSection({
    super.key,
    this.suggestedKeywords,
    this.atsScore,
    this.generatedSummary,
    this.improvementSuggestions,
    required this.isAnalyzing,
  });

  @override
  Widget build(BuildContext context) {
    if (isAnalyzing) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Analyzing your resume...'),
          ],
        ),
      );
    }

    if (atsScore == null) {
      return const Center(
        child: Text('Click "Analyze with AI" to get suggestions'),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            title: 'ATS Score',
            child: _buildATSScore(context),
          ),
          const SizedBox(height: 24),
          if (generatedSummary != null) ...[
            _buildSection(
              context,
              title: 'Professional Summary',
              child: Text(generatedSummary!),
            ),
            const SizedBox(height: 24),
          ],
          if (suggestedKeywords != null && suggestedKeywords!.isNotEmpty) ...[
            _buildSection(
              context,
              title: 'Suggested Keywords',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: suggestedKeywords!
                    .map((keyword) => Chip(label: Text(keyword)))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
          if (improvementSuggestions != null &&
              improvementSuggestions!.isNotEmpty) ...[
            _buildSection(
              context,
              title: 'Improvement Suggestions',
              child: _buildImprovementSuggestions(context),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildATSScore(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final score = atsScore!.score;
    final color = score >= 80
        ? Colors.green
        : score >= 60
            ? Colors.orange
            : Colors.red;

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$score',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your resume is ${_getScoreDescription(score)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getScoreMessage(score),
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (atsScore!.matchedKeywords.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Matched Keywords',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: atsScore!.matchedKeywords
                .map(
                  (keyword) => Chip(
                    label: Text(keyword),
                    backgroundColor: Colors.green.withOpacity(0.1),
                    side: const BorderSide(color: Colors.green),
                  ),
                )
                .toList(),
          ),
        ],
        if (atsScore!.missingKeywords.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Missing Keywords',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: atsScore!.missingKeywords
                .map(
                  (keyword) => Chip(
                    label: Text(keyword),
                    backgroundColor: Colors.red.withOpacity(0.1),
                    side: const BorderSide(color: Colors.red),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildImprovementSuggestions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: improvementSuggestions!.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.key,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...entry.value.map(
              (suggestion) => Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  bottom: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(child: Text(suggestion)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  String _getScoreDescription(int score) {
    if (score >= 80) return 'well-optimized';
    if (score >= 60) return 'moderately optimized';
    return 'needs improvement';
  }

  String _getScoreMessage(int score) {
    if (score >= 80) {
      return 'Great job! Your resume is well-optimized for ATS systems.';
    }
    if (score >= 60) {
      return 'Your resume is doing okay, but there\'s room for improvement.';
    }
    return 'Your resume needs significant improvements to pass ATS systems.';
  }
}
