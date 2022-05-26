import 'package:http/http.dart' as http;
import '../classes/api/base_api.dart';

class ConversationService extends BaseApi {
  Future<http.Response> getConversations() async {
    return await api.httpGet('conversations', query: {});
  }
}