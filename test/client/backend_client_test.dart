import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_list_app/client/backend_client.dart';

void main() {
  group('BackendClient', () {
    const Map<String, String> defaultCannedHeaders = {
      'content-type': 'application/json',
    };

    // JACKSON: The way MockClient works is - no matter what request it gets - it responds with the response you give it (line 22). Since that is the way it works, I created this function so we can mock the HTTP request with a different response for each test
    BackendClient createBackendClientWithMockedResponse({
      required Map<String, dynamic> responseBody,
      required int statusCode,
      Map<String, String>? headers,
    }) {
      MockClient mockHttpClient = MockClient(
        (http.Request request) async => http.Response(
          json.encode(responseBody),
          statusCode,
          request: request,
          headers: headers ?? defaultCannedHeaders,
        ),
      );
      return BackendClient(httpClient: mockHttpClient);
    }

    // JACKSON: We define our responseBody in a separate variable because we use it in the expect()
    // JACKSON: We use our createBackendClientWithMockedResponse() function to mock out the Spring backend
    test('getData returns data on success', () async {
      const Map<String, String> responseBody = {'key': 'value'};
      BackendClient backendClient = createBackendClientWithMockedResponse(
          responseBody: responseBody, statusCode: 200);
      final dynamic result = await backendClient.getData(uri: '/example');
      expect(result, equals(responseBody));
    });

    // JACKSON: We define our statusCode in a separate variable because we use it in the expect()
    test('getData returns an error message on failure', () async {
      const int statusCode = 404;
      BackendClient backendClient = createBackendClientWithMockedResponse(
          responseBody: {'key': 'value'}, statusCode: statusCode);
      final dynamic result = await backendClient.getData(uri: '/example');
      expect(result, equals('HTTP Request failed with status: $statusCode'));
    });

    test('postData returns data on success', () async {
      const Map<String, String> responseBody = {'key': 'value'};
      BackendClient backendClient = createBackendClientWithMockedResponse(
          responseBody: responseBody, statusCode: 200);
      final dynamic result =
          await backendClient.postData(uri: '/example', body: responseBody);
      expect(result, equals(responseBody));
    });

    test('postData returns an error message on failure', () async {
      const int statusCode = 400;
      const Map<String, String> responseBody = {'key': 'value'};
      BackendClient backendClient = createBackendClientWithMockedResponse(
          responseBody: responseBody, statusCode: statusCode);
      final dynamic result = await backendClient
          .postData(uri: '/example', body: responseBody);
      print('Actual Result: $result');
      expect(result,
          equals('Failed to execute Post Request. Status code: $statusCode'));
    });
  });
}
