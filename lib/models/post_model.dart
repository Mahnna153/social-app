class PostModel {
  String? name;
  String? dateTime;
  String? text;
  String? uId;
  String? postImage;
  String? profileImage;

  PostModel({
    this.name,
    this.dateTime,
    this.text,
    this.uId,
    this.postImage,
    this.profileImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    text = json['text'];
    uId = json['uId'];
    postImage = json['postImage'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'text': text,
      'uId': uId,
      'postImage': postImage,
      'profileImage': profileImage,
    };
  }
}
