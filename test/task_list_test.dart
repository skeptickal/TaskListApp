import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'materializer.dart';
import 'utils.dart';

void main() {
  setUp(() {});

  testWidgets(
    "title is displayed",
    (tester) async {
      await tester.pumpWidget(const Materializer(testRoute: '/'));
      final titleFinder = find.text('Task List');
      expect(titleFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Add Task Button is Present AND Navigates",
    (tester) async {
      await tester.pumpWidget(const Materializer(testRoute: '/'));
      final titleFinder = find.byKey(const Key('taskAdderFloatingButton'));
      expect(titleFinder, findsOneWidget);
      await tester.tap(titleFinder);
      Utils.expectRoute('/addtask', tester);
    },
  );
}
