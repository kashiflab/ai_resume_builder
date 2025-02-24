class ExtractedResumeData {
  String fullName;
  String email;
  String phone;
  String address;
  String summary;
  List<WorkExperience> workExperience;
  List<Education> education;
  List<String> skills;
  List<String> languages;
  List<String> certifications;

  ExtractedResumeData({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.summary = '',
    List<WorkExperience>? workExperience,
    List<Education>? education,
    List<String>? skills,
    List<String>? languages,
    List<String>? certifications,
  })  : workExperience = workExperience ?? [],
        education = education ?? [],
        skills = skills ?? [],
        languages = languages ?? [],
        certifications = certifications ?? [];

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'summary': summary,
      'workExperience': workExperience.map((e) => e.toJson()).toList(),
      'education': education.map((e) => e.toJson()).toList(),
      'skills': skills,
      'languages': languages,
      'certifications': certifications,
    };
  }

  factory ExtractedResumeData.fromJson(Map<String, dynamic> json) {
    return ExtractedResumeData(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      summary: json['summary'] ?? '',
      workExperience: (json['workExperience'] as List?)
              ?.map((e) => WorkExperience.fromJson(e))
              .toList() ??
          [],
      education: (json['education'] as List?)
              ?.map((e) => Education.fromJson(e))
              .toList() ??
          [],
      skills: List<String>.from(json['skills'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      certifications: List<String>.from(json['certifications'] ?? []),
    );
  }
}

class WorkExperience {
  String company;
  String position;
  DateTime? startDate;
  DateTime? endDate;
  bool isCurrentPosition;
  String description;

  WorkExperience({
    this.company = '',
    this.position = '',
    this.startDate,
    this.endDate,
    this.isCurrentPosition = false,
    this.description = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'position': position,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCurrentPosition': isCurrentPosition,
      'description': description,
    };
  }

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      company: json['company'] ?? '',
      position: json['position'] ?? '',
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isCurrentPosition: json['isCurrentPosition'] ?? false,
      description: json['description'] ?? '',
    );
  }
}

class Education {
  String institution;
  String degree;
  String field;
  DateTime? startDate;
  DateTime? endDate;
  String description;

  Education({
    this.institution = '',
    this.degree = '',
    this.field = '',
    this.startDate,
    this.endDate,
    this.description = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'degree': degree,
      'field': field,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'description': description,
    };
  }

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'] ?? '',
      degree: json['degree'] ?? '',
      field: json['field'] ?? '',
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      description: json['description'] ?? '',
    );
  }
}
