import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../styles/auth_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _careerGoalsController = TextEditingController();
  final _jobPreferencesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    final user = context.read<AuthBloc>().state.user;
    if (user != null) {
      _fullNameController.text = user.fullName ?? '';
      _careerGoalsController.text = _formatMap(user.careerGoals);
      _jobPreferencesController.text = _formatMap(user.jobPreferences);
    }
  }

  String _formatMap(Map<String, dynamic>? map) {
    if (map == null) return '';
    return map.entries.map((e) => '${e.key}: ${e.value}').join('\n');
  }

  Map<String, dynamic> _parseText(String text) {
    final map = <String, dynamic>{};
    final lines = text.split('\n');
    for (final line in lines) {
      final parts = line.split(':');
      if (parts.length == 2) {
        map[parts[0].trim()] = parts[1].trim();
      }
    }
    return map;
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final user = context.read<AuthBloc>().state.user;
      if (user != null) {
        final updatedUser = user.copyWith(
          fullName: _fullNameController.text.trim(),
          careerGoals: _parseText(_careerGoalsController.text),
          jobPreferences: _parseText(_jobPreferencesController.text),
        );

        context.read<AuthBloc>().add(UpdateProfileEvent(user: updatedUser));
      }
    }
  }

  void _handleSignOut() {
    context.read<AuthBloc>().add(const SignOutEvent());
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _careerGoalsController.dispose();
    _jobPreferencesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleSignOut,
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) return const SizedBox();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AuthStyles.horizontalPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              AppTheme.primaryColor.withOpacity(0.1),
                          backgroundImage: user.photoUrl != null
                              ? NetworkImage(user.photoUrl!)
                              : null,
                          child: user.photoUrl == null
                              ? Text(
                                  user.fullName
                                          ?.substring(0, 1)
                                          .toUpperCase() ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    controller: _fullNameController,
                    textCapitalization: TextCapitalization.words,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: AuthStyles.spacing),
                  CustomTextField(
                    label: 'Career Goals',
                    hint: 'Enter your career goals (one per line)',
                    controller: _careerGoalsController,
                    maxLines: 5,
                    prefixIcon: Icons.flag_outlined,
                  ),
                  const SizedBox(height: AuthStyles.spacing),
                  CustomTextField(
                    label: 'Job Preferences',
                    hint: 'Enter your job preferences (one per line)',
                    controller: _jobPreferencesController,
                    maxLines: 5,
                    prefixIcon: Icons.work_outline,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'Save Changes',
                    onPressed: _handleSave,
                    isLoading: state.isLoading,
                    height: AuthStyles.buttonHeight,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
