import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ConversationModel {
  int id;
  ChatUsers user;
  String createdAt;

  // List<Messages> messages;

  ConversationModel({required this.id, required this.user, required this.createdAt});


  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
        id: json['id'],
        user: json['user'],
        createdAt: json['createdAt']
    );
  }
}

class ChatUsers{
  String name;
  String messageText;
  String imageURL;
  String time;

  ChatUsers({required this.name,required this.messageText,
    required this.imageURL,required this.time,
    required String text, required String image, required String secondaryText});
}