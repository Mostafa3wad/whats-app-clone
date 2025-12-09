import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whats_app_clone/features/chat/domain/entities/message_entity.dart';

class MessageBubble extends StatelessWidget {
  final MessageEntity message;

  const MessageBubble({super.key, required this.message});

  String _formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  Widget _buildStatusIcon() {
    if (!message.isMine) {
      return const SizedBox.shrink();
    }

    IconData iconData;
    Color iconColor;

    switch (message.status) {
      case MessageStatus.sending:
        return const SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
          ),
        );
      case MessageStatus.sent:
        iconData = Icons.check;
        iconColor = Colors.white70;
        break;
      case MessageStatus.delivered:
        iconData = Icons.done_all;
        iconColor = Colors.white70;
        break;
      case MessageStatus.read:
        iconData = Icons.done_all;
        iconColor = const Color(0xFF34B7F1);
        break;
      case MessageStatus.failed:
        iconData = Icons.error_outline;
        iconColor = Colors.red;
        break;
    }

    return Icon(iconData, size: 16, color: iconColor);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: message.isMine ? 64 : 8,
          right: message.isMine ? 8 : 64,
          top: 4,
          bottom: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: message.isMine
              ? const Color(0xFF005C4B) // WhatsApp green for sent messages
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isMine ? 16 : 4),
            bottomRight: Radius.circular(message.isMine ? 4 : 16),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message.content,
              style: TextStyle(
                fontSize: 15,
                color: message.isMine ? Colors.white : Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    fontSize: 11,
                    color: message.isMine ? Colors.white70 : Colors.black45,
                  ),
                ),
                if (message.isMine) ...<Widget>[
                  const SizedBox(width: 4),
                  _buildStatusIcon(),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
