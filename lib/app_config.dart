import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    required this.appName,
    required this.flavorName,
    required this.defaultImageLink,
    required this.cloudFunctionUrl,
    required this.rzpUserName,
    required this.rzpSecret,
    required Widget child,
  }) : super(child: child);

  final String appName;
  final String flavorName;
  final String defaultImageLink;
  final String cloudFunctionUrl;
  final String rzpUserName;
  final String rzpSecret;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
