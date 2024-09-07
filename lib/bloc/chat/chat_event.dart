part of 'chat_bloc.dart';

abstract class ChatEvent{}

class ChatScreenLoadEvent extends ChatEvent{}

class ChatScreenLoadedEvent extends ChatEvent{}

class ChatScreenErrorEvent extends ChatEvent{
  final String message;
  ChatScreenErrorEvent(this.message);
}

class ChatHistoryLoadEvent extends ChatEvent{}

class ChatHistoryLoadedEvent extends ChatEvent{
  final List<ChatMessage> chatMessages;
  ChatHistoryLoadedEvent(this.chatMessages);
}

class ChatHistoryErrorEvent extends ChatEvent{
  final String message;
  ChatHistoryErrorEvent(this.message);
}
