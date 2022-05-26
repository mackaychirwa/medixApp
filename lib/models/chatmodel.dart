// To parse this JSON data, do
//
//     final chatSelect = chatSelectFromJson(jsonString);

import 'dart:convert';

List<ChatSelect> chatSelectFromJson(String str) => List<ChatSelect>.from(json.decode(str).map((x) => ChatSelect.fromJson(x)));

String chatSelectToJson(List<ChatSelect> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatSelect {
  ChatSelect({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.sentTime,
    required this.messageText,
    required this.status,
  });

  String id;
  String fromUser;
  String toUser;
  DateTime sentTime;
  String messageText;
  String status;

  factory ChatSelect.fromJson(Map<String, dynamic> json) => ChatSelect(
    id: json["id"],
    fromUser: json["from_user"],
    toUser: json["to_user"],
    sentTime: DateTime.parse(json["sent_time"]),
    messageText: json["message_text"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from_user": fromUser,
    "to_user": toUser,
    "sent_time": sentTime.toIso8601String(),
    "message_text": messageText,
    "status": status,
  };
}
