import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whats_app_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/connect_to_chat_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/disconnect_from_chat_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/listen_to_messages_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/update_message_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/start_typing_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/stop_typing_usecase.dart';

part 'chat_details_state.dart';

class ChatDetailsCubit extends Cubit<ChatDetailsState> {
  final int chatId;
  final String contactName;
  final ConnectToChatUsecase connectToChatUsecase;
  final DisconnectFromChatUsecase disconnectFromChatUsecase;
  final ListenToMessagesUsecase listenToMessagesUsecase;
  final SendMessageUsecase sendMessageUsecase;
  final UpdateMessageUsecase updateMessageUsecase;
  final DeleteMessageUsecase deleteMessageUsecase;
  final StartTypingUsecase startTypingUsecase;
  final StopTypingUsecase stopTypingUsecase;

  StreamSubscription<void>? _messageSubscription;

  ChatDetailsCubit({
    required this.chatId,
    required this.contactName,
    required this.connectToChatUsecase,
    required this.disconnectFromChatUsecase,
    required this.listenToMessagesUsecase,
    required this.sendMessageUsecase,
    required this.updateMessageUsecase,
    required this.deleteMessageUsecase,
    required this.startTypingUsecase,
    required this.stopTypingUsecase,
  }) : super(ChatDetailsInitial()) {
    _initialize();
  }

  Future<void> _initialize() async {
    emit(ChatDetailsLoading());

    // Connect to chat WebSocket
    final connectResult = await connectToChatUsecase(chatId: chatId);

    connectResult.fold(
      (failure) {
        emit(ChatDetailsError(message: failure.message!));
      },
      (_) {
        // Start listening to messages
        _listenToMessages();
        emit(const ChatDetailsLoaded(messages: [], isOnline: false));
      },
    );
  }

  void _listenToMessages() {
    _messageSubscription = listenToMessagesUsecase(chatId: chatId).listen(
      (either) {
        either.fold(
          (failure) {
            // Handle error - could show a snackbar or update state
            if (state is ChatDetailsLoaded) {
              final currentState = state as ChatDetailsLoaded;
              emit(currentState.copyWith(errorMessage: failure.message));
            }
          },
          (message) {
            if (state is ChatDetailsLoaded) {
              final currentState = state as ChatDetailsLoaded;

              // Check if message already exists (to avoid duplicates)
              final messageExists = currentState.messages.any(
                (m) => m.id == message.id,
              );

              if (!messageExists) {
                final updatedMessages = [...currentState.messages, message];
                emit(
                  currentState.copyWith(
                    messages: updatedMessages,
                    errorMessage: null,
                  ),
                );
              } else {
                // Update existing message (for status updates, edits, etc.)
                final updatedMessages = currentState.messages.map((m) {
                  return m.id == message.id ? message : m;
                }).toList();

                emit(
                  currentState.copyWith(
                    messages: updatedMessages,
                    errorMessage: null,
                  ),
                );
              }
            }
          },
        );
      },
      onError: (error) {
        if (state is ChatDetailsLoaded) {
          final currentState = state as ChatDetailsLoaded;
          emit(
            currentState.copyWith(
              errorMessage: 'Connection error: ${error.toString()}',
            ),
          );
        }
      },
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) {
      return;
    }

    if (state is! ChatDetailsLoaded) {
      return;
    }

    final currentState = state as ChatDetailsLoaded;

    // Create optimistic message with temporary ID
    final tempId = -DateTime.now().millisecondsSinceEpoch;
    final optimisticMessage = MessageEntity(
      id: tempId,
      chatId: chatId,
      senderId: 0, // Current user ID - should be from auth
      content: text.trim(),
      messageType: 'text',
      timestamp: DateTime.now(),
      isMine: true,
      status: MessageStatus.sending,
    );

    // Add optimistic message to UI immediately
    final updatedMessages = [...currentState.messages, optimisticMessage];
    emit(currentState.copyWith(messages: updatedMessages));

    // Send message to server
    final result = await sendMessageUsecase(
      chatId: chatId,
      content: text.trim(),
      messageType: 'text',
    );

    result.fold(
      (failure) {
        // Mark message as failed
        final failedMessages = updatedMessages.map((m) {
          if (m.id == tempId) {
            return m.copyWith(status: MessageStatus.failed);
          }
          return m;
        }).toList();

        emit(
          currentState.copyWith(
            messages: failedMessages,
            errorMessage: 'Failed to send message: ${failure.message}',
          ),
        );
      },
      (_) {
        // Message sent successfully
        // The real message will come through the WebSocket stream
        // We'll keep the optimistic message until the real one arrives
        final sentMessages = updatedMessages.map((m) {
          if (m.id == tempId) {
            return m.copyWith(status: MessageStatus.sent);
          }
          return m;
        }).toList();

        emit(currentState.copyWith(messages: sentMessages, errorMessage: null));
      },
    );
  }

  Future<void> updateMessage({
    required int messageId,
    required String newContent,
  }) async {
    if (state is! ChatDetailsLoaded) {
      return;
    }

    final currentState = state as ChatDetailsLoaded;

    // Optimistically update the message
    final updatedMessages = currentState.messages.map((m) {
      if (m.id == messageId) {
        return m.copyWith(content: newContent);
      }
      return m;
    }).toList();

    emit(currentState.copyWith(messages: updatedMessages));

    // Send update to server
    final result = await updateMessageUsecase(
      messageId: messageId,
      newContent: newContent,
    );

    result.fold(
      (failure) {
        // Revert on failure
        emit(
          currentState.copyWith(
            errorMessage: 'Failed to update message: ${failure.message}',
          ),
        );
      },
      (_) {
        // Success - the updated message will come through WebSocket
        emit(currentState.copyWith(errorMessage: null));
      },
    );
  }

  Future<void> deleteMessage(int messageId) async {
    if (state is! ChatDetailsLoaded) {
      return;
    }

    final currentState = state as ChatDetailsLoaded;

    // Optimistically remove the message
    final originalMessages = currentState.messages;
    final updatedMessages = currentState.messages
        .where((m) => m.id != messageId)
        .toList();

    emit(currentState.copyWith(messages: updatedMessages));

    // Send delete to server
    final result = await deleteMessageUsecase(messageId: messageId);

    result.fold(
      (failure) {
        // Revert on failure
        emit(
          currentState.copyWith(
            messages: originalMessages,
            errorMessage: 'Failed to delete message: ${failure.message}',
          ),
        );
      },
      (_) {
        // Success
        emit(currentState.copyWith(errorMessage: null));
      },
    );
  }

  Future<void> startTyping() async {
    await startTypingUsecase(chatId: chatId);
  }

  Future<void> stopTyping() async {
    await stopTypingUsecase(chatId: chatId);
  }

  void markMessagesAsRead() {
    if (state is! ChatDetailsLoaded) {
      return;
    }

    final currentState = state as ChatDetailsLoaded;
    final updatedMessages = currentState.messages.map((message) {
      if (!message.isMine && message.status != MessageStatus.read) {
        return message.copyWith(status: MessageStatus.read);
      }
      return message;
    }).toList();

    emit(currentState.copyWith(messages: updatedMessages));
  }

  void clearError() {
    if (state is ChatDetailsLoaded) {
      final currentState = state as ChatDetailsLoaded;
      emit(currentState.copyWith(errorMessage: null));
    }
  }

  @override
  Future<void> close() async {
    // Cancel message subscription
    await _messageSubscription?.cancel();

    // Disconnect from chat
    await disconnectFromChatUsecase(chatId: chatId);

    return super.close();
  }
}
