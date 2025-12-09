import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUsecase {
  final ChatRepository repository;

  SendMessageUsecase(this.repository);

  Future<Either<Failure, Unit>> call({
    required int chatId,
    required String content,
    required String messageType,
  }) {
    return repository.sendMessage(
      chatId: chatId,
      content: content,
      messageType: messageType,
    );
  }
}
