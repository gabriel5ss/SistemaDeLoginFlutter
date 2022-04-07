class User {
  final int id;
  final String name;
  final String email;
  final String accessToken;

  const User({required this. id, required this.name, required this.email, required this.accessToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['data']['id'],
      name: json['data']['name'],
      email: json['data']['email'],
      accessToken: json['access_token']
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['accessToken'] = accessToken;
    return data;
  }
}