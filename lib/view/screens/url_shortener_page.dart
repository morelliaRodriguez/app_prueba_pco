import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';

class UrlShortenerApp extends ConsumerWidget {
  const UrlShortenerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegExp regExp = RegExp(r'^(?:http|https):\/\/[\w\-]+(\.[\w\-]+)+[/#?]?.*$',
        caseSensitive: false, multiLine: false);
    return MaterialApp(
      title: 'URL Shortener App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('URL Shortener App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: "Ingrese una URL larga"),
                onChanged: (value) {
                  ref.watch(urlShortenerController).url = value;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.watch(urlShortenerController).url.isNotEmpty &&
                          regExp.hasMatch(ref.watch(urlShortenerController).url)
                      ? ref
                          .watch(urlShortenerController)
                          .shortenUrl(ref.watch(urlShortenerController).url)
                      : _showWarningDialog(context, 'URL invalida');
                },
                child: const Text("Acortar URL"),
              ),
              const SizedBox(height: 20),
              const Text("URLs acortadas:"),
              Expanded(
                child: ListView.builder(
                  itemCount: ref.watch(urlShortenerController).shortUrls.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(ref
                          .watch(urlShortenerController)
                          .shortUrls[index]
                          .shortUrl),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Advertencia"),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}
