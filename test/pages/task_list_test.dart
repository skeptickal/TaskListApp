import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


import '../materializer.dart';
import '../utils.dart';

void main() {
  setUp(() {});

  testWidgets(
    "title is displayed",
    (tester) async {
      await tester.pumpWidget(const Materializer(
          testRoute:
              '/')); //for testRoute '/' should I test the Http Client to see if getData() and getTasks() is working?
      final titleFinder = find.text('Task List');
      expect(titleFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Add Task Button is Present AND Navigates",
    (tester) async {
      // final client =
      //     MockClient((request) async => http.Response('{"key": "value:}', 200));
      await tester.pumpWidget(const Materializer(testRoute: '/'));
      final titleFinder = find.byKey(const Key('taskAdderFloatingButton'));
      expect(titleFinder, findsOneWidget);
      await tester.tap(titleFinder);
      await Future.delayed(Duration(milliseconds: 500));
      Utils.expectRoute('/addtask', tester);
    },
  );
}

// class taskApiClient {
//   final http.Client client;
//   taskApiClient({required this.client});
//   Future<String> getData() async {
//     final response = await client.get(Uri.parse)
//   }
// }
