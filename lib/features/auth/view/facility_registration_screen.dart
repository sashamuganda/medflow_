import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:medflow_/core/widgets/med_text_field.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_button.dart';

class FacilityRegistrationScreen extends StatefulWidget {
  const FacilityRegistrationScreen({super.key});

  @override
  State<FacilityRegistrationScreen> createState() => _FacilityRegistrationScreenState();
}

class _FacilityRegistrationScreenState extends State<FacilityRegistrationScreen> {
  int _currentStep = 0;
  final int _totalSteps = 4;

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      return;
    }
    context.go('/login');
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Container(
            width: 360,
            color: AppColors.slate900,
            padding: const EdgeInsets.all(48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(LucideIcons.activity, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'MedFlow',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                const Text(
                  'Register Your Facility',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Complete these steps to set up your clinical environment.',
                  style: TextStyle(color: Colors.white54, fontSize: 15),
                ),
                const SizedBox(height: 64),
                _buildStepIndicator(0, 'Facility Basics'),
                _buildStepIndicator(1, 'Facility Profile'),
                _buildStepIndicator(2, 'Admin Account'),
                _buildStepIndicator(3, 'Verification'),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(64),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStepContent(),
                      const SizedBox(height: 48),
                      Row(
                        children: [
                          MedButton(
                            label: 'Back',
                            type: MedButtonType.secondary,
                            onPressed: _prevStep,
                          ),
                          const Spacer(),
                          MedButton(
                            label: _currentStep == _totalSteps - 1 ? 'Complete Setup' : 'Continue',
                            onPressed: _nextStep,
                            width: 200,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    final isActive = _currentStep == step;
    final isCompleted = _currentStep > step;

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive || isCompleted ? AppColors.primary : Colors.white12,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(LucideIcons.check, color: Colors.white, size: 16)
                  : Text(
                      '${step + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white54,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildBasicsStep();
      case 1:
        return _buildProfileStep();
      case 2:
        return _buildAdminStep();
      case 3:
        return _buildVerificationStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildBasicsStep() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Step 1', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Facility Basics', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        SizedBox(height: 32),
        MedTextField(label: 'Facility Name', hintText: 'City General Hospital'),
        SizedBox(height: 24),
        MedTextField(label: 'Facility Type', hintText: 'Hospital / Clinic / Lab / Pharmacy'),
        SizedBox(height: 24),
        MedTextField(label: 'Physical Address', hintText: '123 Medical Drive, Health City'),
        SizedBox(height: 24),
        MedTextField(label: 'Official Email', hintText: 'admin@hospital.com'),
        SizedBox(height: 24),
        MedTextField(label: 'License Number', hintText: 'LIC-2026-00418'),
      ],
    );
  }

  Widget _buildProfileStep() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Step 2', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Facility Profile', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        SizedBox(height: 32),
        MedTextField(label: 'Number of Beds', hintText: '50', keyboardType: TextInputType.number),
        SizedBox(height: 24),
        MedTextField(label: 'Operating Hours', hintText: '24/7 or 08:00 - 20:00'),
        SizedBox(height: 24),
        Text('Available Departments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Text(
          'Emergency, Cardiology, Pediatrics, General Medicine, Maternity...',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildAdminStep() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Step 3', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Admin Account Setup', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        SizedBox(height: 32),
        MedTextField(label: 'Full Name', hintText: 'Jane Doe'),
        SizedBox(height: 24),
        MedTextField(label: 'Role', hintText: 'Facility Administrator'),
        SizedBox(height: 24),
        MedTextField(label: 'Work Email', hintText: 'jane.doe@hospital.com'),
        SizedBox(height: 24),
        MedTextField(label: 'Phone Number', hintText: '+254 700 000000'),
        SizedBox(height: 24),
        MedTextField(label: 'Password', hintText: '........', obscureText: true),
      ],
    );
  }

  Widget _buildVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Step 4', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Verification', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text(
          'Upload the facility operating license, accreditation certificate, and a government ID for the registering administrator.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
        const SizedBox(height: 32),
        _buildUploadCard('Operating License', 'PDF, JPG, or PNG'),
        const SizedBox(height: 16),
        _buildUploadCard('Accreditation Certificate', 'PDF, JPG, or PNG'),
        const SizedBox(height: 16),
        _buildUploadCard('Administrator ID', 'Passport or national ID'),
      ],
    );
  }

  Widget _buildUploadCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.fileUp, color: AppColors.primary, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          const MedButton(label: 'Upload', type: MedButtonType.secondary, height: 40),
        ],
      ),
    );
  }
}
