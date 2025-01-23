import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/forgot_password/forgot_password_bloc.dart';
import '../styles/auth_styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordBloc>().add(
            SendResetPasswordEmailEvent(
              email: _emailController.text.trim(),
            ),
          );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Check Your Email'),
        content: const Text(
          'We have sent a password reset link to your email address. Please check your inbox and follow the instructions to reset your password.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/auth/signin');
            },
            child: const Text('Back to Sign In'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listenWhen: (previous, current) =>
            previous.isSuccess != current.isSuccess ||
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.isSuccess) {
            _showSuccessDialog();
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AuthStyles.horizontalPadding,
                vertical: AuthStyles.verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Forgot Password?',
                    style: AuthStyles.titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter your email address and we\'ll send you instructions to reset your password',
                    style: AuthStyles.subtitleStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AuthStyles.inputDecoration(
                        label: 'Email',
                        hint: 'Enter your email',
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
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
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Reset Password',
                    onPressed: _handleResetPassword,
                    isLoading: state.isLoading,
                    height: AuthStyles.buttonHeight,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Remember your password? ',
                        style: AuthStyles.subtitleStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          context.go('/auth/signin');
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
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
