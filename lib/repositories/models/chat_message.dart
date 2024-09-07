
import 'dart:convert';

class ChatMessage{
  String? title;
  String? message;
  DateTime? time;

  ChatMessage({this.title, this.message, this.time});

  @override
  String toString() {
    return 'ChatMessage{title: $title, message: $message, time: $time}';
  }

  ChatMessage copyWith({
    String? title,
    String? message,
    DateTime? time,
  }) {
    return ChatMessage(
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'time': time!.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      title: map['title'],
      message: map['message'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatMessage &&
      other.title == title &&
      other.message == message &&
      other.time == time;
  }

  @override
  int get hashCode => message.hashCode ^ time.hashCode;


}