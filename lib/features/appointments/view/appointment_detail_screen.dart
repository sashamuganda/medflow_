import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:medflow_/core/widgets/med_button.dart';
import 'package:medflow_/core/widgets/med_card.dart';

import '../../../core/theme/app_colors.dart';

class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Appointment Detail',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Operational view for check-in, consultation start, reschedule, or cancellation.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
              const Spacer(),
              MedButton(
                label: 'Start Consultation',
                icon: LucideIcons.play,
                onPressed: () => context.go('/consultation'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          MedCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MetaLine(label: 'Patient', value: 'Sarah Williams / PF-2024-0042'),
                      _MetaLine(label: 'Doctor', value: 'Dr. Jane Doe'),
                      _MetaLine(label: 'Department', value: 'General Medicine'),
                      _MetaLine(label: 'Date & Time', value: '09 Apr 2026 / 10:30 AM'),
                      _MetaLine(label: 'Type', value: 'Telemedicine'),
                      _MetaLine(label: 'Status', value: 'Checked In'),
                    ],
                  ),
                ),
                SizedBox(width: 24),
                Expanded(child: _NotesPanel()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotesPanel extends StatelessWidget {
  const _NotesPanel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Submitted Notes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        const Text(
          'Patient reports fatigue, increased thirst, and requests review of recent HbA1c results.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            MedButton(
              label: 'Check In Patient',
              type: MedButtonType.secondary,
              onPressed: () {},
            ),
            MedButton(
              label: 'Reschedule',
              type: MedButtonType.secondary,
              onPressed: () {},
            ),
            MedButton(
              label: 'Cancel',
              type: MedButtonType.critical,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
