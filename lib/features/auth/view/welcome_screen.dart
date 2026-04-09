import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F172A), // Slate 900
                  Color(0xFF1E293B), // Slate 800
                ],
              ),
            ),
          ),
          // Subtle Pattern or Logo in background
          Positioned(
            right: -100,
            top: -100,
            child: Icon(
              LucideIcons.activity,
              size: 400,
              color: AppColors.primary.withOpacity(0.05),
            ),
          ),
          Center(
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(LucideIcons.activity, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'MedFlow',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Hospital & Staff Management System',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 64),
                  MedButton(
                    label: 'Staff Log In',
                    width: double.infinity,
                    onPressed: () => context.push('/login'),
                  ),
                  const SizedBox(height: 16),
                  MedButton(
                    label: 'Register Your Facility',
                    width: double.infinity,
                    type: MedButtonType.outline,
                    onPressed: () => context.push('/register'),
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    'Verified healthcare providers only',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
