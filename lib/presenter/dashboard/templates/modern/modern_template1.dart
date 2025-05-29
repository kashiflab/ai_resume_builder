import 'package:flutter/material.dart';

class ModernResumeTemplate extends StatelessWidget {
  final String name;
  final String profession;
  final String email;
  final String phone;
  final String address;
  final String summary;
  final List<String> skills;
  final List<Map<String, String>> experience;
  final List<Map<String, String>> education;

  // A4 dimensions in points (72 points = 1 inch)
  static const double a4Width = 595.0;
  static const double a4Height = 842.0;

  ModernResumeTemplate({
    required this.name,
    required this.profession,
    required this.email,
    required this.phone,
    required this.address,
    required this.summary,
    required this.skills,
    required this.experience,
    required this.education,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Resume Preview"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: AspectRatio(
            aspectRatio: a4Width / a4Height,
            child: Container(
              width: a4Width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 6,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(a4Width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Center(
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: a4Width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: a4Height * 0.01),
                        Text(
                          profession,
                          style: TextStyle(
                            fontSize: a4Width * 0.024,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: a4Height * 0.02),
                  const Divider(color: Colors.grey),

                  // Contact Info
                  const SizedBox(height: a4Height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _contactInfo(Icons.email, email),
                      _contactInfo(Icons.phone, phone),
                      _contactInfo(Icons.location_on, address),
                    ],
                  ),
                  const SizedBox(height: a4Height * 0.015),
                  const Divider(color: Colors.grey),

                  // Summary Section
                  _sectionTitle("Summary"),
                  Text(
                    summary,
                    style: const TextStyle(
                      fontSize: a4Width * 0.018,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: a4Height * 0.02),

                  // Skills Section
                  _sectionTitle("Skills"),
                  Wrap(
                    spacing: a4Width * 0.015,
                    runSpacing: a4Height * 0.008,
                    children: skills.map((skill) {
                      return Chip(
                        label: Text(
                          skill,
                          style: const TextStyle(
                            fontSize: a4Width * 0.016,
                            color: Colors.black87,
                          ),
                        ),
                        backgroundColor: Colors.grey[200],
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: a4Width * 0.01,
                          vertical: a4Height * 0.002,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: a4Height * 0.02),

                  // Experience Section
                  _sectionTitle("Experience"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: experience.map((job) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: a4Height * 0.015),
                        child: _experienceItem(job['title']!, job['company']!,
                            job['date']!, job['description']!),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: a4Height * 0.02),

                  // Education Section
                  _sectionTitle("Education"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: education.map((edu) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: a4Height * 0.015),
                        child: _educationItem(
                            edu['degree']!, edu['institution']!, edu['year']!),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Contact Info Widget
  Widget _contactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: a4Width * 0.02, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: a4Width * 0.018, color: Colors.grey[800]),
        ),
      ],
    );
  }

  // Section Title Widget
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: a4Height * 0.01),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: a4Width * 0.025,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Experience Item Widget
  Widget _experienceItem(
      String title, String company, String date, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: a4Width * 0.022,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        Text(
          "$company | $date",
          style: TextStyle(
              fontSize: a4Width * 0.018,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]),
        ),
        const SizedBox(height: a4Height * 0.008),
        Text(
          description,
          style: const TextStyle(
              fontSize: a4Width * 0.018, color: Colors.black87, height: 1.4),
        ),
      ],
    );
  }

  // Education Item Widget
  Widget _educationItem(String degree, String institution, String year) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          degree,
          style: const TextStyle(
              fontSize: a4Width * 0.022,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        Text(
          "$institution | $year",
          style: TextStyle(
              fontSize: a4Width * 0.018,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]),
        ),
      ],
    );
  }
}
