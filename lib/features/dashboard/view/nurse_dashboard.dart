import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_button.dart';
import '../../../core/widgets/med_card.dart';

class NurseDashboard extends StatelessWidget {
  const NurseDashboard({super.key});

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
                    'Ward Operations',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Surgical Ward B, 16 patients assigned, 5 tasks due in the next hour.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
              const Spacer(),
              MedButton(
                label: 'Quick Log Vitals',
                icon: LucideIcons.heart,
                onPressed: () => context.go('/patient'),
                width: 190,
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: const [
              Expanded(child: _NurseStatCard(label: 'Patients In Care', value: '16')),
              SizedBox(width: 20),
              Expanded(child: _NurseStatCard(label: 'Medications Due', value: '9')),
              SizedBox(width: 20),
              Expanded(child: _NurseStatCard(label: 'Vitals Overdue', value: '3')),
              SizedBox(width: 20),
              Expanded(child: _NurseStatCard(label: 'Urgent Flags', value: '2', critical: true)),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                flex: 2,
                child: _TaskPanel(),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _WardSnapshot(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NurseStatCard extends StatelessWidget {
  const _NurseStatCard({
    required this.label,
    required this.value,
    this.critical = false,
  });

  final String label;
  final String value;
  final bool critical;

  @override
  Widget build(BuildContext context) {
    final color = critical ? AppColors.critical : AppColors.primary;
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskPanel extends StatelessWidget {
  const _TaskPanel();

  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Pending Clinical Tasks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 20),
          _TaskRow(
            color: AppColors.critical,
            patient: 'Michael Chen',
            task: 'Repeat vitals and oxygen saturation',
            due: 'Due now',
          ),
          _TaskRow(
            color: AppColors.moderate,
            patient: 'Emily Davis',
            task: 'Administer IV antibiotics',
            due: 'In 12 min',
          ),
          _TaskRow(
            color: AppColors.primary,
            patient: 'Robert Wilson',
            task: 'Document wound dressing change',
            due: 'In 25 min',
          ),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({
    required this.color,
    required this.patient,
    required this.task,
    required this.due,
  });

  final Color color;
  final String patient;
  final String task;
  final String due;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(task, style: const TextStyle(color: AppColors.slate900)),
              ],
            ),
          ),
          Text(
            due,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

class _WardSnapshot extends StatelessWidget {
  const _WardSnapshot();

  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Assigned Patients',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          const _PatientLine(name: 'Bed 04', meta: 'Emily Davis · post-op observation'),
          const _PatientLine(name: 'Bed 07', meta: 'Michael Chen · oxygen monitoring'),
          const _PatientLine(name: 'Bed 11', meta: 'Sarah Williams · medication round at 14:00'),
          const SizedBox(height: 16),
          MedButton(
            label: 'Open Patient Record',
            type: MedButtonType.secondary,
            onPressed: () => context.go('/patient'),
          ),
        ],
      ),
    );
  }
}

class _PatientLine extends StatelessWidget {
  const _PatientLine({required this.name, required this.meta});

  final String name;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(meta, style: const TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
