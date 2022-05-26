import 'package:flutter/cupertino.dart';
import 'dart:convert';


class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

ChatMessageModel chatMessageModelFromJson(String str) => ChatMessageModel.fromJson(json.decode(str));

String chatMessageModelToJson(ChatMessageModel data) => json.encode(data.toJson());

class ChatMessageModel {
  ChatMessageModel({
    required this.chatId,
    required this.to,
    required this.from,
    required this.message,
    required this.chatType,
    required this.toUserOnlineStatus,
  });

  int chatId;
  int to;
  int from;
  String message;
  String chatType;
  bool toUserOnlineStatus;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    chatId: json["chat_id"],
    to: json["to"],
    from: json["from"],
    message: json["message"],
    chatType: json["chat_Type"],
    toUserOnlineStatus: json["to)user_online_status"],
  );

  Map<String, dynamic> toJson() => {
    "chat_id": chatId,
    "to": to,
    "from": from,
    "message": message,
    "chat_Type": chatType,
    "to)user_online_status": toUserOnlineStatus,
  };
}
