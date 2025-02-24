import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../models/extracted_resume_data.dart';

class PDFExtractionService {
  // Common section headers
  static const List<String> workSectionHeaders = [
    'work experience',
    'professional experience',
    'employment history',
    'work history',
    'experience',
  ];

  static const List<String> educationSectionHeaders = [
    'education',
    'educational background',
    'academic background',
    'academics',
    'qualifications',
  ];

  static const List<String> skillsSectionHeaders = [
    'skills',
    'technical skills',
    'core competencies',
    'key skills',
    'professional skills',
    'strengths & skills',
  ];

  static const List<String> summaryHeaders = [
    'professional summary',
    'summary',
    'profile',
    'career objective',
    'objective',
  ];

  Future<ExtractedResumeData> extractFromPDF(File file) async {
    try {
      // Load the PDF document
      final PdfDocument document =
          PdfDocument(inputBytes: await file.readAsBytes());
      String text = '';

      // Extract text from all pages
      for (int i = 0; i < document.pages.count; i++) {
        final PdfTextExtractor extractor = PdfTextExtractor(document);
        text += await extractor.extractText(startPageIndex: i);
        text += '\n\n';
      }

      // Dispose the document
      document.dispose();

      // Extract data using pattern matching and NLP techniques
      return _parseResumeText(text);
    } catch (e) {
      throw Exception('Failed to extract data from PDF: $e');
    }
  }

  ExtractedResumeData _parseResumeText(String text) {
    final data = ExtractedResumeData();

    // Normalize text
    text = text
        .replaceAll('\r', '\n')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();

    // Split into sections
    final sections = _splitIntoSections(text);

    // Extract data from each section
    for (final section in sections.entries) {
      final sectionText = section.value;
      final sectionHeader = section.key.toLowerCase();

      if (workSectionHeaders.any((header) => sectionHeader.contains(header))) {
        _extractWorkExperience(sectionText, data);
      } else if (educationSectionHeaders
          .any((header) => sectionHeader.contains(header))) {
        _extractEducation(sectionText, data);
      } else if (skillsSectionHeaders
          .any((header) => sectionHeader.contains(header))) {
        _extractSkills(sectionText, data);
      } else if (summaryHeaders
          .any((header) => sectionHeader.contains(header))) {
        data.summary = _cleanText(sectionText);
      } else {
        // Try to extract contact info from any section
        _extractContactInfo(sectionText.split('\n'), data);
      }
    }

    return data;
  }

  Map<String, String> _splitIntoSections(String text) {
    final Map<String, String> sections = {};
    final lines = text.split('\n');
    String currentHeader = 'Header';
    String currentContent = '';

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();

      if (line.isEmpty) continue;

      // Check if this line looks like a header
      if (_isLikelyHeader(line)) {
        // Save previous section
        if (currentContent.isNotEmpty) {
          sections[currentHeader] = currentContent.trim();
        }
        currentHeader = line;
        currentContent = '';
      } else {
        currentContent += '\n$line';
      }
    }

    // Add the last section
    if (currentContent.isNotEmpty) {
      sections[currentHeader] = currentContent.trim();
    }

    return sections;
  }

  bool _isLikelyHeader(String line) {
    // Headers are usually short, in caps, or followed by a colon
    return (line.length < 50 && line.toUpperCase() == line) ||
        line.endsWith(':') ||
        workSectionHeaders
            .any((header) => line.toLowerCase().contains(header)) ||
        educationSectionHeaders
            .any((header) => line.toLowerCase().contains(header)) ||
        skillsSectionHeaders
            .any((header) => line.toLowerCase().contains(header)) ||
        summaryHeaders.any((header) => line.toLowerCase().contains(header));
  }

  void _extractContactInfo(List<String> lines, ExtractedResumeData data) {
    for (final line in lines) {
      final trimmedLine = _cleanText(line);

      if (trimmedLine.isEmpty) continue;

      // Extract email
      if (RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')
          .hasMatch(trimmedLine)) {
        data.email = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')
                .firstMatch(trimmedLine)
                ?.group(0) ??
            '';
      }

      // Extract phone
      else if (RegExp(
              r'[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}')
          .hasMatch(trimmedLine)) {
        data.phone =
            RegExp(r'[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}')
                    .firstMatch(trimmedLine)
                    ?.group(0) ??
                '';
      }

      // Extract name - usually in the first few lines, contains 2-3 words
      else if (data.fullName.isEmpty) {
        final words = trimmedLine.split(' ');
        if (words.length >= 2 &&
            words.length <= 4 &&
            !trimmedLine.contains('@') &&
            !trimmedLine.contains('http')) {
          data.fullName = trimmedLine;
        }
      }

      // Extract address - usually contains location indicators
      else if (RegExp(
              r'(street|road|avenue|lane|drive|boulevard|city|state|zip|postal)',
              caseSensitive: false)
          .hasMatch(trimmedLine)) {
        if (data.address.isEmpty) {
          data.address = trimmedLine;
        } else {
          data.address += ', $trimmedLine';
        }
      }
    }
  }

  void _extractWorkExperience(String section, ExtractedResumeData data) {
    final lines = section.split('\n');
    WorkExperience? currentExperience;
    bool isInDescription = false;

    for (int i = 0; i < lines.length; i++) {
      final line = _cleanText(lines[i]);

      if (line.isEmpty) continue;

      // Look for date patterns to identify new experiences
      if (RegExp(r'(19|20)\d{2}\s*[-–]\s*((19|20)\d{2}|present|current|now)',
              caseSensitive: false)
          .hasMatch(line)) {
        if (currentExperience != null) {
          data.workExperience.add(currentExperience);
        }
        currentExperience = WorkExperience();
        isInDescription = false;

        // Extract dates
        final dates = line.split(RegExp(r'[-–]'));
        if (dates.length == 2) {
          try {
            currentExperience.startDate = _parseDate(dates[0]);
            currentExperience.endDate =
                dates[1].toLowerCase().contains('present')
                    ? null
                    : _parseDate(dates[1]);
            currentExperience.isCurrentPosition =
                dates[1].toLowerCase().contains('present');
          } catch (_) {}
        }

        // Next line is usually position
        if (i + 1 < lines.length) {
          currentExperience.position = _cleanText(lines[i + 1]);
          i++;
        }
      }
      // Company name usually follows position
      else if (currentExperience != null && currentExperience.company.isEmpty) {
        currentExperience.company = line;
      }
      // Rest is description
      else if (currentExperience != null) {
        isInDescription = true;
        if (isInDescription) {
          if (currentExperience.description.isEmpty) {
            currentExperience.description = line;
          } else {
            currentExperience.description += '\n$line';
          }
        }
      }
    }

    // Add the last experience
    if (currentExperience != null) {
      data.workExperience.add(currentExperience);
    }
  }

  void _extractEducation(String section, ExtractedResumeData data) {
    final lines = section.split('\n');
    Education? currentEducation;

    for (int i = 0; i < lines.length; i++) {
      final line = _cleanText(lines[i]);

      if (line.isEmpty) continue;

      // Look for degree indicators
      if (RegExp(r'(bachelor|master|phd|b\.|m\.|ph\.d|degree|diploma)',
              caseSensitive: false)
          .hasMatch(line)) {
        if (currentEducation != null) {
          data.education.add(currentEducation);
        }
        currentEducation = Education();
        currentEducation.degree = line;

        // Next line is usually institution
        if (i + 1 < lines.length) {
          currentEducation.institution = _cleanText(lines[i + 1]);
          i++;
        }
      }
      // Look for date patterns
      else if (currentEducation != null &&
          RegExp(r'(19|20)\d{2}\s*[-–]\s*((19|20)\d{2}|present|current|now)',
                  caseSensitive: false)
              .hasMatch(line)) {
        final dates = line.split(RegExp(r'[-–]'));
        if (dates.length == 2) {
          try {
            currentEducation.startDate = _parseDate(dates[0]);
            currentEducation.endDate =
                dates[1].toLowerCase().contains('present')
                    ? null
                    : _parseDate(dates[1]);
          } catch (_) {}
        }
      }
      // Rest is description
      else if (currentEducation != null) {
        if (currentEducation.description.isEmpty) {
          currentEducation.description = line;
        } else {
          currentEducation.description += '\n$line';
        }
      }
    }

    // Add the last education
    if (currentEducation != null) {
      data.education.add(currentEducation);
    }
  }

  void _extractSkills(String section, ExtractedResumeData data) {
    final lines = section.split('\n');

    for (final line in lines) {
      final trimmedLine = _cleanText(line);

      if (trimmedLine.isEmpty) continue;

      // Split by common separators
      final skills = trimmedLine
          .split(RegExp(r'[,|•|\-]'))
          .map((s) => _cleanText(s))
          .where((s) => s.isNotEmpty)
          .toList();

      data.skills.addAll(skills);
    }

    // Remove duplicates
    data.skills = data.skills.toSet().toList();
  }

  DateTime? _parseDate(String dateStr) {
    dateStr = dateStr.trim().toLowerCase();

    // Extract year
    final yearMatch = RegExp(r'(19|20)\d{2}').firstMatch(dateStr);
    if (yearMatch != null) {
      final year = int.parse(yearMatch.group(0)!);

      // Extract month if present
      int month = 1;
      for (int i = 0; i < 12; i++) {
        final monthName =
            DateTime(2000, i + 1).toString().split(' ')[1].toLowerCase();
        if (dateStr.contains(monthName)) {
          month = i + 1;
          break;
        }
      }

      return DateTime(year, month);
    }
    return null;
  }

  String _cleanText(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
