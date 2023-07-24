import 'package:app_prueba/controllers/url_shortener_controller.dart';
import 'package:app_prueba/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final urlShortenerController = ChangeNotifierProvider((ref) {
  return UrlShortenerController();
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
