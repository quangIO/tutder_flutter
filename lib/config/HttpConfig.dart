


class API {
  //static const String BASE_URL = 'http://zerotech.herokuapp.com';
  // static const String BASE_URL = 'http://10.209.13.111:8000';
  static const String BASE_URL = 'https://zeroeg.herokuapp.com';
  static const String PLACE_API = BASE_URL + '/place';
  static const String LOGIN_URL = BASE_URL + '/login';
  static const String REGISTER_URL = BASE_URL + '/register';
  static const String UPLOAD_URL = BASE_URL + '/secured/upload';
  static const String FOLLOW_URL = BASE_URL + '/secured/follow/';
  static const String USER_PROFILE_URL = BASE_URL + '/secured/user/';
  static const String USER_FCM_URL = BASE_URL + '/secured/user/fcm';
  static const String REFRESH_URL = BASE_URL + '/secured/refresh';
  static const String IMAGE_CDN_URL = 'http://res.cloudinary.com/hritnj3ng/image/upload/';
  static String getWebSocketUrl() =>
      'ws://' + BASE_URL.split("//")[1] + '/secured/ws';
  static const Map<String, String> DEFAULT_HEADER = const{'Accept': 'application/json;charset=utf-8'};
}
