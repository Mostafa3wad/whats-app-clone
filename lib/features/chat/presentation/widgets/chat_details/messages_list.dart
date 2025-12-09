import 'package:flutter/material.dart';
import 'package:whats_app_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whats_app_clone/features/chat/presentation/widgets/chat_details/message_bubble.dart';
import 'package:intl/intl.dart';

class MessagesList extends StatefulWidget {
  final List<MessageEntity> messages;

  const MessagesList({super.key, required this.messages});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void didUpdateWidget(MessagesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length != oldWidget.messages.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  String _formatDate(DateTime date) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = today.subtract(const Duration(days: 1));
    final DateTime messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('EEE, MMM d').format(date);
    }
  }

  bool _shouldShowDateSeparator(int index) {
    if (index == 0) {
      return true;
    }

    final DateTime currentMessageDate = widget.messages[index].timestamp;
    final DateTime previousMessageDate = widget.messages[index - 1].timestamp;

    return currentMessageDate.day != previousMessageDate.day ||
        currentMessageDate.month != previousMessageDate.month ||
        currentMessageDate.year != previousMessageDate.year;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: widget.messages.length,
      itemBuilder: (BuildContext context, int index) {
        final MessageEntity message = widget.messages[index];
        final bool showDateSeparator = _shouldShowDateSeparator(index);

        return Column(
          children: <Widget>[
            if (showDateSeparator)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    _formatDate(message.timestamp),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            MessageBubble(message: message),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
