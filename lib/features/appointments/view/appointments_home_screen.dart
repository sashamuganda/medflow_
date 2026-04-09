import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:medflow_/core/widgets/med_button.dart';
import 'package:medflow_/core/widgets/med_card.dart';

import '../../../core/theme/app_colors.dart';

class AppointmentsHomeScreen extends StatelessWidget {
  const AppointmentsHomeScreen({super.key});

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
                    'Appointments & Scheduling',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      color: AppColors.slate900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Manage daily schedules and patient bookings.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                  ),
                ],
              ),
              const Spacer(),
              MedButton(
                label: 'Book Appointment',
                icon: LucideIcons.calendarPlus,
                onPressed: () => context.go('/appointments/detail'),
                width: 200,
              ),
              const SizedBox(width: 12),
              MedButton(
                label: 'Calendar View',
                icon: LucideIcons.calendar,
                type: MedButtonType.secondary,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _buildTab('Today', true),
              _buildTab('Upcoming', false),
              _buildTab('Pending Approval', false),
              _buildTab('Cancelled', false),
              const Spacer(),
              Container(
                width: 240,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: Row(
                  children: const [
                    Icon(LucideIcons.search, size: 16, color: AppColors.textSecondary),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search appointments...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildDoctorSection('Dr. Jane Doe', 'General Medicine'),
          const SizedBox(height: 16),
          _buildAppointmentCard(
            context,
            time: '09:00 AM',
            patient: 'Sarah Williams',
            type: 'In-Person',
            status: 'Confirmed',
            statusColor: AppColors.primary,
          ),
          _buildAppointmentCard(
            context,
            time: '10:30 AM',
            patient: 'Michael Chen',
            type: 'Telemedicine',
            status: 'Checked In',
            statusColor: AppColors.moderate,
          ),
          const SizedBox(height: 32),
          _buildDoctorSection('Dr. Alan Smith', 'Emergency'),
          const SizedBox(height: 16),
          _buildAppointmentCard(
            context,
            time: '11:15 AM',
            patient: 'Amanda Ross',
            type: 'In-Person',
            status: 'In Progress',
            statusColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
              fontSize: 15,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 20,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDoctorSection(String name, String dept) {
    return Row(
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(width: 8),
        Text(
          '/ $dept',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(
    BuildContext context, {
    required String time,
    required String patient,
    required String type,
    required String status,
    required Color statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MedCard(
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                time,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.slate100,
                    child: Icon(LucideIcons.user, size: 14),
                  ),
                  const SizedBox(width: 12),
                  Text(patient, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    type == 'Telemedicine' ? LucideIcons.video : LucideIcons.mapPin,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(type, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 32),
            MedButton(
              label: 'Details',
              type: MedButtonType.text,
              onPressed: () => context.go('/appointments/detail'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.02, end: 0);
  }
}
