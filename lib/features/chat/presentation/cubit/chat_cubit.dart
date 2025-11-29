import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whats_app_clone/features/chat/domain/entities/chat_entity.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    _loadDummyChats();
  }

  void _loadDummyChats() {
    final List<ChatEntity> chats = <ChatEntity>[
      ChatEntity(
        id: '1',
        name: 'Martin Randolph',
        lastMessage: 'Yes, 2pm is awesome',
        timestamp: DateTime(2019, 11, 19),
        avatarUrl: '',
        messageType: MessageType.text,
        isRead: true,
      ),
      ChatEntity(
        id: '2',
        name: 'Andrew Parker',
        lastMessage: 'What kind of strategy is better?',
        timestamp: DateTime(2019, 11, 16),
        avatarUrl: '',
        messageType: MessageType.text,
        isRead: true,
      ),
      ChatEntity(
        id: '3',
        name: 'Karen Castillo',
        lastMessage: '0:14',
        timestamp: DateTime(2019, 11, 15),
        avatarUrl: '',
        messageType: MessageType.voice,
        voiceDuration: '0:14',
      ),
      ChatEntity(
        id: '4',
        name: 'Maximillian Jacobson',
        lastMessage: 'Bro, I have a good idea!',
        timestamp: DateTime(2019, 10, 30),
        avatarUrl: '',
        messageType: MessageType.text,
        isRead: true,
      ),
      ChatEntity(
        id: '5',
        name: 'Martha Craig',
        lastMessage: 'Photo',
        timestamp: DateTime(2019, 10, 28),
        avatarUrl: '',
        messageType: MessageType.photo,
      ),
      ChatEntity(
        id: '6',
        name: 'Tabitha Potter',
        lastMessage:
            'Actually I wanted to check with you about your online business plan on our...',
        timestamp: DateTime(2019, 8, 25),
        avatarUrl: '',
        messageType: MessageType.text,
      ),
      ChatEntity(
        id: '7',
        name: 'Maisy Humphrey',
        lastMessage: 'Welcome, to make design process faster, look at Pixsellz',
        timestamp: DateTime(2019, 8, 20),
        avatarUrl: '',
        messageType: MessageType.text,
        isRead: true,
      ),
      ChatEntity(
        id: '8',
        name: 'Kieron Dotson',
        lastMessage: 'Ok, have a good trip!',
        timestamp: DateTime(2019, 7, 29),
        avatarUrl: '',
        messageType: MessageType.text,
        isRead: true,
      ),
    ];

    emit(ChatLoaded(chats: chats));
  }

  void toggleEditMode() {
    if (state is ChatLoaded) {
      final ChatLoaded currentState = state as ChatLoaded;
      emit(
        currentState.copyWith(
          isEditMode: !currentState.isEditMode,
          selectedChatIds: currentState.isEditMode
              ? <String>{}
              : currentState.selectedChatIds,
        ),
      );
    }
  }

  void toggleChatSelection(String chatId) {
    if (state is ChatLoaded) {
      final ChatLoaded currentState = state as ChatLoaded;
      final Set<String> selectedIds = Set<String>.from(
        currentState.selectedChatIds,
      );
      if (selectedIds.contains(chatId)) {
        selectedIds.remove(chatId);
      } else {
        selectedIds.add(chatId);
      }
      emit(currentState.copyWith(selectedChatIds: selectedIds));
    }
  }

  void selectAllChats() {
    if (state is ChatLoaded) {
      final ChatLoaded currentState = state as ChatLoaded;
      emit(
        currentState.copyWith(
          selectedChatIds: currentState.chats
              .map((ChatEntity chat) => chat.id)
              .toSet(),
        ),
      );
    }
  }

  void clearSelection() {
    if (state is ChatLoaded) {
      final ChatLoaded currentState = state as ChatLoaded;
      emit(currentState.copyWith(selectedChatIds: <String>{}));
    }
  }

  void archiveChat(String chatId) {
    if (state is ChatLoaded) {
      final ChatLoaded currentState = state as ChatLoaded;
      final List<ChatEntity> updatedChats = currentState.chats
          .where((ChatEntity chat) => chat.id != chatId)
          .toList();
      emit(currentState.copyWith(chats: updatedChats));
    }
  }

  void archiveSelectedChats() {
    if (state is ChatLoaded) {
      final ChatLoaded currentState = state as ChatLoaded;
      final List<ChatEntity> updatedChats = currentState.chats
          .where(
            (ChatEntity chat) =>
                !currentState.selectedChatIds.contains(chat.id),
          )
          .toList();
      emit(
        currentState.copyWith(
          chats: updatedChats,
          selectedChatIds: <String>{},
          isEditMode: false,
        ),
      );
    }
  }

  void deleteSelectedChats() {
    if (state is ChatLoaded) {
      final ChatLoaded currentState = state as ChatLoaded;
      final List<ChatEntity> updatedChats = currentState.chats
          .where(
            (ChatEntity chat) =>
                !currentState.selectedChatIds.contains(chat.id),
          )
          .toList();
      emit(
        currentState.copyWith(
          chats: updatedChats,
          selectedChatIds: <String>{},
          isEditMode: false,
        ),
      );
    }
  }

  void markAllAsRead() {
    if (state is ChatLoaded) {
      final ChatLoaded currentState = state as ChatLoaded;
      final List<ChatEntity> updatedChats = currentState.chats.map((
        ChatEntity chat,
      ) {
        return ChatEntity(
          id: chat.id,
          name: chat.name,
          lastMessage: chat.lastMessage,
          timestamp: chat.timestamp,
          avatarUrl: chat.avatarUrl,
          messageType: chat.messageType,
          isRead: true,
          voiceDuration: chat.voiceDuration,
        );
      }).toList();
      emit(currentState.copyWith(chats: updatedChats));
    }
  }
}
