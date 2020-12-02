import 'toon.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Helper {
  Future<List<Toon>> fetchStudents() async {
    final response =
        await http.get('https://api4all.azurewebsites.net/api/People');
    if (response.statusCode == 200) {
      return parseStudents(response.body);
    } else {
      throw Exception('Unable to fetch students from the REST API');
    }
  }

  List<Toon> parseStudents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Toon>((json) => Toon.fromJson(json)).toList();
  }
}
