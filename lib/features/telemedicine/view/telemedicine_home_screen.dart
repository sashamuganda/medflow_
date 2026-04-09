import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:medflow_/core/widgets/med_button.dart';
import 'package:medflow_/core/widgets/med_card.dart';
import '../../../core/theme/app_colors.dart';

class TelemedicineHomeScreen extends StatelessWidget {
  const TelemedicineHomeScreen({super.key});

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
                    'Telemedicine Hub',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Manage virtual consultations and on-demand care.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
              const Spacer(),
              MedButton(
                label: 'Start Instant Meeting',
                icon: LucideIcons.video,
                onPressed: () {},
                width: 220,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ongoing & Upcoming Sessions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    _buildMeetingCard(
                      patient: 'Michael Chen',
                      time: '10:30 AM (In 15m)',
                      type: 'Follow-up',
                      status: 'Waiting',
                    ),
                    _buildMeetingCard(
                      patient: 'Sarah Jenkins',
                      time: '11:15 AM',
                      type: 'Consultation',
                      status: 'Scheduled',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: MedCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Virtual Waiting Room', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      _buildWaitingItem('Kevin Hart', 'Joined 4m ago'),
                      _buildWaitingItem('Emily Davis', 'Joined 12m ago'),
                      const SizedBox(height: 16),
                      MedButton(
                        label: 'Admit Next Patient',
                        type: MedButtonType.secondary,
                        onPressed: () {},
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingCard({required String patient, required String time, required String type, required String status}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MedCard(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(LucideIcons.video, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(patient, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('$type · $time', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.slate100, borderRadius: BorderRadius.circular(8)),
              child: Text(status, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 20),
            MedButton(label: 'Join', height: 36, onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildWaitingItem(String name, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const CircleAvatar(radius: 4, backgroundColor: AppColors.routine),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}
