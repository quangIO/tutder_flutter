class User {
  final String imageUrl;
  final String username;
  final String intro;
  final String session;

  int loved;

  User(this.username, {
    this.imageUrl = 'http://d3iw72m71ie81c.cloudfront.net/female-44.jpg',
    this.intro = '',
    this.session,
    this.loved = 0,
  });

  // static User fromMap(Map<String, dynamic> m) =>User(m['username'], )
}
