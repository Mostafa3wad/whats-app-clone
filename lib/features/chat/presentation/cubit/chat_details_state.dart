part of 'chat_details_cubit.dart';

abstract class ChatDetailsState extends Equatable {
  const ChatDetailsState();

  @override
  List<Object?> get props => <Object?>[];
}

class ChatDetailsInitial extends ChatDetailsState {}

class ChatDetailsLoading extends ChatDetailsState {}

class ChatDetailsLoaded extends ChatDetailsState {
  final List<MessageEntity> messages;
  final bool isOnline;
  final String? lastSeen;
  final String? errorMessage;

  const ChatDetailsLoaded({
    required this.messages,
    this.isOnline = false,
    this.lastSeen,
    this.errorMessage,
  });

  ChatDetailsLoaded copyWith({
    List<MessageEntity>? messages,
    bool? isOnline,
    String? lastSeen,
    String? errorMessage,
  }) {
    return ChatDetailsLoaded(
      messages: messages ?? this.messages,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    messages,
    isOnline,
    lastSeen,
    errorMessage,
  ];
}

class ChatDetailsError extends ChatDetailsState {
  final String message;

  const ChatDetailsError({required this.message});

  @override
  List<Object?> get props => <Object?>[message];
}
