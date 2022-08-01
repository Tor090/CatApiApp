import 'dart:convert';

import 'package:cat_api_test_app/model/cat_image.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> _getResponce(
      String uri, Map<String, String>? headers) async {
    return headers != null
        ? await http.get(Uri.parse(uri), headers: headers)
        : await http.get(Uri.parse(uri));
  }

  Future<List<CatImage>> getImage() async {
    const url = 'https://api.thecatapi.com/v1/images/search?limit=20';
    const apiKeyHeader = {'x-api-key': '5ead0e7a-5c06-4208-84db-bb9e4a8968c9'};
    try {
      final response = await _getResponce(url, apiKeyHeader);
      List<dynamic> images = jsonDecode(response.body);
      List<CatImage> catImageList =
          images.map((i) => CatImage.fromJson(i)).toList();
      return catImageList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<String>> getFacts() async {
    const url = 'https://catfact.ninja/facts?limit=3';
    try {
      final response = await _getResponce(url, null);
      List<dynamic> data = json.decode(response.body)['data'];
      return data.isNotEmpty
          ? data.map((i) => i['fact'].toString()).toList()
          : [];
    } catch (e) {
      throw Exception(e);
    }
  }
}
