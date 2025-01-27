import 'package:ai_resume_builder/features/resume/domain/models/resume_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/resume_creation/resume_creation_bloc.dart';
import '../widgets/resume_form_sections/index.dart';
import '../widgets/ai_analysis_section.dart';

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
    return BlocConsumer<ResumeCreationBloc, ResumeCreationState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
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
              } else {
                context.read<ResumeCreationBloc>().add(
                      AnalyzeWithAIEvent(widget.templateId),
                    );
              }
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
                        isLoading: state.isAnalyzing,
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
                  initialValue: state.personalInfo,
                  onChanged: (personalInfo) {
                    context.read<ResumeCreationBloc>().add(
                          UpdatePersonalInfoEvent(personalInfo),
                        );
                  },
                ),
                isActive: _currentStep >= 0,
                state: _getStepState(0),
              ),
              Step(
                title: const Text('Work Experience'),
                subtitle: const Text('Professional history'),
                content: WorkExperienceForm(
                  initialValue: state.workExperience,
                  onChanged: (workExperience) {
                    context.read<ResumeCreationBloc>().add(
                          UpdateWorkExperienceEvent(workExperience),
                        );
                  },
                ),
                isActive: _currentStep >= 1,
                state: _getStepState(1),
              ),
              Step(
                title: const Text('Education'),
                subtitle: const Text('Academic background'),
                content: EducationForm(
                  initialValue: state.education,
                  onChanged: (education) {
                    context.read<ResumeCreationBloc>().add(
                          UpdateEducationEvent(education),
                        );
                  },
                ),
                isActive: _currentStep >= 2,
                state: _getStepState(2),
              ),
              Step(
                title: const Text('Skills'),
                subtitle: const Text('Technical & soft skills'),
                content: SkillsForm(
                  initialValue: state.skills,
                  onChanged: (skills) {
                    context.read<ResumeCreationBloc>().add(
                          UpdateSkillsEvent(skills),
                        );
                  },
                ),
                isActive: _currentStep >= 3,
                state: _getStepState(3),
              ),
              Step(
                title: const Text('Projects'),
                subtitle: const Text('Portfolio & achievements'),
                content: ProjectsForm(
                  initialValue: state.projects,
                  onChanged: (projects) {
                    context.read<ResumeCreationBloc>().add(
                          UpdateProjectsEvent(projects),
                        );
                  },
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
                      initialValue: state.jobDescription,
                      onChanged: (jobDescription) {
                        context.read<ResumeCreationBloc>().add(
                              UpdateJobDescriptionEvent(jobDescription),
                            );
                      },
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
          bottomNavigationBar: state.isAnalyzing
              ? const LinearProgressIndicator()
              : const SizedBox.shrink(),
        );
      },
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
