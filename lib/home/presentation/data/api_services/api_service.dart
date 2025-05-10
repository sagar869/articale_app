import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/data_list.dart';

class ApiService {
  Future<List<DataList>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => DataList.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch posts: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch posts: $e");
    }
  }
}
