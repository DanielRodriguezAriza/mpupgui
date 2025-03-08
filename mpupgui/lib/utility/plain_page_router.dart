import 'package:flutter/material.dart';

class PlainPageRouter extends PageRouteBuilder {
  final Widget page;
  PlainPageRouter({
    required this.page,
    super.settings
  })
  : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    }
  );
}
