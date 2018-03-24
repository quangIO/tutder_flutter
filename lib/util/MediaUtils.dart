import 'dart:async';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../config/HttpConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MediaUtils {
  static void _addHeader(
      http.MultipartRequest _request, Map<String, String> headers) {
    headers.forEach((key, value) {
      _request.headers[key] = value;
    });
  }

  static Future<String> upload([String param = '']) async {
    final pref = await SharedPreferences.getInstance();
    final _imageFile =
        await ImagePicker.pickImage(maxWidth: 500.0, maxHeight: 500.0);
    final _request =
        new http.MultipartRequest('POST', Uri.parse(API.UPLOAD_URL + param));
    _addHeader(_request, API.DEFAULT_HEADER);
    _addHeader(_request, {'cookie': pref.getString('session')});
    _request.files
        .add(await http.MultipartFile.fromPath('file', _imageFile.path));
    http.Response response =
        await http.Response.fromStream(await _request.send());
    Map<String, dynamic> body = json.decode(response.body);
    return body['content'];
  }
}
