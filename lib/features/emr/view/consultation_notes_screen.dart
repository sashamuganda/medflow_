import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_card.dart';
import '../../../core/widgets/med_button.dart';
import '../../../core/widgets/med_text_field.dart';

class ConsultationNotesScreen extends StatelessWidget {
  const ConsultationNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Clinical Consultation'),
        actions: [
          MedButton(
            label: 'Save & Complete',
            type: MedButtonType.primary,
            height: 40,
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: Row(
        children: [
          // Main Content - Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Encounter Details'),
                  const SizedBox(height: 24),
                  MedCard(
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Expanded(child: MedTextField(label: 'Chief Complaint', hintText: 'e.g. Persistent cough for 2 weeks')),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const MedTextField(
                          label: 'History of Presenting Illness (HPI)',
                          hintText: 'Enter detailed clinical history...',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Examination & Assessment'),
                  const SizedBox(height: 24),
                  MedCard(
                    child: Column(
                      children: const [
                        MedTextField(
                          label: 'Physical Examination Findings',
                          hintText: 'Log observations, lung sounds, etc.',
                        ),
                        SizedBox(height: 24),
                        MedTextField(
                          label: 'Assessment / Impression',
                          hintText: 'Clinical diagnosis or working impression...',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Care Plan'),
                  const SizedBox(height: 24),
                  MedCard(
                    child: Column(
                      children: [
                        const MedTextField(
                          label: 'Treatment Plan',
                          hintText: 'Steps for recovery, lifestyle changes...',
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: MedButton(
                                label: 'Issue Prescription',
                                icon: LucideIcons.pill,
                                type: MedButtonType.secondary,
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: MedButton(
                                label: 'Order Lab Tests',
                                icon: LucideIcons.flaskConical,
                                type: MedButtonType.secondary,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Sidebar - Patient Quick Ref
          Container(
            width: 320,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(left: BorderSide(color: AppColors.slate200)),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Patient Reference', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 24),
                _buildQuickStat('Allergies', 'Penicillin, Shellfish', isCritical: true),
                _buildQuickStat('Current Meds', 'Metformin, Lisinopril'),
                _buildQuickStat('Last Vitals', 'BP: 120/80, HR: 72'),
                const Divider(height: 48),
                const Text('Voice-to-Text', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                  ),
                  child: Column(
                    children: [
                      const Icon(LucideIcons.mic, color: AppColors.primary, size: 32),
                      const SizedBox(height: 12),
                      const Text(
                        'Tap to start recording clinical notes',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.slate800),
    );
  }

  Widget _buildQuickStat(String label, String value, {bool isCritical = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isCritical ? AppColors.critical : AppColors.slate900,
            ),
          ),
        ],
      ),
    );
  }
}
