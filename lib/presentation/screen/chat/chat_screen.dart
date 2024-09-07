import 'package:dnext_chatbot/bloc/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    File? selectedFile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: [
          // Chat history list
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state.status == ChatStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == ChatStatus.loaded) {
                  return ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      var message = state.messages[index];
                      return ListTile(
                        title: Text(message.title!),
                        subtitle: Text(message.time!.toIso8601String()),
                      );
                    },
                  );
                } else if (state.status == ChatStatus.error) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('Start a conversation.'));
                }
              },
            ),
          ),
          // Message input and file picker
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null && result.files.isNotEmpty) {
                      selectedFile = File(result.files.single.path!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('File selected: ${selectedFile!.path}')),
                      );
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.isNotEmpty ||
                        selectedFile != null) {
                      // context.read<ChatBloc>().add(SendMessage(messageController.text, file: selectedFile));
                      messageController.clear();
                      selectedFile = null;
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
