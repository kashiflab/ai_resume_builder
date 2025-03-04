import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  // Modern color scheme
  static const Color _primaryBlue = Color(0xFF2196F3);
  static const Color _accentBlue = Color(0xFF64B5F6);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Start the animation
      _controller.forward();

      // Get Supabase instance
      final supabase = Supabase.instance.client;

      // Check if user session exists and is valid
      final session = supabase.auth.currentSession;
      final isAuthenticated = session != null && !session.isExpired;

      // Add a small delay to show the animation
      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        // Navigate to appropriate screen
        if (isAuthenticated) {
          context.go(AppRoute.dashboard.path);
        } else {
          context.go(AppRoute.signIn.path);
        }
      }
    } catch (e) {
      if (mounted) {
        // If there's an error, navigate to auth screen
        context.go(AppRoute.signIn.path);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Container
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: _primaryBlue.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // PDF Icon with gradient
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Main document icon
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        _primaryBlue,
                                        _accentBlue,
                                      ],
                                    ).createShader(bounds),
                                    child: const Icon(
                                      Icons.description_outlined,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Small lines to represent text (positioned slightly right)
                                  Positioned(
                                    left: 22,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 2,
                                          decoration: BoxDecoration(
                                            color: _accentBlue.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 16,
                                          height: 2,
                                          decoration: BoxDecoration(
                                            color: _accentBlue.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 12,
                                          height: 2,
                                          decoration: BoxDecoration(
                                            color: _accentBlue.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // AI Indicator
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      _primaryBlue,
                                      _accentBlue,
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: _primaryBlue.withOpacity(0.3),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.auto_awesome,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      // App Name
                      Text(
                        'AI Resume Builder',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [
                                _primaryBlue,
                                _accentBlue,
                              ],
                            ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                            ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Tagline
                      Text(
                        'Create professional resumes with AI',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Loading Indicator
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(_primaryBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
