import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:medflow_/core/widgets/med_card.dart';

import '../../../core/models/app_models.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_button.dart';

class QueueOverview extends ConsumerWidget {
  const QueueOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patients = ref.watch(queuePatientsProvider);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Master Patient Queue',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                          color: AppColors.slate900,
                        ),
                      ),
                      Text(
                        '${patients.length} active patients across 8 departments',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
                      ),
                    ],
                  ),
                  const Spacer(),
                  MedButton(
                    label: 'New Patient / Walk-in',
                    icon: LucideIcons.userPlus,
                    onPressed: () => context.push('/triage'),
                    width: 220,
                  ),
                  const SizedBox(width: 12),
                  MedButton(
                    label: 'Filter',
                    icon: LucideIcons.filter,
                    type: MedButtonType.secondary,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  _buildMiniStat('Emergency', '12', AppColors.critical),
                  const SizedBox(width: 16),
                  _buildMiniStat('General', '18', AppColors.primary),
                  const SizedBox(width: 16),
                  _buildMiniStat('Cardiology', '5', AppColors.moderate),
                  const SizedBox(width: 16),
                  _buildMiniStat('Pediatrics', '7', AppColors.routine),
                ],
              ).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 32),
              MedCard(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: AppColors.slate50,
                borderSide: BorderSide.none,
                child: Row(
                  children: const [
                    Expanded(flex: 3, child: Text('PATIENT', style: _headerStyle)),
                    Expanded(flex: 2, child: Text('DEPARTMENT', style: _headerStyle)),
                    Expanded(flex: 2, child: Text('WAITING', style: _headerStyle)),
                    Expanded(flex: 2, child: Text('STATUS', style: _headerStyle)),
                    Expanded(flex: 2, child: Text('TRIAGE', style: _headerStyle)),
                    SizedBox(width: 100),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ]),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _QueueRow(patient: patients[index], index: index);
              },
              childCount: patients.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  Widget _buildMiniStat(String label, String count, Color color) {
    return MedCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(width: 12),
          Text(
            count,
            style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
    letterSpacing: 1.1,
  );
}

class _QueueRow extends StatelessWidget {
  const _QueueRow({required this.patient, required this.index});

  final QueuePatient patient;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MedCard(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      patient.name[0],
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'ID: ${patient.id} · ${patient.assignedDoctor}',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                patient.department,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  const Icon(LucideIcons.clock, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    patient.waitingTime,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: _buildStatusChip(patient.status),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: patient.priorityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: patient.priorityColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          patient.triage,
                          style: TextStyle(
                            color: patient.priorityColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.moreHorizontal, size: 20),
                    onPressed: () => context.go('/patient'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms, delay: (index * 20).ms).slideX(begin: 0.02, end: 0);
  }

  Widget _buildStatusChip(String status) {
    var color = AppColors.primary;
    if (status == 'Waiting') {
      color = AppColors.moderate;
    } else if (status == 'Completed') {
      color = AppColors.routine;
    } else if (status == 'Critical') {
      color = AppColors.critical;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
