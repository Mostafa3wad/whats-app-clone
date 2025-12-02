import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';
import 'package:whats_app_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whats_app_clone/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:whats_app_clone/features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:whats_app_clone/features/chat/presentation/widgets/chat_list_item.dart';
import 'package:whats_app_clone/features/chat/presentation/widgets/chat_sub_header.dart';
import 'package:whats_app_clone/features/chat/presentation/widgets/edit_mode_bottom_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      body: Column(
        children: <Widget>[
          const ChatSubHeader(),
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (BuildContext context, ChatState state) {
                if (state is ChatLoaded) {
                  if (state.chats.isEmpty) {
                    return const Center(
                      child: Text(
                        'No chats',
                        style: AppStyles.chatMessageStyle,
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: state.chats.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox.shrink(),
                    itemBuilder: (BuildContext context, int index) {
                      final ChatEntity chat = state.chats[index];
                      final bool isSelected = state.selectedChatIds.contains(
                        chat.id,
                      );
                      return ChatListItem(chat: chat, isSelected: isSelected);
                    },
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const EditModeBottomBar(),
    );
  }
}
