import 'package:dnext_chatbot/repositories/chat_repository.dart';
import 'package:dnext_chatbot/repositories/models/chat_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required this.chatRepository}) : super(ChatState.initial()) {
    on<ChatScreenLoadEvent>(_onLoad);
  }

  final ChatRepository chatRepository;

  Future<void> _onLoad(ChatScreenLoadEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(status: ChatStatus.loading));
    try {
      final chatMessages = await chatRepository.getMessages();
      emit(state.copyWith(status: ChatStatus.loaded, chatMessages: chatMessages));
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.error, message: e.toString()));
    }
  }

}