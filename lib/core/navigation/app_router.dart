import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/appointments/view/appointment_detail_screen.dart';
import '../../features/appointments/view/appointments_home_screen.dart';
import '../../features/auth/view/facility_registration_screen.dart';
import '../../features/auth/view/login_screen.dart';
import '../../features/auth/view/role_selection_screen.dart';
import '../../features/auth/view/splash_screen.dart';
import '../../features/auth/view/welcome_screen.dart';
import '../../features/dashboard/view/admin_dashboard.dart';
import '../../features/dashboard/view/doctor_dashboard.dart';
import '../../features/dashboard/view/front_desk_dashboard.dart';
import '../../features/dashboard/view/nurse_dashboard.dart';
import '../../features/emr/view/consultation_notes_screen.dart';
import '../../features/emr/view/patient_overview.dart';
import '../../features/notifications/view/notifications_center_screen.dart';
import '../../features/queue/view/queue_overview.dart';
import '../../features/queue/view/triage_input_screen.dart';
import '../../features/queue/view/triage_result_screen.dart';
import '../../features/shell/view/main_shell.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/splash',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const FacilityRegistrationScreen(),
    ),
    GoRoute(
      path: '/role-select',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/triage',
      builder: (context, state) => const TriageInputScreen(),
    ),
    GoRoute(
      path: '/triage/result',
      builder: (context, state) => const TriageResultScreen(),
    ),
    GoRoute(
      path: '/consultation',
      builder: (context, state) => const ConsultationNotesScreen(),
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AdminDashboard(),
        ),
        GoRoute(
          path: '/doctor',
          builder: (context, state) => const DoctorDashboard(),
        ),
        GoRoute(
          path: '/nurse',
          builder: (context, state) => const NurseDashboard(),
        ),
        GoRoute(
          path: '/front-desk',
          builder: (context, state) => const FrontDeskDashboard(),
        ),
        GoRoute(
          path: '/queue',
          builder: (context, state) => const QueueOverview(),
        ),
        GoRoute(
          path: '/appointments',
          builder: (context, state) => const AppointmentsHomeScreen(),
        ),
        GoRoute(
          path: '/appointments/detail',
          builder: (context, state) => const AppointmentDetailScreen(),
        ),
        GoRoute(
          path: '/patient',
          builder: (context, state) => const PatientOverview(),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationsCenterScreen(),
        ),
      ],
    ),
  ],
);
