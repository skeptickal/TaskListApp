//import 'dart:convert';

import 'dart:convert';

import 'package:http/http.dart' as http;

class BackendClient {
  const BackendClient();

//functions to connect with API
  Future<List<Map<String, String>>> getData({required String uri}) async {
    var url = Uri.http('10.0.2.2:8080', uri);
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic decodedData = jsonDecode(response.body);

        // Print the decoded data for inspection
        print('Decoded data: $decodedData');

        // Check if the decoded data is a List<Map<String, dynamic>>
        if (decodedData is List &&
            decodedData.isNotEmpty &&
            decodedData[0] is Map) {
          List<Map<String, String>> formattedData = decodedData
              .cast<Map<String, dynamic>>() // Cast to Map<String, dynamic>
              .map((item) {
            return Map<String, String>.fromEntries(item.entries.map(
              (entry) => MapEntry(entry.key.toString(), entry.value.toString()),
            ));
          }).toList();

          return formattedData;
        } else {
          // Handle unexpected response type
          print('Unexpected response format');
          throw 'Unexpected response format';
        }
      } else {
        // Handle non-200 status code
        print('HTTP Request failed with status: ${response.statusCode}');
        throw 'HTTP Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      // Handle other errors
      print('Error during HTTP request $e');
      throw 'Error during HTTP request: $e';
    }
  }

  void postData(String data) {
    //add task to API @PostRequest
  }

  void putData(String data) {
    //remove from current tasks, add to completed tasks list @PutRequest, refactor cubit later
  }

  //TODO: void deleteData(String data) - remove completely from API and view
}
