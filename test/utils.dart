import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class Utils {
  static void expectRoute(String expectedRoute, WidgetTester tester) async {
    await tester.pumpAndSettle();
    final navigatorFinder = find.byType(Navigator);
    expect(navigatorFinder, findsOneWidget);

    // Get the NavigatorState from the Navigator widget
    final NavigatorState navigator = tester.state(navigatorFinder);
    expect(
        GoRouter.of(navigator.context)
            .routeInformationProvider
            .value
            .uri
            .toString(),
        expectedRoute);
    await tester.pumpAndSettle();
  }
}
