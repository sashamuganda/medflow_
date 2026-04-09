import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum MedButtonType { primary, secondary, outline, text, critical }

class MedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final MedButtonType type;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double height;

  const MedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = MedButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (type) {
      case MedButtonType.primary:
        backgroundColor = AppColors.primary;
        foregroundColor = Colors.white;
        break;
      case MedButtonType.secondary:
        backgroundColor = AppColors.slate100;
        foregroundColor = AppColors.slate800;
        break;
      case MedButtonType.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = AppColors.primary;
        borderSide = const BorderSide(color: AppColors.primary, width: 1.5);
        break;
      case MedButtonType.text:
        backgroundColor = Colors.transparent;
        foregroundColor = AppColors.primary;
        break;
      case MedButtonType.critical:
        backgroundColor = AppColors.critical.withOpacity(0.1);
        foregroundColor = AppColors.critical;
        break;
    }

    if (onPressed == null) {
      backgroundColor = backgroundColor.withOpacity(0.5);
      foregroundColor = foregroundColor.withOpacity(0.5);
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderSide,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
