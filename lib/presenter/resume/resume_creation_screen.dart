import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import 'widgets/resume_form_sections/index.dart';

class ResumeCreationScreen extends StatefulWidget {
  final String templateId;

  const ResumeCreationScreen({
    super.key,
    required this.templateId,
  });

  @override
  State<ResumeCreationScreen> createState() => _ResumeCreationScreenState();
}

class _ResumeCreationScreenState extends State<ResumeCreationScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Resume'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        type: StepperType.vertical,
        onStepContinue: () {
          if (_currentStep < 5) {
            setState(() {
              _currentStep++;
            });
          } else {}
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: CustomButton(
                      text: 'Back',
                      onPressed: details.onStepCancel!,
                      isOutlined: true,
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: _currentStep < 5 ? 'Next' : 'Analyze',
                    onPressed: details.onStepContinue!,
                    isLoading:
                        false, // Assuming there's no state to check for isLoading
                  ),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Personal Info'),
            subtitle: const Text('Basic contact information'),
            content: PersonalInfoForm(
              initialValue: null, // Assuming there's no state to pass
              onChanged: (personalInfo) {},
            ),
            isActive: _currentStep >= 0,
            state: _getStepState(0),
          ),
          Step(
            title: const Text('Work Experience'),
            subtitle: const Text('Professional history'),
            content: WorkExperienceForm(
              initialValue: null, // Assuming there's no state to pass
              onChanged: (workExperience) {},
            ),
            isActive: _currentStep >= 1,
            state: _getStepState(1),
          ),
          Step(
            title: const Text('Education'),
            subtitle: const Text('Academic background'),
            content: EducationForm(
              initialValue: null, // Assuming there's no state to pass
              onChanged: (education) {},
            ),
            isActive: _currentStep >= 2,
            state: _getStepState(2),
          ),
          Step(
            title: const Text('Skills'),
            subtitle: const Text('Technical & soft skills'),
            content: SkillsForm(
              initialValue: null, // Assuming there's no state to pass
              onChanged: (skills) {},
            ),
            isActive: _currentStep >= 3,
            state: _getStepState(3),
          ),
          Step(
            title: const Text('Projects'),
            subtitle: const Text('Portfolio & achievements'),
            content: ProjectsForm(
              initialValue: null, // Assuming there's no state to pass
              onChanged: (projects) {},
            ),
            isActive: _currentStep >= 4,
            state: _getStepState(4),
          ),
          Step(
            title: const Text('Job Description'),
            subtitle: const Text('Optional - For AI optimization'),
            content: Column(
              children: [
                JobDescriptionForm(
                  initialValue: null, // Assuming there's no state to pass
                  onChanged: (jobDescription) {},
                ),
                // if (state.atsScore != null || state.isAnalyzing) ...[
                //   const SizedBox(height: 32),
                //   const Divider(),
                //   const SizedBox(height: 32),
                //   AIAnalysisSection(
                //     suggestedKeywords: [
                //       'React',
                //       'TypeScript',
                //       'Node.js',
                //       'Flutter',
                //       'Git'
                //     ],
                //     atsScore: AtsScore(
                //       score: 82,
                //       matchedKeywords: ['React', 'TypeScript', 'Node.js'],
                //       missingKeywords: ['AWS', 'Python'],
                //       suggestions: [
                //         'Add more cloud experience',
                //         'Highlight leadership roles'
                //       ],
                //       sectionScores: {
                //         'Skills': 90,
                //         'Experience': 85,
                //         'Education': 80,
                //         'Projects': 85,
                //       },
                //     ),
                //     generatedSummary:
                //         'Experienced software engineer with 5+ years of expertise in full-stack development using React, TypeScript and Node.js. Strong background in mobile development with Flutter and proven track record of delivering high-quality applications.',
                //     improvementSuggestions: {
                //       'Skills': [
                //         'Add cloud technologies',
                //         'Include more soft skills'
                //       ],
                //       'Experience': [
                //         'Quantify achievements',
                //         'Use more action verbs'
                //       ],
                //       'Projects': [
                //         'Add more technical details',
                //         'Highlight team collaboration'
                //       ],
                //     },
                //     isAnalyzing: state.isAnalyzing,
                //   ),
                // ],
              ],
            ),
            isActive: _currentStep >= 5,
            state: _getStepState(5),
          ),
        ],
      ),
      bottomNavigationBar: const SizedBox
          .shrink(), // Assuming there's no state to check for isLoading
    );
  }

  StepState _getStepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else if (_currentStep == step) {
      return StepState.editing;
    }
    return StepState.indexed;
  }
}
