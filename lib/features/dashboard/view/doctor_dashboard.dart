import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_card.dart';
import '../../../core/widgets/med_button.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

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
                    'Welcome back, Dr. Jane Doe',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      color: AppColors.slate900,
                    ),
                  ),
                  Text(
                    'You have 12 appointments today. 3 patients are currently waiting.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                  ),
                ],
              ),
              const Spacer(),
              MedButton(
                label: 'Go Available',
                icon: LucideIcons.video,
                onPressed: () {},
                width: 180,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Column - Schedule
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Schedule',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    _buildAppointmentItem(
                      time: '09:00 AM',
                      patient: 'Sarah Jenkins',
                      type: 'General Consultation',
                      status: 'Completed',
                      isPast: true,
                    ),
                    _buildAppointmentItem(
                      time: '10:30 AM',
                      patient: 'Michael Chen',
                      type: 'Telemedicine Call',
                      status: 'In Progress',
                      isActive: true,
                    ),
                    _buildAppointmentItem(
                      time: '11:15 AM',
                      patient: 'Amanda Ross',
                      type: 'Follow-up Visit',
                      status: 'Checked In',
                    ),
                    _buildAppointmentItem(
                      time: '12:00 PM',
                      patient: 'Robert Wilson',
                      type: 'Lab Review',
                      status: 'Upcoming',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              // Side Column - Queue & Tasks
              Expanded(
                child: Column(
                  children: [
                    _buildMyQueueCard(),
                    const SizedBox(height: 24),
                    _buildPendingTasksCard(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(duration: 300.ms),
    );
  }

  Widget _buildAppointmentItem({
    required String time,
    required String patient,
    required String type,
    required String status,
    bool isActive = false,
    bool isPast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MedCard(
        color: isActive ? AppColors.primary.withOpacity(0.02) : null,
        borderSide: isActive ? const BorderSide(color: AppColors.primary, width: 1.5) : null,
        child: Row(
          children: [
            Container(
              width: 80,
              child: Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPast ? AppColors.textSecondary : AppColors.slate900,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: AppColors.slate200,
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isPast ? AppColors.textSecondary : AppColors.slate900,
                    ),
                  ),
                  Text(type, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),
            _buildStatusBadge(status),
            const SizedBox(width: 24),
            MedButton(
              label: isActive ? 'Resume' : (isPast ? 'View' : 'Start'),
              type: isActive ? MedButtonType.primary : MedButtonType.secondary,
              height: 36,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Completed':
        color = AppColors.routine;
        break;
      case 'In Progress':
        color = AppColors.primary;
        break;
      case 'Checked In':
        color = AppColors.moderate;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMyQueueCard() {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Patient Queue',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Icon(LucideIcons.users, color: AppColors.primary, size: 18),
            ],
          ),
          const SizedBox(height: 20),
          _buildQueueItem('Amanda Ross', 'Wait: 12m', AppColors.routine),
          _buildQueueItem('John Doe', 'Wait: 24m', AppColors.moderate),
          _buildQueueItem('Kevin Hart', 'Wait: 45m', AppColors.critical),
          const SizedBox(height: 16),
          MedButton(
            label: 'View Full Queue',
            type: MedButtonType.text,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem(String name, String wait, Color triageColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 4, height: 24, decoration: BoxDecoration(color: triageColor, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(wait, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPendingTasksCard() {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pending Tasks',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTaskItem(LucideIcons.flaskConical, 'Review Lab Results', '4 Pending'),
          _buildTaskItem(LucideIcons.pill, 'E-Prescriptions', '2 To Sign'),
          _buildTaskItem(LucideIcons.clipboard, 'Clinical Notes', '1 Incomplete'),
        ],
      ),
    );
  }

  Widget _buildTaskItem(IconData icon, String title, String count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.slate800),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 14))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(4)),
            child: Text(count, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}
