import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.mobileWidget,
    required this.desktopWidget,
    super.key,
  });

  final Widget mobileWidget;

  final Widget desktopWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 850) {
          return mobileWidget;
        } else {
          return desktopWidget;
        }
      },
    );
  }
}
