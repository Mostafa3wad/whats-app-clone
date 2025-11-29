import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whats_app_clone/features/chat/domain/entities/message_entity.dart';

part 'chat_details_state.dart';

class ChatDetailsCubit extends Cubit<ChatDetailsState> {
  final String chatId;
  final String contactName;

  ChatDetailsCubit({required this.chatId, required this.contactName})
    : super(ChatDetailsInitial()) {
    _loadDummyMessages();
  }

  void _loadDummyMessages() {
    final DateTime now = DateTime.now();
    final List<MessageEntity> messages = <MessageEntity>[
      MessageEntity(
        id: '1',
        text: 'Hey! How are you doing?',
        isMe: false,
        dateTime: now.subtract(const Duration(hours: 2)),
        status: MessageStatus.read,
      ),
      MessageEntity(
        id: '2',
        text: 'I\'m doing great! Thanks for asking 😊',
        isMe: true,
        dateTime: now.subtract(const Duration(hours: 1, minutes: 58)),
        status: MessageStatus.read,
      ),
      MessageEntity(
        id: '3',
        text: 'Do you know what time is it?',
        isMe: false,
        dateTime: now.subtract(const Duration(hours: 1, minutes: 45)),
        status: MessageStatus.read,
      ),
      MessageEntity(
        id: '4',
        text: 'It\'s morning in Tokyo 😄',
        isMe: true,
        dateTime: now.subtract(const Duration(hours: 1, minutes: 40)),
        status: MessageStatus.read,
      ),
      MessageEntity(
        id: '5',
        text: 'What is the most popular meal in Japan?',
        isMe: false,
        dateTime: now.subtract(const Duration(hours: 1, minutes: 35)),
        status: MessageStatus.read,
      ),
      MessageEntity(
        id: '6',
        text: 'Do you like it?',
        isMe: false,
        dateTime: now.subtract(const Duration(hours: 1, minutes: 34)),
        status: MessageStatus.read,
      ),
      MessageEntity(
        id: '7',
        text: 'I think top two are: Sushi and Ramen! 🍜',
        isMe: true,
        dateTime: now.subtract(const Duration(hours: 1, minutes: 30)),
        status: MessageStatus.read,
      ),
      MessageEntity(
        id: '8',
        text: 'Good morning!',
        isMe: true,
        dateTime: now.subtract(const Duration(minutes: 45)),
        status: MessageStatus.read,
      ),
      MessageEntity(
        id: '9',
        text: 'Japan looks amazing!',
        isMe: true,
        dateTime: now.subtract(const Duration(minutes: 40)),
        status: MessageStatus.read,
      ),
      MessageEntity(
        id: '10',
        text: 'Good bye!',
        isMe: true,
        dateTime: now.subtract(const Duration(minutes: 10)),
        status: MessageStatus.read,
      ),
    ];

    emit(
      ChatDetailsLoaded(messages: messages, isOnline: true, lastSeen: 'online'),
    );
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) {
      return;
    }

    if (state is ChatDetailsLoaded) {
      final ChatDetailsLoaded currentState = state as ChatDetailsLoaded;
      final String messageId = DateTime.now().millisecondsSinceEpoch.toString();

      final MessageEntity newMessage = MessageEntity(
        id: messageId,
        text: text.trim(),
        isMe: true,
        dateTime: DateTime.now(),
      );

      final List<MessageEntity> updatedMessages = <MessageEntity>[
        ...currentState.messages,
        newMessage,
      ];

      emit(currentState.copyWith(messages: updatedMessages));
    }
  }

  void markMessagesAsRead() {
    if (state is ChatDetailsLoaded) {
      final ChatDetailsLoaded currentState = state as ChatDetailsLoaded;
      final List<MessageEntity> updatedMessages = currentState.messages.map((
        MessageEntity message,
      ) {
        if (!message.isMe && message.status != MessageStatus.read) {
          return message.copyWith(status: MessageStatus.read);
        }
        return message;
      }).toList();

      emit(currentState.copyWith(messages: updatedMessages));
    }
  }
}
