import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_list_app/constants/constants.dart';

class BackendClient {
  // JACKSON: The type is Client from the http/http package (https://pub.dev/packages/http). Examples can be found here: https://github.com/dart-lang/http/blob/master/pkgs/http/test/mock_client_test.dart. That was linked from the Pub Dev page (the first URL)
  final http.Client httpClient;

  // JACKSON: Same idea as the service. We want to have a way to pass in a mock, but the default use of the constructor will be a real http.Client()
  BackendClient({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<dynamic> getData({required String uri}) async {
    var url = Uri.http(localhost, uri);
    try {
      // JACKSON: Search for this bit in the pub.dev page: "If you're making multiple requests to the same server, you can keep open a persistent connection"
      var response = await httpClient.get(url);
      dynamic data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        return 'HTTP Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      print('Error during HTTPrequest $e');
      return 'Error during HTTP request: $e';
    } finally {
      // JACKSON: The finally block was added due to adding the httpClient rather than the one-off requests
      httpClient.close();
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
        print(
            'Failed to execute Post Request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      rethrow;
    } finally {
      httpClient.close();
    }
  }

  void putData(String data) {
    //remove from current tasks, add to completed tasks list @PutRequest, refactor cubit later
  }

  //void deleteData(String data) - remove completely from API and view
}
