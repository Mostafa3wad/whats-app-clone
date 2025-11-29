part of 'chat_details_cubit.dart';

abstract class ChatDetailsState extends Equatable {
  const ChatDetailsState();

  @override
  List<Object?> get props => <Object?>[];
}

class ChatDetailsInitial extends ChatDetailsState {}

class ChatDetailsLoaded extends ChatDetailsState {
  final List<MessageEntity> messages;
  final bool isOnline;
  final String? lastSeen;

  const ChatDetailsLoaded({
    required this.messages,
    this.isOnline = false,
    this.lastSeen,
  });

  ChatDetailsLoaded copyWith({
    List<MessageEntity>? messages,
    bool? isOnline,
    String? lastSeen,
  }) {
    return ChatDetailsLoaded(
      messages: messages ?? this.messages,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  @override
  List<Object?> get props => <Object?>[messages, isOnline, lastSeen];
}
