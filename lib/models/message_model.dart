class MessageModel {
  String? text;
  String? dateTime;
  String? senderId;
  String? receiverId;

  MessageModel({
    this.text,
    this.dateTime,
    this.senderId,
    this.receiverId,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    text = json['text'];
    receiverId = json['receiverId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'dateTime': dateTime,
      'text': text,
      'receiverId': receiverId,
    };
  }
}
