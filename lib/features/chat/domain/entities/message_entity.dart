import 'package:equatable/equatable.dart';

enum MessageStatus { sending, sent, delivered, read, failed }

class MessageEntity extends Equatable {
  final String id;
  final String text;
  final bool isMe;
  final DateTime dateTime;
  final MessageStatus status;

  const MessageEntity({
    required this.id,
    required this.text,
    required this.isMe,
    required this.dateTime,
    this.status = MessageStatus.sent,
  });

  MessageEntity copyWith({
    String? id,
    String? text,
    bool? isMe,
    DateTime? dateTime,
    MessageStatus? status,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => <Object?>[id, text, isMe, dateTime, status];
}
