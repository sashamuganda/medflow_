import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/models/app_models.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_button.dart';
import '../../../core/widgets/med_card.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(staffProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Select Active Role')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 840),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose the workspace you want to use for this session. Each role surfaces a different dashboard and permission set.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 900 ? 2 : 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.8,
                    children: profile.roles
                        .map(
                          (role) => _RoleCard(
                            role: role,
                            onSelect: () {
                              ref.read(currentRoleProvider.notifier).setRole(role);
                              context.go(_routeForRole(role));
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _routeForRole(AppRole role) {
    switch (role) {
      case AppRole.administrator:
        return '/';
      case AppRole.doctor:
        return '/doctor';
      case AppRole.nurse:
        return '/nurse';
      case AppRole.frontDesk:
        return '/front-desk';
    }
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({required this.role, required this.onSelect});

  final AppRole role;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return MedCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(_iconForRole(role), color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          Text(
            role.label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _descriptionForRole(role),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          MedButton(
            label: 'Open Workspace',
            icon: LucideIcons.arrowRight,
            onPressed: onSelect,
          ),
        ],
      ),
    );
  }

  static IconData _iconForRole(AppRole role) {
    switch (role) {
      case AppRole.administrator:
        return LucideIcons.layoutDashboard;
      case AppRole.doctor:
        return LucideIcons.stethoscope;
      case AppRole.nurse:
        return LucideIcons.heart;
      case AppRole.frontDesk:
        return LucideIcons.monitor;
    }
  }

  static String _descriptionForRole(AppRole role) {
    switch (role) {
      case AppRole.administrator:
        return 'Facility-wide metrics, staffing oversight, reports, and department controls.';
      case AppRole.doctor:
        return 'Appointments, patient queue, pending tasks, clinical documentation, and telemedicine.';
      case AppRole.nurse:
        return 'Ward activity, bedside logging, medication tasks, and urgent patient monitoring.';
      case AppRole.frontDesk:
        return 'Check-ins, arrivals, appointment coordination, and waiting-room operations.';
    }
  }
}
