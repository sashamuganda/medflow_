import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_button.dart';
import '../../../core/widgets/med_card.dart';

class FrontDeskDashboard extends StatelessWidget {
  const FrontDeskDashboard({super.key});

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
                    'Reception Operations',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '46 arrivals expected today, 31 checked in, 6 no-shows at risk.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
              const Spacer(),
              MedButton(
                label: 'Check In Patient',
                icon: LucideIcons.check,
                onPressed: () => context.go('/queue'),
                width: 180,
              ),
              const SizedBox(width: 12),
              MedButton(
                label: 'Book Appointment',
                type: MedButtonType.secondary,
                icon: LucideIcons.calendarPlus,
                onPressed: () => context.go('/appointments'),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: const [
              Expanded(child: _FrontDeskStat(label: 'Checked In', value: '31')),
              SizedBox(width: 20),
              Expanded(child: _FrontDeskStat(label: 'Waiting', value: '18')),
              SizedBox(width: 20),
              Expanded(child: _FrontDeskStat(label: 'Walk-Ins', value: '9')),
              SizedBox(width: 20),
              Expanded(child: _FrontDeskStat(label: 'Capacity', value: '84%')),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(flex: 2, child: _ArrivalList()),
              SizedBox(width: 20),
              Expanded(child: _QuickActionsPanel()),
            ],
          ),
        ],
      ),
    );
  }
}

class _FrontDeskStat extends StatelessWidget {
  const _FrontDeskStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 18),
          Text(
            value,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ArrivalList extends StatelessWidget {
  const _ArrivalList();

  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Arrival Watchlist',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 20),
          _ArrivalRow(name: 'Amanda Ross', time: '10:30 AM', status: 'Checked In'),
          _ArrivalRow(name: 'David Mwangi', time: '10:45 AM', status: 'Waiting'),
          _ArrivalRow(name: 'Grace Oduor', time: '11:00 AM', status: 'Expected'),
          _ArrivalRow(name: 'Peter Njoroge', time: '11:15 AM', status: 'Expected'),
        ],
      ),
    );
  }
}

class _ArrivalRow extends StatelessWidget {
  const _ArrivalRow({
    required this.name,
    required this.time,
    required this.status,
  });

  final String name;
  final String time;
  final String status;

  @override
  Widget build(BuildContext context) {
    final statusColor = status == 'Checked In'
        ? AppColors.routine
        : status == 'Waiting'
            ? AppColors.moderate
            : AppColors.textSecondary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsPanel extends StatelessWidget {
  const _QuickActionsPanel();

  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          const _ActionLine(icon: LucideIcons.userPlus, label: 'Register walk-in'),
          const _ActionLine(icon: LucideIcons.search, label: 'Find existing patient'),
          const _ActionLine(icon: LucideIcons.printer, label: 'Print queue ticket'),
          const _ActionLine(icon: LucideIcons.phone, label: 'Call missing patient'),
          const SizedBox(height: 16),
          MedButton(
            label: 'Open Appointments',
            onPressed: () => context.go('/appointments'),
          ),
        ],
      ),
    );
  }
}

class _ActionLine extends StatelessWidget {
  const _ActionLine({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
