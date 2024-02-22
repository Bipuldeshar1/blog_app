class UserModel {
  String? id;
  String? userName;
  String? password;
  String? email;
  String? accessToken;
  String? refreshToken;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.userName,
    this.password,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      userName: json['userName'],
      password: json['password'],
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
