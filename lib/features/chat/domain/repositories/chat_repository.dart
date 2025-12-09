import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, Unit>> sendMessage({
    required int chatId,
    required String content,
    required String messageType,
  });

  Future<Either<Failure, Unit>> updateMessage({
    required int messageId,
    required String newContent,
  });
  
  Future<Either<Failure, Unit>> deleteMessage({required int messageId});

  Stream<Either<Failure, MessageEntity>> listenToMessages(int chatId);

  Future<Either<Failure, Unit>> connectToChat(int chatId);

  Future<Either<Failure, Unit>> disconnectFromChat(int chatId);

  Future<Either<Failure, Unit>> startTyping(int chatId);

  Future<Either<Failure, Unit>> stopTyping(int chatId);
}
