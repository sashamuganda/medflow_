import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_models.dart';

class CurrentRoleNotifier extends Notifier<AppRole> {
  @override
  AppRole build() => AppRole.administrator;

  void setRole(AppRole role) {
    state = role;
  }
}

final currentRoleProvider =
    NotifierProvider<CurrentRoleNotifier, AppRole>(CurrentRoleNotifier.new);

final staffProfileProvider = Provider<StaffProfile>((ref) => demoStaffProfile);

final facilitySummaryProvider =
    Provider<FacilitySummary>((ref) => demoFacility);

final queuePatientsProvider =
    Provider<List<QueuePatient>>((ref) => demoQueuePatients);

final notificationsProvider =
    Provider<List<NotificationItem>>((ref) => demoNotifications);
