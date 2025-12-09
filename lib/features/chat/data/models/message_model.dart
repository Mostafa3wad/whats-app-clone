import 'package:whats_app_clone/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.chatId,
    required super.senderId,
    required super.content,
    required super.messageType,
    required super.timestamp,
    required super.isMine,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, int currentUserId) {
    return MessageModel(
      id: json['id'],
      chatId: json['chat'],
      senderId: json['sender'],
      content: json['content'],
      messageType: json['message_type'] ?? 'text',
      timestamp: DateTime.parse(json['timestamp']),
      isMine: json['sender'] == currentUserId,
    );
  }
}
