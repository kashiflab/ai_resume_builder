part of 'resume_creation_bloc.dart';

abstract class ResumeCreationEvent extends Equatable {
  const ResumeCreationEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePersonalInfoEvent extends ResumeCreationEvent {
  final PersonalInfo personalInfo;

  const UpdatePersonalInfoEvent(this.personalInfo);

  @override
  List<Object?> get props => [personalInfo];
}

class UpdateWorkExperienceEvent extends ResumeCreationEvent {
  final List<WorkExperience> workExperience;

  const UpdateWorkExperienceEvent(this.workExperience);

  @override
  List<Object?> get props => [workExperience];
}

class UpdateEducationEvent extends ResumeCreationEvent {
  final List<Education> education;

  const UpdateEducationEvent(this.education);

  @override
  List<Object?> get props => [education];
}

class UpdateSkillsEvent extends ResumeCreationEvent {
  final List<String> skills;

  const UpdateSkillsEvent(this.skills);

  @override
  List<Object?> get props => [skills];
}

class UpdateProjectsEvent extends ResumeCreationEvent {
  final List<Project> projects;

  const UpdateProjectsEvent(this.projects);

  @override
  List<Object?> get props => [projects];
}

class UpdateJobDescriptionEvent extends ResumeCreationEvent {
  final String jobDescription;

  const UpdateJobDescriptionEvent(this.jobDescription);

  @override
  List<Object?> get props => [jobDescription];
}

class AnalyzeWithAIEvent extends ResumeCreationEvent {
  final String templateId;

  const AnalyzeWithAIEvent(this.templateId);

  @override
  List<Object?> get props => [templateId];
}

class SaveResumeEvent extends ResumeCreationEvent {
  const SaveResumeEvent();
}
