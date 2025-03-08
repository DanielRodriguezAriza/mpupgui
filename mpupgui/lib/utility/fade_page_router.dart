import 'package:flutter/material.dart';

class FadePageRouter extends PageRouteBuilder {
  final Widget page;
  FadePageRouter({
    required this.page,
    super.settings
  })
      : super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      }
  );
}
