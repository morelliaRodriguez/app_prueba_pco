import 'package:flutter_test/flutter_test.dart';
import 'package:app_prueba/controllers/url_shortener_controller.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

// Mock de la clase http.Client
class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('UrlShortenerController', () {
    late UrlShortenerController controller;
    late MockHttpClient mockHttpClient;

    setUp(() {
      controller = UrlShortenerController();
      mockHttpClient = MockHttpClient();
    });

    test('shortenUrl should add ShortenedUrl to shortUrls list on success',
        () async {
      const longUrl = "https://www.example.com";
      const shortUrl = "https://cleanuri.com/qMWpGz";

      // Mock del resultado de la respuesta HTTP exitosa
      final mockResponse = http.Response('{"result_url": "$shortUrl"}', 200);

      // Configuración del mock para el método http.post
      when(() => mockHttpClient.post(
          Uri.parse("https://cleanuri.com/api/v1/shorten"),
          body: {"url": longUrl})).thenAnswer((_) async => mockResponse);

      await controller.shortenUrl(longUrl);

      expect(controller.shortUrls.length, 1);
      expect(controller.shortUrls.first.longUrl, longUrl);
      expect(controller.shortUrls.first.shortUrl, shortUrl);
    });
  });
}
