import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:medflow_/core/widgets/med_button.dart';
import 'package:medflow_/core/widgets/med_card.dart';

import '../../../core/theme/app_colors.dart';

class PatientOverview extends StatefulWidget {
  const PatientOverview({super.key});

  @override
  State<PatientOverview> createState() => _PatientOverviewState();
}

class _PatientOverviewState extends State<PatientOverview> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MedCard(
            padding: const EdgeInsets.all(32),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 900;

                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColors.slate100,
                          child: Icon(LucideIcons.user, size: 36, color: AppColors.primary),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 16,
                                runSpacing: 8,
                                children: [
                                  const Text(
                                    'Sarah Williams',
                                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -1),
                                  ),
                                  _buildIdBadge('PF-2024-0042'),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildPatientMeta(isCompact),
                              const SizedBox(height: 24),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: const [
                                  _Tag(label: 'Diabetes Type II', color: AppColors.moderate),
                                  _Tag(label: 'Hypertension', color: AppColors.moderate),
                                  _Tag(label: 'Penicillin Allergy', color: AppColors.critical),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (!isCompact) _buildActionButtons(context, isVertical: true),
                      ],
                    ),
                    if (isCompact) ...[
                      const SizedBox(height: 24),
                      _buildActionButtons(context, isVertical: false),
                    ],
                  ],
                );
              },
            ),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: AppColors.primary,
                indicatorWeight: 3,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                onTap: (index) => setState(() {}),
                tabs: const [
                  Tab(text: 'Visit History'),
                  Tab(text: 'Medications'),
                  Tab(text: 'Lab Results'),
                  Tab(text: 'Imaging'),
                  Tab(text: 'Vitals'),
                  Tab(text: 'Discharge Summaries'),
                ],
              ),
              const SizedBox(height: 32),
              // Using a switch or IndexedStack here allows content to grow and avoids nested scrolling issues
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 400),
                child: _buildTabContent(_tabController.index),
              ),
            ],
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return _VisitHistoryTab();
      case 1:
        return _MedicationsTab();
      case 2:
        return _LabResultsTab();
      case 3:
        return const Center(child: Text('Imaging Reports Tab'));
      case 4:
        return _VitalsTab();
      case 5:
        return const Center(child: Text('Discharge Summaries Tab'));
      default:
        return const SizedBox();
    }
  }

  Widget _buildIdBadge(String id) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        id,
        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildPatientMeta(bool isCompact) {
    if (isCompact) {
      return Wrap(
        spacing: 24,
        runSpacing: 12,
        children: [
          _metaItem('Age', '34 years'),
          _metaItem('Sex', 'Female'),
          _metaItem('Blood', 'O+'),
          _metaItem('Weight', '68 kg'),
          _metaItem('Last Visit', '12 Mar 2026', color: AppColors.textSecondary),
        ],
      );
    }
    return Row(
      children: [
        _metaItem('Age', '34 years'),
        _divider(),
        _metaItem('Sex', 'Female'),
        _divider(),
        _metaItem('Blood', 'O+'),
        _divider(),
        _metaItem('Weight', '68 kg'),
        _divider(),
        _metaItem('Last Visit', '12 Mar 2026', color: AppColors.textSecondary),
      ],
    );
  }

  Widget _metaItem(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.slate200,
    );
  }

  Widget _buildActionButtons(BuildContext context, {required bool isVertical}) {
    final buttons = [
      MedButton(
        label: 'New Encounter',
        icon: LucideIcons.plus,
        onPressed: () {},
        width: isVertical ? 200 : 180,
      ),
      if (!isVertical) const SizedBox(width: 12),
      if (isVertical) const SizedBox(height: 12),
      MedButton(
        label: 'Export Record',
        icon: LucideIcons.download,
        type: MedButtonType.secondary,
        onPressed: () {},
        width: isVertical ? 200 : 180,
      ),
    ];

    if (isVertical) {
      return Column(children: buttons);
    }
    return Wrap(spacing: 12, runSpacing: 12, children: buttons.whereType<Widget>().toList());
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}

class _VisitHistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _VisitCard(
          date: '12 Mar 2026',
          doctor: 'Dr. Jane Doe',
          dept: 'General Medicine',
          reason: 'Routine Diabetes Follow-up',
          diagnosis: 'Diabetes Type II, controlled',
        ),
        SizedBox(height: 16),
        _VisitCard(
          date: '05 Jan 2026',
          doctor: 'Dr. Alan Smith',
          dept: 'Emergency',
          reason: 'Acute Chest Pain',
          diagnosis: 'Severe Heartburn / Gastritis',
        ),
      ],
    );
  }
}

class _VisitCard extends StatelessWidget {
  const _VisitCard({
    required this.date,
    required this.doctor,
    required this.dept,
    required this.reason,
    required this.diagnosis,
  });

  final String date;
  final String doctor;
  final String dept;
  final String reason;
  final String diagnosis;

  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppColors.slate50, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(LucideIcons.calendar, color: AppColors.textSecondary, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(dept, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildInfoRow('Physician', doctor),
                _buildInfoRow('Reason', reason),
                _buildInfoRow('Diagnosis', diagnosis, color: AppColors.primary),
                const SizedBox(height: 16),
              MedButton(label: 'View Notes', type: MedButtonType.text, onPressed: () {}, width: 160),
              ],
            );
          }
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.slate50, borderRadius: BorderRadius.circular(12)),
                child: const Icon(LucideIcons.calendar, color: AppColors.textSecondary, size: 24),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(dept, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Physician', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                    Text(doctor, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Reason', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                    Text(reason, style: const TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Diagnosis', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                    Text(diagnosis, style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary)),
                  ],
                ),
              ),
              MedButton(label: 'View Notes', type: MedButtonType.text, onPressed: () {}, width: 120),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(value, style: TextStyle(fontWeight: FontWeight.w500, color: color)),
          ),
        ],
      ),
    );
  }
}

class _MedicationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Active Medications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _medItem('Metformin', '500mg', 'Twice daily, with meals', 'Prescribed by Dr. Jane Doe on 12 Mar 2026'),
          const Divider(height: 32),
          _medItem('Lisinopril', '10mg', 'Once daily, morning', 'Prescribed by Dr. Jane Doe on 12 Mar 2026'),
          const Divider(height: 32),
          _medItem('Atorvastatin', '20mg', 'Once daily, evening', 'Prescribed by Dr. Alan Smith on 05 Jan 2026'),
        ],
      ),
    );
  }

  Widget _medItem(String name, String dosage, String instruction, String meta) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: AppColors.routine.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(LucideIcons.pill, color: AppColors.routine, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Text('$name $dosage', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 12),
              Text(instruction, style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.slate900)),
              Text(meta, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 16),
              MedButton(label: 'Renew', type: MedButtonType.secondary, height: 36, onPressed: () {}, width: 140),
            ],
          );
        }
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.routine.withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(LucideIcons.pill, color: AppColors.routine, size: 20),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$name $dosage', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(instruction, style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.slate900)),
                  Text(meta, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            MedButton(label: 'Renew', type: MedButtonType.secondary, height: 36, onPressed: () {}, width: 120),
          ],
        );
      },
    );
  }
}

class _LabResultsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _labCard('Full Blood Count', '14 Mar 2026', 'Normal'),
        const SizedBox(height: 16),
        _labCard('HbA1c', '12 Mar 2026', 'High (7.2%)', isCritical: true),
        const SizedBox(height: 16),
        _labCard('Lipid Profile', '05 Jan 2026', 'Normal'),
      ],
    );
  }

  Widget _labCard(String test, String date, String result, {bool isCritical = false}) {
    return MedCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(LucideIcons.flaskConical, color: AppColors.textSecondary),
                    const SizedBox(width: 16),
                    Expanded(child: Text(test, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ordered on $date', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: (isCritical ? AppColors.critical : AppColors.routine).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        result,
                        style: TextStyle(
                          color: isCritical ? AppColors.critical : AppColors.routine,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                MedButton(label: 'View Full Report', type: MedButtonType.secondary, height: 40, onPressed: () {}, width: 180),
              ],
            );
          }
          return Row(
            children: [
              const Icon(LucideIcons.flaskConical, color: AppColors.textSecondary),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(test, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Ordered on $date', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (isCritical ? AppColors.critical : AppColors.routine).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  result,
                  style: TextStyle(
                    color: isCritical ? AppColors.critical : AppColors.routine,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              MedButton(label: 'View Full Report', type: MedButtonType.secondary, height: 40, onPressed: () {}, width: 180),
            ],
          );
        },
      ),
    );
  }
}

class _VitalsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Vital Signs History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              MedButton(label: 'Log Vitals', icon: LucideIcons.plus, type: MedButtonType.secondary, height: 40, onPressed: () {}),
            ],
          ),
          const SizedBox(height: 32),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 600),
              child: Column(
                children: [
                  _vitalsRow('12 Mar 2026, 09:15 AM', '120/80', '72', '36.5 C', '98%'),
                  const Divider(height: 1),
                  _vitalsRow('12 Mar 2026, 11:00 AM', '124/82', '74', '36.6 C', '97%'),
                  const Divider(height: 1),
                  _vitalsRow('13 Mar 2026, 08:50 AM', '118/79', '70', '36.4 C', '99%'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vitalsRow(String date, String bp, String hr, String temp, String spo2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13))),
          _vitalItem('BP', bp),
          _vitalItem('HR', hr),
          _vitalItem('Temp', temp),
          _vitalItem('SpO2', spo2),
        ],
      ),
    );
  }

  Widget _vitalItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}
