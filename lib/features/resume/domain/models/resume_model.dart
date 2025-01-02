import 'package:equatable/equatable.dart';

class ResumeModel extends Equatable {
  final String id;
  final String userId;
  final String templateId;
  final String title;
  final PersonalInfo personalInfo;
  final List<WorkExperience> workExperience;
  final List<Education> education;
  final List<String> skills;
  final List<String> languages;
  final String summary;
  final List<String> certifications;
  final List<Project> projects;
  final List<String> interests;
  final List<String> references;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDraft;
  final Map<String, dynamic> customSections;
  final AtsScore atsScore;

  const ResumeModel({
    required this.id,
    required this.userId,
    required this.templateId,
    required this.title,
    required this.personalInfo,
    required this.workExperience,
    required this.education,
    required this.skills,
    required this.languages,
    required this.summary,
    required this.certifications,
    required this.projects,
    required this.interests,
    required this.references,
    required this.createdAt,
    required this.updatedAt,
    required this.isDraft,
    required this.customSections,
    required this.atsScore,
  });

  ResumeModel copyWith({
    String? id,
    String? userId,
    String? templateId,
    String? title,
    PersonalInfo? personalInfo,
    List<WorkExperience>? workExperience,
    List<Education>? education,
    List<String>? skills,
    List<String>? languages,
    String? summary,
    List<String>? certifications,
    List<Project>? projects,
    List<String>? interests,
    List<String>? references,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDraft,
    Map<String, dynamic>? customSections,
    AtsScore? atsScore,
  }) {
    return ResumeModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      templateId: templateId ?? this.templateId,
      title: title ?? this.title,
      personalInfo: personalInfo ?? this.personalInfo,
      workExperience: workExperience ?? this.workExperience,
      education: education ?? this.education,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
      summary: summary ?? this.summary,
      certifications: certifications ?? this.certifications,
      projects: projects ?? this.projects,
      interests: interests ?? this.interests,
      references: references ?? this.references,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDraft: isDraft ?? this.isDraft,
      customSections: customSections ?? this.customSections,
      atsScore: atsScore ?? this.atsScore,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'templateId': templateId,
      'title': title,
      'personalInfo': personalInfo.toJson(),
      'workExperience': workExperience.map((x) => x.toJson()).toList(),
      'education': education.map((x) => x.toJson()).toList(),
      'skills': skills,
      'languages': languages,
      'summary': summary,
      'certifications': certifications,
      'projects': projects.map((x) => x.toJson()).toList(),
      'interests': interests,
      'references': references,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isDraft': isDraft,
      'customSections': customSections,
      'atsScore': atsScore.toJson(),
    };
  }

  factory ResumeModel.fromJson(Map<String, dynamic> json) {
    return ResumeModel(
      id: json['id'],
      userId: json['userId'],
      templateId: json['templateId'],
      title: json['title'],
      personalInfo: PersonalInfo.fromJson(json['personalInfo']),
      workExperience: List<WorkExperience>.from(
        json['workExperience'].map((x) => WorkExperience.fromJson(x)),
      ),
      education: List<Education>.from(
        json['education'].map((x) => Education.fromJson(x)),
      ),
      skills: List<String>.from(json['skills']),
      languages: List<String>.from(json['languages']),
      summary: json['summary'],
      certifications: List<String>.from(json['certifications']),
      projects: List<Project>.from(
        json['projects'].map((x) => Project.fromJson(x)),
      ),
      interests: List<String>.from(json['interests']),
      references: List<String>.from(json['references']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isDraft: json['isDraft'],
      customSections: Map<String, dynamic>.from(json['customSections']),
      atsScore: AtsScore.fromJson(json['atsScore']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        templateId,
        title,
        personalInfo,
        workExperience,
        education,
        skills,
        languages,
        summary,
        certifications,
        projects,
        interests,
        references,
        createdAt,
        updatedAt,
        isDraft,
        customSections,
        atsScore,
      ];
}

class PersonalInfo extends Equatable {
  final String fullName;
  final String email;
  final String phone;
  final String location;
  final String? linkedIn;
  final String? portfolio;
  final String? github;
  final Map<String, String> socialLinks;

  const PersonalInfo({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.location,
    this.linkedIn,
    this.portfolio,
    this.github,
    required this.socialLinks,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'location': location,
      'linkedIn': linkedIn,
      'portfolio': portfolio,
      'github': github,
      'socialLinks': socialLinks,
    };
  }

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      linkedIn: json['linkedIn'],
      portfolio: json['portfolio'],
      github: json['github'],
      socialLinks: Map<String, String>.from(json['socialLinks']),
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        phone,
        location,
        linkedIn,
        portfolio,
        github,
        socialLinks,
      ];
}

class WorkExperience extends Equatable {
  final String company;
  final String position;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrentRole;
  final String location;
  final List<String> responsibilities;
  final List<String> achievements;
  final List<String> keywords;

  const WorkExperience({
    required this.company,
    required this.position,
    required this.startDate,
    this.endDate,
    required this.isCurrentRole,
    required this.location,
    required this.responsibilities,
    required this.achievements,
    required this.keywords,
  });

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'position': position,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCurrentRole': isCurrentRole,
      'location': location,
      'responsibilities': responsibilities,
      'achievements': achievements,
      'keywords': keywords,
    };
  }

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      company: json['company'],
      position: json['position'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isCurrentRole: json['isCurrentRole'],
      location: json['location'],
      responsibilities: List<String>.from(json['responsibilities']),
      achievements: List<String>.from(json['achievements']),
      keywords: List<String>.from(json['keywords']),
    );
  }

  @override
  List<Object?> get props => [
        company,
        position,
        startDate,
        endDate,
        isCurrentRole,
        location,
        responsibilities,
        achievements,
        keywords,
      ];
}

class Education extends Equatable {
  final String institution;
  final String degree;
  final String field;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrentlyStudying;
  final String? location;
  final double? gpa;
  final List<String> achievements;
  final List<String> relevantCourses;

  const Education({
    required this.institution,
    required this.degree,
    required this.field,
    required this.startDate,
    this.endDate,
    required this.isCurrentlyStudying,
    this.location,
    this.gpa,
    required this.achievements,
    required this.relevantCourses,
  });

  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'degree': degree,
      'field': field,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCurrentlyStudying': isCurrentlyStudying,
      'location': location,
      'gpa': gpa,
      'achievements': achievements,
      'relevantCourses': relevantCourses,
    };
  }

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'],
      degree: json['degree'],
      field: json['field'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isCurrentlyStudying: json['isCurrentlyStudying'],
      location: json['location'],
      gpa: json['gpa']?.toDouble(),
      achievements: List<String>.from(json['achievements']),
      relevantCourses: List<String>.from(json['relevantCourses']),
    );
  }

  @override
  List<Object?> get props => [
        institution,
        degree,
        field,
        startDate,
        endDate,
        isCurrentlyStudying,
        location,
        gpa,
        achievements,
        relevantCourses,
      ];
}

class Project extends Equatable {
  final String name;
  final String description;
  final String? url;
  final List<String> technologies;
  final List<String> highlights;
  final DateTime? startDate;
  final DateTime? endDate;

  const Project({
    required this.name,
    required this.description,
    this.url,
    required this.technologies,
    required this.highlights,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'url': url,
      'technologies': technologies,
      'highlights': highlights,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'],
      description: json['description'],
      url: json['url'],
      technologies: List<String>.from(json['technologies']),
      highlights: List<String>.from(json['highlights']),
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        url,
        technologies,
        highlights,
        startDate,
        endDate,
      ];
}

class AtsScore extends Equatable {
  final int score;
  final List<String> matchedKeywords;
  final List<String> missingKeywords;
  final List<String> suggestions;
  final Map<String, int> sectionScores;

  const AtsScore({
    required this.score,
    required this.matchedKeywords,
    required this.missingKeywords,
    required this.suggestions,
    required this.sectionScores,
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'matchedKeywords': matchedKeywords,
      'missingKeywords': missingKeywords,
      'suggestions': suggestions,
      'sectionScores': sectionScores,
    };
  }

  factory AtsScore.fromJson(Map<String, dynamic> json) {
    return AtsScore(
      score: json['score'],
      matchedKeywords: List<String>.from(json['matchedKeywords']),
      missingKeywords: List<String>.from(json['missingKeywords']),
      suggestions: List<String>.from(json['suggestions']),
      sectionScores: Map<String, int>.from(json['sectionScores']),
    );
  }

  @override
  List<Object?> get props => [
        score,
        matchedKeywords,
        missingKeywords,
        suggestions,
        sectionScores,
      ];
}
