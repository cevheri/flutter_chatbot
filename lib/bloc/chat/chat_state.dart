part of 'chat_bloc.dart';


enum ChatStatus { initial, loading, loaded, error }

class ChatState {
  final ChatStatus status;
  final List<ChatMessage> messages;
  final String message;

  ChatState({required this.status, required this.messages, required this.message});

  factory ChatState.initial() {
    return ChatState(
      status: ChatStatus.initial,
      messages: [],
      message: '',
    );
  }

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessage>? chatMessages,
    String? message,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: chatMessages ?? messages,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'ChatState{status: $status, chatMessages: $messages, message: $message}';
  }

}