import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/core/constants/paths/app_assets.dart';
import 'package:whats_app_clone/features/chat/domain/entities/chat_entity.dart';
import 'package:whats_app_clone/features/chat/presentation/constants/chat_constants.dart';
import 'package:whats_app_clone/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:whats_app_clone/features/chat/presentation/widgets/chat_action_sheet.dart';

class ChatListItem extends StatelessWidget {
  final ChatEntity chat;
  final bool isSelected;

  const ChatListItem({super.key, required this.chat, this.isSelected = false});

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.month}/${timestamp.day}/${timestamp.year.toString().substring(2)}';
  }

  Widget _buildMessagePreview() {
    switch (chat.messageType) {
      case MessageType.voice:
        return Row(
          children: <Widget>[
            const Icon(Icons.mic, color: Colors.green, size: 16),
            const SizedBox(width: 4),
            Text(
              chat.voiceDuration ?? chat.lastMessage,
              style: ChatConstants.chatMessageStyle,
            ),
          ],
        );
      case MessageType.photo:
        return Row(
          children: <Widget>[
            const Icon(
              Icons.camera_alt,
              color: ChatConstants.chatSecondaryTextColor,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(chat.lastMessage, style: ChatConstants.chatMessageStyle),
          ],
        );
      case MessageType.text:
        return Row(
          children: <Widget>[
            if (chat.isRead) ...<Widget>[
              SvgPicture.asset(AppAssets.doneAll),
              const SizedBox(width: 4),
            ],
            Expanded(
              child: Text(
                chat.lastMessage,
                style: ChatConstants.chatMessageStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (BuildContext context, ChatState state) {
        final bool isEditMode = state is ChatLoaded && state.isEditMode;

        final Widget chatContent = InkWell(
          onTap: () {
            if (isEditMode) {
              context.read<ChatCubit>().toggleChatSelection(chat.id);
            } else {
              // Navigate to chat detail
            }
          },
          onLongPress: () {
            if (!isEditMode) {
              context.read<ChatCubit>().toggleEditMode();
              context.read<ChatCubit>().toggleChatSelection(chat.id);
            }
          },
          child: Container(
            height: ChatConstants.chatItemHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: ChatConstants.chatItemPadding,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ChatConstants.chatDividerColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                if (isEditMode) ...<Widget>[
                  Container(
                    width: ChatConstants.selectionCircleSize,
                    height: ChatConstants.selectionCircleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.brandColor
                            : ChatConstants.chatDividerColor,
                        width: 2,
                      ),
                      color: isSelected
                          ? AppColors.brandColor
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : null,
                  ),
                  const SizedBox(width: 12),
                ],
                CircleAvatar(
                  radius: ChatConstants.avatarSize / 2,
                  backgroundColor: ChatConstants.chatDividerColor,
                  child: chat.avatarUrl.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            chat.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (
                                  BuildContext context,
                                  Object error,
                                  StackTrace? stackTrace,
                                ) {
                                  return _buildAvatarInitials();
                                },
                          ),
                        )
                      : _buildAvatarInitials(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        chat.name,
                        style: ChatConstants.chatNameStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      _buildMessagePreview(),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      _formatTimestamp(chat.timestamp),
                      style: ChatConstants.chatTimestampStyle,
                    ),
                    if (!isEditMode) ...<Widget>[
                      const SizedBox(height: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: ChatConstants.chatDividerColor,
                        size: 16,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );

        if (isEditMode) {
          return chatContent;
        }

        return Slidable(
          key: Key(chat.id),
          groupTag: 'chat_list',
          closeOnScroll: false,
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.45,
            children: <Widget>[
              SlidableAction(
                onPressed: (BuildContext slidableContext) {
                  Slidable.of(slidableContext)?.close();
                  ChatActionSheet.show(
                    context,
                    onDeleteChat: () {
                      Navigator.of(context).pop();
                      context.read<ChatCubit>().archiveChat(chat.id);
                    },
                    onClearChat: () {
                      Navigator.of(context).pop();
                      // Clear chat implementation
                    },
                  );
                },
                backgroundColor: AppColors.grey3,
                icon: Icons.more_horiz,
                foregroundColor: Colors.white,
                label: 'More',
              ),
              SlidableAction(
                onPressed: (BuildContext slidableContext) {
                  Slidable.of(slidableContext)?.close();
                  context.read<ChatCubit>().archiveChat(chat.id);
                },
                backgroundColor: AppColors.secendry,
                foregroundColor: Colors.white,
                icon: Icons.archive_outlined,
                label: 'Archive',
              ),
            ],
          ),
          child: chatContent,
        );
      },
    );
  }

  Widget _buildAvatarInitials() {
    final String initials = chat.name
        .split(' ')
        .map((String word) => word.isNotEmpty ? word[0] : '')
        .take(2)
        .join()
        .toUpperCase();
    return Text(
      initials,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
