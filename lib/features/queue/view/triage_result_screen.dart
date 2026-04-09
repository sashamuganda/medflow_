import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:medflow_/core/widgets/med_card.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_button.dart';

class TriageResultScreen extends StatelessWidget {
  const TriageResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('AI Triage Result')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MedCard(
                  color: AppColors.critical.withOpacity(0.04),
                  borderSide: const BorderSide(color: AppColors.critical),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.critical.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          LucideIcons.alertTriangle,
                          color: AppColors.critical,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Priority Level: Emergency',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Suggested pathway: direct to Emergency with immediate physician review. Red flags detected from chest pain, pain score, and low oxygen saturation.',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _ResultPanel(
                        title: 'Inputs Used',
                        lines: [
                          'Presenting complaint: chest pain with shortness of breath',
                          'Blood pressure: 150/96',
                          'Heart rate: 112 bpm',
                          'Temperature: 37.1 C',
                          'SpO2: 91%',
                          'Pain score: 8/10',
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _ResultPanel(
                        title: 'Governance Notes',
                        lines: [
                          'AI confidence: high',
                          'Red flags: hypoxia, tachycardia, severe pain',
                          'Staff override required: no',
                          'Decision log retained for audit and review',
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: MedButton(
                        label: 'Override Priority',
                        type: MedButtonType.secondary,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MedButton(
                        label: 'Confirm and Queue Patient',
                        icon: LucideIcons.check,
                        onPressed: () => context.go('/queue'),
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
}

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({required this.title, required this.lines});

  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 18),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Icon(
                      LucideIcons.chevronRight,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      line,
                      style: const TextStyle(color: AppColors.slate900),
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
