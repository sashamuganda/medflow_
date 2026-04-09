import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum AppRole {
  administrator('Administrator'),
  doctor('Attending Physician'),
  nurse('Nurse'),
  frontDesk('Front Desk');

  const AppRole(this.label);

  final String label;
}

class FacilitySummary {
  const FacilitySummary({
    required this.name,
    required this.location,
    required this.totalPatients,
    required this.waitingPatients,
    required this.todayAppointments,
    required this.activeDoctors,
    required this.bedOccupancy,
  });

  final String name;
  final String location;
  final int totalPatients;
  final int waitingPatients;
  final int todayAppointments;
  final int activeDoctors;
  final double bedOccupancy;
}

class StaffProfile {
  const StaffProfile({
    required this.name,
    required this.initials,
    required this.department,
    required this.roles,
  });

  final String name;
  final String initials;
  final String department;
  final List<AppRole> roles;
}

class QueuePatient {
  const QueuePatient({
    required this.name,
    required this.id,
    required this.department,
    required this.waitingTime,
    required this.status,
    required this.triage,
    required this.assignedDoctor,
    required this.priorityColor,
  });

  final String name;
  final String id;
  final String department;
  final String waitingTime;
  final String status;
  final String triage;
  final String assignedDoctor;
  final Color priorityColor;
}

class NotificationItem {
  const NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isCritical,
  });

  final String title;
  final String subtitle;
  final String time;
  final bool isCritical;
}

const demoFacility = FacilitySummary(
  name: 'City General Hospital',
  location: 'Nairobi, Kenya',
  totalPatients: 1248,
  waitingPatients: 42,
  todayAppointments: 186,
  activeDoctors: 18,
  bedOccupancy: 0.84,
);

const demoStaffProfile = StaffProfile(
  name: 'Dr. Jane Doe',
  initials: 'JD',
  department: 'General Medicine',
  roles: [
    AppRole.administrator,
    AppRole.doctor,
    AppRole.nurse,
    AppRole.frontDesk,
  ],
);

const demoQueuePatients = <QueuePatient>[
  QueuePatient(
    name: 'Michael Chen',
    id: 'PF-1024',
    department: 'Emergency',
    waitingTime: '12m',
    status: 'Waiting',
    triage: 'Emergency',
    assignedDoctor: 'Dr. Smith',
    priorityColor: AppColors.critical,
  ),
  QueuePatient(
    name: 'Sarah Williams',
    id: 'PF-1085',
    department: 'General Practice',
    waitingTime: '45m',
    status: 'Waiting',
    triage: 'Routine',
    assignedDoctor: 'Dr. Jane Doe',
    priorityColor: AppColors.routine,
  ),
  QueuePatient(
    name: 'James Roberts',
    id: 'PF-1092',
    department: 'Cardiology',
    waitingTime: '3m',
    status: 'In Consultation',
    triage: 'Urgent',
    assignedDoctor: 'Dr. Patel',
    priorityColor: AppColors.moderate,
  ),
  QueuePatient(
    name: 'Emily Davis',
    id: 'PF-1104',
    department: 'Pediatrics',
    waitingTime: '18m',
    status: 'Awaiting Lab',
    triage: 'Routine',
    assignedDoctor: 'Dr. Kilonzo',
    priorityColor: AppColors.routine,
  ),
  QueuePatient(
    name: 'Robert Wilson',
    id: 'PF-1115',
    department: 'Orthopedics',
    waitingTime: '52m',
    status: 'Waiting',
    triage: 'Standard',
    assignedDoctor: 'Dr. Singh',
    priorityColor: AppColors.primary,
  ),
];

const demoNotifications = <NotificationItem>[
  NotificationItem(
    title: 'Critical triage flag',
    subtitle: 'Michael Chen routed to Emergency for chest pain and low SpO2.',
    time: '2 min ago',
    isCritical: true,
  ),
  NotificationItem(
    title: 'Lab result returned',
    subtitle: 'HbA1c for Sarah Williams is ready for clinician review.',
    time: '9 min ago',
    isCritical: false,
  ),
  NotificationItem(
    title: 'Telemedicine request queued',
    subtitle: 'One on-demand dermatology consult is awaiting assignment.',
    time: '21 min ago',
    isCritical: false,
  ),
  NotificationItem(
    title: 'Staffing gap detected',
    subtitle: 'Maternity ward has no doctor scheduled after 18:00.',
    time: '33 min ago',
    isCritical: true,
  ),
];
