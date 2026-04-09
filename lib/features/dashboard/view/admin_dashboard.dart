import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_card.dart';
import '../../../core/widgets/med_button.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

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
                children: [
                  const Text(
                    'Facility Overview',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      color: AppColors.slate900,
                    ),
                  ),
                  Text(
                    'Real-time metrics for City General Hospital',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                  ),
                ],
              ),
              const Spacer(),
              MedButton(
                label: 'Add Staff Member',
                icon: LucideIcons.userPlus,
                onPressed: () {},
                width: 200,
              ),
              const SizedBox(width: 12),
              MedButton(
                label: 'Generate Report',
                icon: LucideIcons.barChart3,
                type: MedButtonType.secondary,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 40),
          // Summary Cards
          Row(
            children: [
              const Expanded(
                child: _MetricCard(
                  label: 'Total Patients',
                  value: '1,248',
                  trend: '+12%',
                  isPositive: true,
                  icon: LucideIcons.users,
                ),
              ),
              const SizedBox(width: 24),
              const Expanded(
                child: _MetricCard(
                  label: 'Waiting in Queue',
                  value: '42',
                  trend: '-5%',
                  isPositive: true,
                  icon: LucideIcons.clock,
                ),
              ),
              const SizedBox(width: 24),
              const Expanded(
                child: _MetricCard(
                  label: 'Active Doctors',
                  value: '18',
                  trend: 'Stable',
                  isPositive: null,
                  icon: LucideIcons.stethoscope,
                ),
              ),
              const SizedBox(width: 24),
              const Expanded(
                child: _MetricCard(
                  label: 'Bed Occupancy',
                  value: '84%',
                  trend: '+2%',
                  isPositive: false,
                  icon: LucideIcons.bed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Analytics & Flags
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: MedCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Patient Flow Analytics',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<String>(
                            value: 'Last 24 Hours',
                            underline: const SizedBox(),
                            items: ['Last 24 Hours', 'Last 7 Days', 'Monthly']
                                .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14))))
                                .toList(),
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Mock Chart
                      Container(
                        height: 280,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(
                            12,
                            (index) => Container(
                              width: 32,
                              height: (index % 5 + 3) * 30.0,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1 + (index / 12) * 0.5),
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ChartLegend(color: AppColors.primary, label: 'Arrivals'),
                          const SizedBox(width: 24),
                          _ChartLegend(color: AppColors.primaryLight, label: 'Discharges'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: MedCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Urgent Flags',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      _UrgentFlagItem(
                        title: 'ER Over Capacity',
                        subtitle: 'Wait times exceeding 2 hours',
                        type: MedButtonType.critical,
                      ),
                      const SizedBox(height: 16),
                      _UrgentFlagItem(
                        title: 'Bed Shortage',
                        subtitle: 'Only 3 beds available in ICU',
                        type: MedButtonType.critical,
                      ),
                      const SizedBox(height: 16),
                      _UrgentFlagItem(
                        title: 'Lab Backlog',
                        subtitle: 'Blood tests delayed by 4 hours',
                        type: MedButtonType.secondary,
                      ),
                      const SizedBox(height: 32),
                      MedButton(
                        label: 'View All Alerts',
                        type: MedButtonType.text,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(duration: 300.ms),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final bool? isPositive;
  final IconData icon;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MedCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              if (isPositive != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isPositive! ? AppColors.routine : AppColors.critical).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    trend,
                    style: TextStyle(
                      color: isPositive! ? AppColors.routine : AppColors.critical,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.slate900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
      ],
    );
  }
}

class _UrgentFlagItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final MedButtonType type;

  const _UrgentFlagItem({required this.title, required this.subtitle, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = type == MedButtonType.critical ? AppColors.critical : AppColors.slate800;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.alertTriangle, color: color, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 15)),
                Text(subtitle, style: TextStyle(color: color.withOpacity(0.7), fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
