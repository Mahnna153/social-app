class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? profileimage;
  String? coverimage;
  String? bio;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.profileimage,
    this.coverimage,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    profileimage = json['profileimage'];
    coverimage = json['coverimage'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'profileimage': profileimage,
      'coverimage': coverimage,
      'bio': bio,
    };
  }
}
