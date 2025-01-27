part of 'resume_creation_bloc.dart';

class ResumeCreationState extends Equatable {
  final PersonalInfo? personalInfo;
  final List<WorkExperience>? workExperience;
  final List<Education>? education;
  final List<String>? skills;
  final List<Project>? projects;
  final String? jobDescription;
  final bool isAnalyzing;
  final String? errorMessage;
  final List<String>? suggestedKeywords;
  final AtsScore? atsScore;
  final String? generatedSummary;
  final Map<String, List<String>>? improvementSuggestions;

  const ResumeCreationState({
    this.personalInfo,
    this.workExperience,
    this.education,
    this.skills,
    this.projects,
    this.jobDescription,
    this.isAnalyzing = false,
    this.errorMessage,
    this.suggestedKeywords,
    this.atsScore,
    this.generatedSummary,
    this.improvementSuggestions,
  });

  ResumeCreationState copyWith({
    PersonalInfo? personalInfo,
    List<WorkExperience>? workExperience,
    List<Education>? education,
    List<String>? skills,
    List<Project>? projects,
    String? jobDescription,
    bool? isAnalyzing,
    String? errorMessage,
    List<String>? suggestedKeywords,
    AtsScore? atsScore,
    String? generatedSummary,
    Map<String, List<String>>? improvementSuggestions,
  }) {
    return ResumeCreationState(
      personalInfo: personalInfo ?? this.personalInfo,
      workExperience: workExperience ?? this.workExperience,
      education: education ?? this.education,
      skills: skills ?? this.skills,
      projects: projects ?? this.projects,
      jobDescription: jobDescription ?? this.jobDescription,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      errorMessage: errorMessage,
      suggestedKeywords: suggestedKeywords ?? this.suggestedKeywords,
      atsScore: atsScore ?? this.atsScore,
      generatedSummary: generatedSummary ?? this.generatedSummary,
      improvementSuggestions:
          improvementSuggestions ?? this.improvementSuggestions,
    );
  }

  @override
  List<Object?> get props => [
        personalInfo,
        workExperience,
        education,
        skills,
        projects,
        jobDescription,
        isAnalyzing,
        errorMessage,
        suggestedKeywords,
        atsScore,
        generatedSummary,
        improvementSuggestions,
      ];
}
