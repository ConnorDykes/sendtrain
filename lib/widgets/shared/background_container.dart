import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A092D), Color(0xFF1F1E3D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -150,
            left: -150,
            child: buildBlurryCircle(
              context,
              theme.colorScheme.primary.withOpacity(0.35),
              450,
            ),
          ),
          Positioned(
            bottom: -150,
            right: -150,
            child: buildBlurryCircle(
              context,
              theme.colorScheme.secondary.withOpacity(0.15),
              450,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

Widget buildBlurryCircle(BuildContext context, Color color, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
      ),
    ),
  );
}

Widget buildGlassmorphicCard({required Widget child}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: child,
      ),
    ),
  );
}
