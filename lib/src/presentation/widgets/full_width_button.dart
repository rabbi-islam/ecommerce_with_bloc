import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../routes/route_pages.dart';

class FullWidthButton extends StatelessWidget {
  const FullWidthButton({super.key, this.onTap, this.backgroundColor, this.textColor, required this.buttonText});

  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: backgroundColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
        height: 80.h,
        child: Center(child: Text(buttonText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: textColor ?? Theme.of(context).colorScheme.onSecondary))),
      ),
    );
  }
}
