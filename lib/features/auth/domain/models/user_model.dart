import 'package:equatable/equatable.dart';

/// User model representing the authenticated user
class UserModel extends Equatable {
  final String id;
  final String? email;
  final String? fullName;
  final String? photoUrl;
  final String? provider;
  final Map<String, dynamic>? careerGoals;
  final Map<String, dynamic>? jobPreferences;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.id,
    this.email,
    this.fullName,
    this.photoUrl,
    this.provider,
    this.careerGoals,
    this.jobPreferences,
    this.createdAt,
    this.updatedAt,
  });

  /// Create a user model from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      fullName: json['full_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      provider: json['provider'] as String?,
      careerGoals: json['career_goals'] as Map<String, dynamic>?,
      jobPreferences: json['job_preferences'] as Map<String, dynamic>?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// Convert user model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'photo_url': photoUrl,
      'provider': provider,
      'career_goals': careerGoals,
      'job_preferences': jobPreferences,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Create a copy of the user model with updated fields
  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? photoUrl,
    String? provider,
    Map<String, dynamic>? careerGoals,
    Map<String, dynamic>? jobPreferences,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      photoUrl: photoUrl ?? this.photoUrl,
      provider: provider ?? this.provider,
      careerGoals: careerGoals ?? this.careerGoals,
      jobPreferences: jobPreferences ?? this.jobPreferences,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        photoUrl,
        provider,
        careerGoals,
        jobPreferences,
        createdAt,
        updatedAt,
      ];
}
