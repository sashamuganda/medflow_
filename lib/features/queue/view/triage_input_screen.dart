import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:medflow_/core/widgets/med_card.dart';
import 'package:medflow_/core/widgets/med_text_field.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_button.dart';

class TriageInputScreen extends StatefulWidget {
  const TriageInputScreen({super.key});

  @override
  State<TriageInputScreen> createState() => _TriageInputScreenState();
}

class _TriageInputScreenState extends State<TriageInputScreen> {
  int _painScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Patient Triage'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Initial Assessment',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter patient vitals and symptoms to determine priority level.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: MedCard(
                        color: AppColors.slate900,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white24,
                              child: Icon(LucideIcons.user, color: Colors.white, size: 32),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'John Doe',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              '34 years / Male',
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                            const SizedBox(height: 24),
                            _buildInfoRow(LucideIcons.fingerprint, 'ID: PF-2048'),
                            _buildInfoRow(LucideIcons.droplet, 'Blood: O+'),
                            _buildInfoRow(
                              LucideIcons.alertCircle,
                              'Allergies: Penicillin',
                              isCritical: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          MedCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Vitals',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: const [
                                    Expanded(child: MedTextField(label: 'Blood Pressure', hintText: '120/80')),
                                    SizedBox(width: 16),
                                    Expanded(child: MedTextField(label: 'Heart Rate', hintText: '72 bpm')),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: const [
                                    Expanded(child: MedTextField(label: 'Temperature', hintText: '36.5 C')),
                                    SizedBox(width: 16),
                                    Expanded(child: MedTextField(label: 'SpO2', hintText: '98%')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          MedCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Symptoms & Complaints',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 24),
                                const MedTextField(
                                  label: 'Presenting Complaint',
                                  hintText: 'Describe the main reason for visit...',
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  'Pain Score',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                Slider(
                                  value: _painScore.toDouble(),
                                  min: 0,
                                  max: 10,
                                  divisions: 10,
                                  label: _painScore.toString(),
                                  activeColor: _getPainColor(_painScore),
                                  onChanged: (value) => setState(() => _painScore = value.toInt()),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('No Pain', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                    Text('Severe', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Expanded(
                                child: MedButton(
                                  label: 'Cancel',
                                  type: MedButtonType.secondary,
                                  onPressed: () => context.pop(),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: MedButton(
                                  label: 'Run AI Triage',
                                  icon: LucideIcons.activity,
                                  onPressed: () => context.go('/triage/result'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool isCritical = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isCritical ? AppColors.critical : Colors.white54),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: isCritical ? AppColors.critical : Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPainColor(int score) {
    if (score < 3) {
      return AppColors.routine;
    }
    if (score < 7) {
      return AppColors.moderate;
    }
    return AppColors.critical;
  }
}
