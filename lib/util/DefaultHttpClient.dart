import 'dart:async';

import 'package:http/http.dart' as http;


class DefaultHttpClient extends http.BaseClient {
  final String session;
  final http.Client _inner;

  DefaultHttpClient(this.session, [this._inner] );

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['cookie'] = session;
    if (_inner == null) {
      return http.Client().send(request);
    }
    return _inner.send(request);
  }
}