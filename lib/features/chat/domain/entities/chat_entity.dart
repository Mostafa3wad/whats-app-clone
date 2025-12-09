import 'package:equatable/equatable.dart';

enum MessageType { text, voice, photo }

class ChatEntity extends Equatable {
  final int id;
  final String name;
  final String lastMessage;
  final DateTime timestamp;
  final String avatarUrl;
  final MessageType messageType;
  final bool isRead;
  final String? voiceDuration;

  const ChatEntity({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.avatarUrl,
    required this.messageType,
    this.isRead = false,
    this.voiceDuration,
  });

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    lastMessage,
    timestamp,
    avatarUrl,
    messageType,
    isRead,
    voiceDuration,
  ];
}
