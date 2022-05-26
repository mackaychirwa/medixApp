import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/chatUsersModel.dart';
import 'conversation_service.dart';

class ConversationProvider extends ChangeNotifier {
  final ConversationService _conversationService = ConversationService();
  final List<ConversationModel> _concersations = [];
  List<ConversationModel> get concersations => _concersations;

  bool _busy = false;

  bool get busy => _busy;
  setBusy(bool val) {
    _busy = val;
    notifyListeners();
  }

  Future<List<ConversationModel>> getConversations() async {
    setBusy(true);
    var response = await _conversationService.getConversations();

    if(response.statusCode== 200) {
      var data = jsonDecode(response.body);
      data['data'].forEach((conversation) =>
      _concersations.add(ConversationModel.fromJson(conversation)));
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return _concersations;
  }
}