import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task_list_app/constants/constants.dart';

class BackendClient {
  BackendClient();
  http.Client? _client; // Define the client property

  set client(http.Client client) {
    _client = client;
  }

  Future<dynamic> getData({required String uri}) async {
    var url = Uri.http(localhost, uri);
    try {
      var response = await http.get(url);
      dynamic data = jsonDecode(response.body);

      if (response.statusCode == 200) {
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
      final response = await http.post(
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
    }
  }

  void putData(String data) {
    //remove from current tasks, add to completed tasks list @PutRequest, refactor cubit later
  }

  //void deleteData(String data) - remove completely from API and view
}
