part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => <Object?>[];
}

class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatEntity> chats;
  final bool isEditMode;
  final Set<String> selectedChatIds;

  const ChatLoaded({
    required this.chats,
    this.isEditMode = false,
    this.selectedChatIds = const <String>{},
  });

  ChatLoaded copyWith({
    List<ChatEntity>? chats,
    bool? isEditMode,
    Set<String>? selectedChatIds,
  }) {
    return ChatLoaded(
      chats: chats ?? this.chats,
      isEditMode: isEditMode ?? this.isEditMode,
      selectedChatIds: selectedChatIds ?? this.selectedChatIds,
    );
  }

  @override
  List<Object?> get props => <Object?>[chats, isEditMode, selectedChatIds];
}
