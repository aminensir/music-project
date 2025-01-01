import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoader {
  static Future<List<dynamic>> loadJson(String filePath) async {
    final String jsonString = await rootBundle.loadString(filePath);
    return json.decode(jsonString);
  }
}
