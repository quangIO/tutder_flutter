


class API {
  //static const String BASE_URL = 'http://zerotech.herokuapp.com';
  static const String BASE_URL = 'http://10.209.13.111:8000';
  //static const String BASE_URL = 'https://zeroeg.herokuapp.com';
  static const String LOGIN_URL = BASE_URL + '/login';
  static const String REGISTER_URL = BASE_URL + '/register';
  static const String UPLOAD_URL = BASE_URL + '/secured/upload';
  static const String USER_PROFILE_URL = BASE_URL + '/secured/user/';
  static const String REFRESH_URL = BASE_URL + '/secured/refresh';
  static const String IMAGE_CDN_URL = 'http://res.cloudinary.com/learnstuffinsideout/image/upload/';
  static const String USER_UPDATE_URL = BASE_URL + '/secured/user/update';
  static const String SKILL_URL_CREATE = BASE_URL + '/secured/skill/create';
  static String getWebSocketUrl() =>
      'ws://' + BASE_URL.split("//")[1] + '/secured/ws';
  static const Map<String, String> DEFAULT_HEADER = const{'Accept': 'application/json;charset=utf-8'};
}
