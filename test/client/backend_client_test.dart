import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart'; // Import test from the 'test' package
import 'package:task_list_app/client/backend_client.dart'; // Adjust the path

// Create a mock for http.Client
class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('BackendClient', () {
    late http.Client mockClient;
    late BackendClient backendClient;

    setUp(() {
      mockClient = MockHttpClient();
      backendClient = BackendClient();
      registerFallbackValue(Uri.parse('http://10.0.2.2:8080/example'));
    });

    test('getData returns data on success', () async {
      final responseData = {'key': 'value'};

      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode(responseData), 200),
      );

      final result = await backendClient.getData(uri: '/example');

      expect(result, equals(responseData));
    });

    test('getData returns an error message on failure', () async {
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      final result = await backendClient.getData(uri: '/example');

      expect(result, equals('HTTP Request failed with status: 404'));
    });

    test('postData returns data on success', () async {
      final requestData = {'key': 'value'};
      final responseData = {'responseKey': 'responseValue'};

      when(() => mockClient.get(Uri.parse('http://10.0.2.2:8080/tasks')))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(responseData), 200));

      final result =
          await backendClient.postData(uri: '/example', body: requestData);

      expect(result, equals(responseData));
    });

    test('postData returns an error message on failure', () async {
      final requestData = {'key': 'value'};

      when(() => mockClient.post(any(),
          headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response(
            'Internal Server Error', HttpStatus.internalServerError),
      );

      final result =
          await backendClient.postData(uri: '/example', body: requestData);

      expect(
          result, equals('Failed to execute Post Request. Status code: 500'));
    });
  });
}
