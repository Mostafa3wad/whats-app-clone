import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/constants/paths/app_assets.dart';
import 'package:whats_app_clone/features/chat/presentation/cubit/chat_details_cubit.dart';
import 'package:whats_app_clone/features/chat/presentation/widgets/chat_details/chat_details_appbar.dart';
import 'package:whats_app_clone/features/chat/presentation/widgets/chat_details/message_input_bar.dart';
import 'package:whats_app_clone/features/chat/presentation/widgets/chat_details/messages_list.dart';

class ChatDetailsArg {
  final String chatId;
  final String contactName;
  final String avatarUrl;

  ChatDetailsArg({
    required this.chatId,
    required this.contactName,
    this.avatarUrl = '',
  });
}

class ChatDetailsPage extends StatelessWidget {
  const ChatDetailsPage({super.key, required this.arg});
  final ChatDetailsArg arg;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image - fixed and doesn't resize
        Positioned.fill(
          child: Image.asset(AppAssets.backgroundChat, fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomInset: false,
          appBar: ChatDetailsAppbar(arg: arg),
          body: Column(
            children: <Widget>[
              Expanded(
                child: BlocBuilder<ChatDetailsCubit, ChatDetailsState>(
                  builder: (BuildContext context, ChatDetailsState state) {
                    if (state is ChatDetailsLoaded) {
                      return MessagesList(messages: state.messages);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              BlocBuilder<ChatDetailsCubit, ChatDetailsState>(
                builder: (BuildContext context, ChatDetailsState state) {
                  return MessageInputBar(
                    onSendMessage: (String text) {
                      context.read<ChatDetailsCubit>().sendMessage(text);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
