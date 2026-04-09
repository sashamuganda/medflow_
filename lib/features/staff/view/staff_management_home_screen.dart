import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:medflow_/core/widgets/med_button.dart';
import 'package:medflow_/core/widgets/med_card.dart';
import '../../../core/theme/app_colors.dart';

class StaffManagementHomeScreen extends StatelessWidget {
  const StaffManagementHomeScreen({super.key});

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
                    'Staff Management',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Manage clinical staff, rosters, and department assignments.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
              const Spacer(),
              MedButton(
                label: 'Add New Staff',
                icon: LucideIcons.userPlus,
                onPressed: () {},
                width: 190,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: const [
              Expanded(child: _StaffStat(label: 'Total Doctors', value: '18')),
              SizedBox(width: 24),
              Expanded(child: _StaffStat(label: 'Nursing Team', value: '42')),
              SizedBox(width: 24),
              Expanded(child: _StaffStat(label: 'On Shift Now', value: '14')),
              SizedBox(width: 24),
              Expanded(child: _StaffStat(label: 'Staffing Alerts', value: '2', isCritical: true)),
            ],
          ),
          const SizedBox(height: 32),
          const Text('Staff Directory', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildStaffRow('Dr. Jane Doe', 'General Medicine', 'On Shift', AppColors.routine),
          _buildStaffRow('Dr. Alan Smith', 'Emergency', 'On Call', AppColors.moderate),
          _buildStaffRow('Michael Chen', 'Surgical Nurse', 'Off Duty', AppColors.textSecondary),
          _buildStaffRow('Sarah Williams', 'Cardiology', 'On Shift', AppColors.routine),
        ],
      ),
    );
  }

  Widget _buildStaffRow(String name, String dept, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MedCard(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.slate100,
              child: Icon(LucideIcons.user, size: 18, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(dept, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                  const SizedBox(width: 12),
                  Text(status, style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            MedButton(label: 'Edit Profile', type: MedButtonType.text, onPressed: () {}),
            const SizedBox(width: 12),
            MedButton(label: 'View Roster', type: MedButtonType.secondary, height: 36, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class _StaffStat extends StatelessWidget {
  const _StaffStat({required this.label, required this.value, this.isCritical = false});
  final String label;
  final String value;
  final bool isCritical;

  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isCritical ? AppColors.critical : AppColors.slate900,
            ),
          ),
        ],
      ),
    );
  }
}
