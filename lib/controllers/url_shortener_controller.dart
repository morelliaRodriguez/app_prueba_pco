import 'package:app_prueba/models/shortnened_url_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UrlShortenerController extends ChangeNotifier {
  String _url = '';
  List<ShortenedUrl> _shortUrls = [];

  List<ShortenedUrl> get shortUrls => _shortUrls;
  String get url => _url;

  set url(String value) {
    _url = value;
    notifyListeners();
  }

  Future<void> shortenUrl(String longUrl) async {
    const apiUrl = "https://cleanuri.com/api/v1/shorten";
    final response = await http.post(Uri.parse(apiUrl), body: {"url": longUrl});

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final shortUrl = jsonResponse["result_url"];

      _shortUrls.add(ShortenedUrl(longUrl, shortUrl));
      notifyListeners();
    } else {
      throw Exception("No se pudo acortar la URL.");
    }
  }
}
