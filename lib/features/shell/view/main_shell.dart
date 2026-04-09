import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/models/app_models.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/med_button.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1100;
    final isTablet = size.width > 700 && size.width <= 1100;
    final isMobile = size.width <= 700;
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: (isMobile || isTablet) ? const Drawer(child: Sidebar()) : null,
      body: Row(
        children: [
          if (isDesktop) const Sidebar(),
          Expanded(
            child: Column(
              children: [
                Header(showMenuButton: !isDesktop),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile ? _ShellBottomNav(location: location) : null,
    );
  }
}

class _ShellBottomNav extends ConsumerWidget {
  const _ShellBottomNav({required this.location});

  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(currentRoleProvider);
    return BottomNavigationBar(
      currentIndex: _getSelectedIndex(location),
      onTap: (index) => _onNavTap(context, role, index),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.layoutDashboard),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.users),
          label: 'Queue',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.calendar),
          label: 'Appts',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.fileText),
          label: 'EMR',
        ),
      ],
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/queue')) {
      return 1;
    }
    if (location.startsWith('/appointments')) {
      return 2;
    }
    if (location.startsWith('/patient')) {
      return 3;
    }
    return 0;
  }

  void _onNavTap(BuildContext context, AppRole role, int index) {
    switch (index) {
      case 0:
        context.go(Sidebar._dashboardRoute(role));
        break;
      case 1:
        context.go('/queue');
        break;
      case 2:
        context.go('/appointments');
        break;
      case 3:
        context.go('/patient');
        break;
    }
  }
}

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(currentRoleProvider);
    final location = GoRouterState.of(context).uri.toString();
    final profile = ref.watch(staffProfileProvider);

    return Container(
      width: 280,
      color: AppColors.slate900,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    LucideIcons.activity,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'MedFlow',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _SidebarItem(
                  icon: LucideIcons.layoutDashboard,
                  label: '${role.label} Dashboard',
                  isSelected: _isDashboardRoute(location),
                  onTap: () => context.go(_dashboardRoute(role)),
                ),
                _SidebarItem(
                  icon: LucideIcons.users,
                  label: 'Patient Queue',
                  isSelected: location.startsWith('/queue'),
                  onTap: () => context.go('/queue'),
                ),
                _SidebarItem(
                  icon: LucideIcons.calendar,
                  label: 'Appointments',
                  isSelected: location.startsWith('/appointments'),
                  onTap: () => context.go('/appointments'),
                ),
                _SidebarItem(
                  icon: LucideIcons.fileText,
                  label: 'EMR / Records',
                  isSelected: location.startsWith('/patient'),
                  onTap: () => context.go('/patient'),
                ),
                _SidebarItem(
                  icon: LucideIcons.bell,
                  label: 'Notifications',
                  isSelected: location.startsWith('/notifications'),
                  onTap: () => context.go('/notifications'),
                ),
                const _SidebarItem(
                  icon: LucideIcons.video,
                  label: 'Telemedicine',
                ),
                const _SidebarItem(
                  icon: LucideIcons.stethoscope,
                  label: 'Staff Management',
                ),
                const Divider(color: Colors.white12, height: 40),
                const _SidebarItem(
                  icon: LucideIcons.barChart3,
                  label: 'Analytics',
                ),
                const _SidebarItem(
                  icon: LucideIcons.settings,
                  label: 'Settings',
                ),
              ],
            ),
          ),
          _ProfileSection(profile: profile),
        ],
      ),
    );
  }

  static bool _isDashboardRoute(String location) {
    return location == '/' ||
        location == '/doctor' ||
        location == '/nurse' ||
        location == '/front-desk';
  }

  static String _dashboardRoute(AppRole role) {
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

class _ProfileSection extends ConsumerWidget {
  const _ProfileSection({required this.profile});

  final StaffProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRole = ref.watch(currentRoleProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(
                    profile.initials,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        currentRole.label,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    LucideIcons.logOut,
                    color: Colors.white54,
                    size: 18,
                  ),
                  onPressed: () => context.go('/welcome'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            MedButton(
              label: 'Switch Role',
              type: MedButtonType.secondary,
              height: 32,
              onPressed: () => context.go('/role-select'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        onTap: onTap,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white54,
          size: 20,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        tileColor: isSelected ? AppColors.primary.withOpacity(0.1) : null,
      ),
    );
  }
}

class Header extends ConsumerWidget {
  const Header({super.key, this.showMenuButton = false});

  final bool showMenuButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final title = _titleForRoute(location);

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: [
          if (showMenuButton)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(LucideIcons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.slate900,
            ),
          ),
          const Spacer(),
          if (MediaQuery.of(context).size.width > 800)
            Container(
              width: 320,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search patients, staff, records...',
                  border: InputBorder.none,
                  icon: Icon(LucideIcons.search, size: 18),
                  hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
          const SizedBox(width: 24),
          Stack(
            children: [
              IconButton(
                icon: const Icon(LucideIcons.bell, size: 22),
                onPressed: () => context.go('/notifications'),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.critical,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _titleForRoute(String location) {
    switch (location) {
      case '/':
        return 'Administrator Dashboard';
      case '/doctor':
        return 'Doctor Dashboard';
      case '/nurse':
        return 'Nurse Dashboard';
      case '/front-desk':
        return 'Front Desk Dashboard';
      case '/queue':
        return 'Patient Queue';
      case '/appointments':
        return 'Appointments';
      case '/appointments/detail':
        return 'Appointment Detail';
      case '/patient':
        return 'EMR / Patient Records';
      case '/notifications':
        return 'Notifications';
      default:
        return 'MedFlow';
    }
  }
}
