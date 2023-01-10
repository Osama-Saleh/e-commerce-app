
// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? name;
  String? email;
  String? uid;
  String? password;
  String? profileImage;
  String? coverImage;
  

  UserModel({
    this.name,
    this.email,
    this.uid,
    this.password,
    this.profileImage,
    this.coverImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uid': uid,
      'password': password,
      'profileImage': profileImage,
      'coverImage': coverImage,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] != null ? json['name'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      uid: json['uid'] != null ? json['uid'] as String : null,
      password: json['password'] != null ? json['password'] as String : null,
      profileImage: json['profileImage'] != null ? json['profileImage'] as String : null,
      coverImage: json['coverImage'] != null ? json['coverImage'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source) as Map<String, dynamic>);
}
