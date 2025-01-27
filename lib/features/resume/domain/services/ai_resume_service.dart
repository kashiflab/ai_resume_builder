import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../models/resume_model.dart';

abstract class AIResumeService {
  /// Extracts information from a LinkedIn profile URL
  Future<Either<Failure, ResumeModel>> extractFromLinkedIn(String profileUrl);

  /// Extracts information from a PDF resume
  Future<Either<Failure, ResumeModel>> extractFromPDF(String filePath);

  /// Analyzes a job description and suggests relevant keywords
  Future<Either<Failure, List<String>>> analyzeJobDescription(
    String jobDescription,
  );

  /// Optimizes resume content for ATS systems
  Future<Either<Failure, AtsScore>> optimizeForATS(
    ResumeModel resume,
    String jobDescription,
  );

  /// Suggests improvements for resume sections
  Future<Either<Failure, Map<String, List<String>>>> suggestImprovements(
    ResumeModel resume,
  );

  /// Generates a professional summary based on experience
  Future<Either<Failure, String>> generateSummary(
    ResumeModel resume,
    String? targetRole,
  );

  /// Enhances bullet points with action verbs and metrics
  Future<Either<Failure, List<String>>> enhanceBulletPoints(
    List<String> bulletPoints,
    String context,
  );

  /// Suggests skills based on work experience
  Future<Either<Failure, List<String>>> suggestSkills(
    List<WorkExperience> experience,
    String? targetRole,
  );

  /// Identifies missing keywords from a job description
  Future<Either<Failure, List<String>>> identifyMissingKeywords(
    ResumeModel resume,
    String jobDescription,
  );

  /// Suggests certifications relevant to career goals
  Future<Either<Failure, List<String>>> suggestCertifications(
    ResumeModel resume,
    String? targetRole,
  );
}
