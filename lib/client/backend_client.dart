import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_list_app/constants/constants.dart';

class BackendClient {
  // JACKSON: The type is Client from the http/http package (https://pub.dev/packages/http). Examples can be found here: https://github.com/dart-lang/http/blob/master/pkgs/http/test/mock_client_test.dart. That was linked from the Pub Dev page (the first URL)
  final http.Client httpClient;

  // JACKSON: Same idea as the service. We want to have a way to pass in a mock, but the default use of the constructor will be a real http.Client()
  BackendClient({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<dynamic> getData({required String uri, Map<String, dynamic>? queryParams}) async {
    final Uri url = Uri.http(localhost, uri, queryParams);
    try {
      // JACKSON: Search for this bit in the pub.dev page: "If you're making multiple requests to the same server, you can keep open a persistent connection"
      var response = await httpClient.get(url);
      dynamic data = jsonDecode(response.body);

      if (response.statusCode == HttpStatus.ok) {
        return data;
      } else {
        return 'HTTP Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      print('Error during HTTPrequest $e');
      return 'Error during HTTP request: $e';
    }
  }

  Future<dynamic> postData({required String uri, dynamic body}) async {
    try {
      final Uri url = Uri.http(localhost, uri);
      final response = await httpClient.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == HttpStatus.created) {
        print('Post executed successfully');
        return jsonDecode(response.body);
      } else {
        String errorMessage = 'Failed to execute Post Request. Status code: ${response.statusCode}';
        print(errorMessage);
        return errorMessage;
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      rethrow;
    }
  }

  Future<dynamic> putData({
    required String uri,
    dynamic body,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final Uri url = Uri.http(localhost, uri, queryParams);
      final response = await httpClient.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == HttpStatus.created) {
        print('Put executed successfully');
        return jsonDecode(response.body);
      } else {
        String errorMessage = 'Failed to execute Put Request. Status code: ${response.statusCode}';
        print(errorMessage);
        return errorMessage;
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      rethrow;
    }
  }

  Future<dynamic> deleteData({required String uri}) async {
    try {
      final Uri url = Uri.http(localhost, uri);
      final response = await httpClient.delete(
        url,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.noContent) {
        print('Delete executed successfully');
        return null;
      } else {
        final String errorMessage = 'Failed to execute Delete Request. Status code: ${response.statusCode}';
        print(errorMessage);
        return errorMessage;
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      rethrow;
    }
  }
}
