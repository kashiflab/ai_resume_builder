import 'package:flutter/material.dart';
import '../../../domain/models/resume_model.dart';

class PersonalInfoForm extends StatefulWidget {
  final PersonalInfo? initialValue;
  final ValueChanged<PersonalInfo> onChanged;

  const PersonalInfoForm({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _linkedInController = TextEditingController();
  final _portfolioController = TextEditingController();
  final _githubController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _fullNameController.text = widget.initialValue!.fullName;
      _emailController.text = widget.initialValue!.email;
      _phoneController.text = widget.initialValue!.phone;
      _locationController.text = widget.initialValue!.location;
      _linkedInController.text = widget.initialValue!.linkedIn ?? '';
      _portfolioController.text = widget.initialValue!.portfolio ?? '';
      _githubController.text = widget.initialValue!.github ?? '';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _linkedInController.dispose();
    _portfolioController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  void _handleChange() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onChanged(
        PersonalInfo(
          fullName: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          location: _locationController.text.trim(),
          linkedIn: _linkedInController.text.trim(),
          portfolio: _portfolioController.text.trim(),
          github: _githubController.text.trim(),
          socialLinks: {}, // TODO: Add social links section
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _handleChange,
      child: Column(
        children: [
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email address',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone',
              hintText: 'Enter your phone number',
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'City, State/Province, Country',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your location';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Professional Links (Optional)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _linkedInController,
            decoration: const InputDecoration(
              labelText: 'LinkedIn Profile',
              hintText: 'https://linkedin.com/in/username',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _portfolioController,
            decoration: const InputDecoration(
              labelText: 'Portfolio Website',
              hintText: 'https://yourportfolio.com',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _githubController,
            decoration: const InputDecoration(
              labelText: 'GitHub Profile',
              hintText: 'https://github.com/username',
            ),
            keyboardType: TextInputType.url,
          ),
        ],
      ),
    );
  }
}
