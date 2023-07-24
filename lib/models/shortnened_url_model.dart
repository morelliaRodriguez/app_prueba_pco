class ShortenedUrl {
  String _longUrl;
  String _shortUrl;

  ShortenedUrl(this._longUrl, this._shortUrl);

  // Método get para obtener el valor de longUrl
  String get longUrl => _longUrl;

  // Método set para establecer el valor de longUrl
  set longUrl(String value) {
    _longUrl = value;
  }

  // Método get para obtener el valor de shortUrl
  String get shortUrl => _shortUrl;

  // Método set para establecer el valor de shortUrl
  set shortUrl(String value) {
    _shortUrl = value;
  }
}
