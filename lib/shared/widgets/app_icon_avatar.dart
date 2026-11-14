import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../app/theme/colors.dart';

class AppIconAvatar extends StatelessWidget {
  final Uint8List? iconBytes;
  final String appName;
  final double size;

  const AppIconAvatar({
    super.key,
    required this.iconBytes,
    required this.appName,
    this.size = 42,
  });

  @override
  Widget build(BuildContext context) {
    if (iconBytes != null && iconBytes!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.26),
        child: Image.memory(
          iconBytes!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _fallbackAvatar(),
        ),
      );
    }
    return _fallbackAvatar();
  }

  Widget _fallbackAvatar() {
    final initial = appName.isNotEmpty ? appName[0].toUpperCase() : 'A';
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(size * 0.26),
        border: Border.all(color: AppColors.primaryCyan.withOpacity(0.3)),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: AppColors.primaryCyan,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.44,
        ),
      ),
    );
  }
}

