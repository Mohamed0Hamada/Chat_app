import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder/models/message.dart';
import 'package:folder/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:folder/pages/cubits/chat_cubit/chat_state.dart';
import 'package:folder/widget/constant.dart';
import 'package:folder/widget/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'chatPage';
  final _Controller = ScrollController();
  List<Message> messagesList = [];

  TextEditingController Controller = TextEditingController();

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(kLogo, height: 50), Text('Chat')],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList = BlocProvider.of<ChatCubit>(
                  context,
                ).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _Controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBubble(message: messagesList[index])
                        : ChatBubbleForFriend(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: Controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(
                  context,
                ).sendMessage(message: data, email: email.toString());
                Controller.clear();
                _Controller.animateTo(
                  0,
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500),
                );
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                hintText: 'Type your message here...',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
