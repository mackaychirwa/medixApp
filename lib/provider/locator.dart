import 'package:get_it/get_it.dart';
import 'package:untitled/provider/conversation_provider.dart';
import 'package:untitled/widgets/conversationList.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => ConversationProvider());
  // ConversationProvider()
}