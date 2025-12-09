import 'package:equatable/equatable.dart';

enum MessageStatus { sending, sent, delivered, read, failed }

class MessageEntity extends Equatable {
  final int id;
  final int chatId;
  final int senderId;
  final String content;
  final String messageType;
  final DateTime timestamp;
  final bool isMine;
  final MessageStatus status;

  const MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.messageType,
    required this.timestamp,
    required this.isMine,
    this.status = MessageStatus.sent,
  });

  MessageEntity copyWith({
    int? id,
    int? chatId,
    int? senderId,
    String? content,
    String? messageType,
    DateTime? timestamp,
    bool? isMine,
    MessageStatus? status,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      timestamp: timestamp ?? this.timestamp,
      isMine: isMine ?? this.isMine,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    chatId,
    senderId,
    content,
    messageType,
    timestamp,
    isMine,
    status,
  ];
}
