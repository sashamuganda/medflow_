# MedFlow — Hospital & Staff App (Flutter Edition)

This plan outlines the creation of a high-fidelity, professional-grade healthcare management platform built with **Flutter and Dart**. The app will feature a premium, medical-grade UI with a focus on performance and cross-platform usability.

## User Review Required

> [!IMPORTANT]
> This is a massive application suite. I will implement the **Core Architecture**, **Design System**, and **Primary Dashboard flows** first. Full implementation of all 70+ screens will be handled in logical phases.

> [!TIP]
> I will use **Riverpod** for robust state management and **GoRouter** for handling the complex navigation hierarchy.

## Proposed Changes

### Core Infrastructure
- Initialize Flutter project in the current directory.
- Add dependencies: `flutter_riverpod`, `go_router`, `lucide_icons`, `google_fonts`, `flutter_animate`.
- Setup a scalable directory structure (feature-first).

### Design System (The "MedFlow" Theme) [NEW]
- `lib/core/theme/app_colors.dart`: Professional medical palette (Deep Teals, Crisp Whites, Soft Slates).
- `lib/core/theme/app_theme.dart`: Implementation of `ThemeData` with custom `ColorScheme` and `TextTheme` (using Inter or Outfit).
- `lib/core/widgets/`: Reusable premium components (MedCard, MedButton, MedTextField, GlassOverlay).

### Navigation & Layout [NEW]
- `lib/core/navigation/app_router.dart`: Definition of all 12 modules' routes.
- `lib/features/shell/view/main_shell.dart`: Responsive shell with a Sidebar (Desktop/Tablet) or BottomNav (Mobile) based on screen size.

### Primary Modules [NEW]
1.  **Auth & Onboarding**: Splash, Role-based Login, Facility Registration flow.
2.  **Dashboards**: Modular dashboard system that adapts to Doctor, Admin, Nurse, or Front Desk roles.
3.  **Queue Management**: Real-time patient flow visualization with color-coded triage indicators.
4.  **EMR**: Comprehensive patient record views and clinical note editors.

## Open Questions

1. **State Management**: Is **Riverpod** acceptable to you, or would you prefer **Bloc** or **Provider**?
2. **Platform Focus**: Should I prioritize **Web/Desktop** (standard for hospitals) or **Mobile** responsiveness first?
3. **Data Mocking**: I will use local repositories with mock data objects for now. Is that okay?

## Verification Plan

### Automated Tests
- `flutter build web` or `flutter build windows` to ensure no compile-time errors.
- Unit tests for the Triage and Queue logic.

### Manual Verification
- Visual inspection of the "premium" UI elements.
- Testing navigation across the major modules.

## Verification Plan

### Automated Tests
- `npm run build` to ensure no compile errors.
- Manual navigation through all primary routes.

### Manual Verification
- Visual check for responsiveness and "premium" aesthetics.
- Testing the role-switching mechanism to ensure the UI adapts correctly.
