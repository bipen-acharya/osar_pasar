import 'dart:convert';
import 'dart:developer';

import '../models/category.dart';

import 'package:http/http.dart' as http;

class CategoryRepo {
  static Future<void> getCategory(
      {required Function(List<CategoryItem>) onSuccess,
      required Function(String message) onError}) async {
    try {
      var url = Uri.parse("http://192.168.93.82:8000/api/categories");
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
     
      http.Response response = await http.get(
        url,
        headers: headers,
      );
      var data = json.decode(response.body);
      if (data['status']) {
        onSuccess(categoryListFromJson(data['data']));
      }
    } catch (e) {
      log("-->>>>$e");
      onError("Sorry something went wrong. Please try again");
    }
  }
}
