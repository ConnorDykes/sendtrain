import 'package:flutter/material.dart';

class SendTrainLogo extends StatelessWidget {
  final double? fontSize;
  const SendTrainLogo({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayStyle = theme.textTheme.displayLarge?.copyWith(
      color: Colors.white,
      fontSize: fontSize,
    );
    final secondaryStyle = theme.textTheme.displayLarge?.copyWith(
      color: theme.colorScheme.secondary,
      fontSize: fontSize,
    );

    return RichText(
      text: TextSpan(
        style: displayStyle,
        children: [
          const TextSpan(text: 'Sendtr'),
          TextSpan(text: 'A', style: secondaryStyle),
          TextSpan(text: 'I', style: secondaryStyle),
          const TextSpan(text: 'n'),
        ],
      ),
    );
  }
}
