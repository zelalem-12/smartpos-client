import 'package:flutter/material.dart';

/// Breakpoint-based responsive layout helper.
///
/// Sunmi V2/P2 handheld: ~5.5" (420px logical width)
/// Tablet / Desktop: ~10" (768px+)
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;

  /// Returns true if the current screen width is mobile-sized.
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  /// Returns true if the current screen width is tablet-sized.
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Returns true if the current screen width is desktop-sized.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= tabletBreakpoint && desktop != null) {
      return desktop!;
    }
    if (width >= mobileBreakpoint && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}
