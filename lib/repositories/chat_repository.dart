
import 'package:dnext_chatbot/repositories/models/chat_message.dart';

class ChatRepository {
  getMessages() {
    List<ChatMessage> chatMessages = [
      ChatMessage(title: 'First Question', message: 'First message', time: DateTime.now()),
      ChatMessage(title: 'Second Question', message: 'Second message', time: DateTime.now()),
      ChatMessage(title: 'Third Question', message: 'Third message', time: DateTime.now()),
      ChatMessage(title: 'Fourth Question', message: 'Fourth message', time: DateTime.now()),
      ChatMessage(title: 'Fifth Question', message: 'Fifth message', time: DateTime.now()),
      ChatMessage(title: 'Sixth Question', message: 'Sixth message', time: DateTime.now()),
      ChatMessage(title: 'Seventh Question', message: 'Seventh message', time: DateTime.now()),
      ChatMessage(title: 'Eighth Question', message: 'Eighth message', time: DateTime.now()),
      ChatMessage(title: 'Ninth Question', message: 'Ninth message', time: DateTime.now()),
      ChatMessage(title: 'Tenth Question', message: 'Tenth message', time: DateTime.now()),
    ];
    return chatMessages;
  }
  // final ChatApiClient chatApiClient;
  //
  // ChatRepository({required this.chatApiClient});
  //
  // Future<List<Message>> getMessages() async {
  //   return await chatApiClient.getMessages();
  // }
  //
  // Future<void> sendMessage(String message) async {
  //   return await chatApiClient.sendMessage(message);
  // }
}