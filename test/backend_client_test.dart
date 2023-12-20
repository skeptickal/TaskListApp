import 'dart:convert';
import 'dart:io';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:task_list_app/constants/constants.dart';
import 'package:test/test.dart';
import 'package:task_list_app/client/backend_client.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(
        Uri.parse('http://${localhost}/tasks')); 
  });

  group('BackendClient', () {
    late BackendClient backendClient;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      backendClient = BackendClient(); 
      backendClient.client = mockHttpClient; 
    });
    test('getData returns data on success', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('{"key": "value"}', 200),
      );

      // Act
      final result = await backendClient.getData(uri: '/example');

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      verify(() => mockHttpClient.get(Uri.parse('http://localhost/example')))
          .called(1);
    });

    test('getData returns error message on failure', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('Error', 404),
      );

      // Act
      final result = await backendClient.getData(uri: '/example');

      // Assert
      expect(result, 'HTTP Request failed with status: 404');
      verify(() => mockHttpClient.get(Uri.parse('http://localhost/example')))
          .called(1);
    });

    test('postData returns data on success', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response('{"key": "value"}', HttpStatus.created),
      );

      // Act
      final result = await backendClient.postData(uri: '/example', body: {});

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      verify(
        () => mockHttpClient.post(
          Uri.parse('http://localhost/example'),
          headers: any(named: 'headers'),
          body: '{"key":"value"}',
        ),
      ).called(1);
    });

    test('postData throws on failure', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer(
        (_) async => http.Response('Error', 500),
      );

      // Act & Assert
      expect(
        () async => await backendClient.postData(uri: '/example', body: {}),
        throwsA(isA<Exception>()),
      );
      verify(
        () => mockHttpClient.post(
          Uri.parse('http://localhost/example'),
          headers: any(named: 'headers'),
          body: '{"key":"value"}',
        ),
      ).called(1);
    });

    // Add more tests for other methods as needed

    tearDown(() {
      // Verify that all expected interactions occurred
      verifyNoMoreInteractions(mockHttpClient);
    });
  });
}
