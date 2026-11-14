import 'package:flutter/material.dart';
import '../../app/theme/colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Border? border;
  final Gradient? gradient;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.border,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBg = isDark ? AppColors.darkCard : AppColors.lightCard;
    final defaultBorder = Border.all(
      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
      width: 1,
    );

    return Container(
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? defaultBg) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        border: border ?? defaultBorder,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(18),
            child: child,
          ),
        ),
      ),
    );
  }
}

