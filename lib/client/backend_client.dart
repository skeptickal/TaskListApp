import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_list_app/constants/constants.dart';

class BackendClient {
  const BackendClient();

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

  Future<http.Response> postData({required String uri, dynamic body}) async {
    var url = Uri.http(localhost, uri);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return response;
  }

  void putData(String data) {
    //remove from current tasks, add to completed tasks list @PutRequest, refactor cubit later
  }

  //void deleteData(String data) - remove completely from API and view
}
