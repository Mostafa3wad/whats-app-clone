import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/chat/domain/repositories/chat_repository.dart';

class DeleteMessageUsecase {
  final ChatRepository chatRepository;

  DeleteMessageUsecase(this.chatRepository);

  Future<Either<Failure, Unit>> call({required int messageId}) async {
    return chatRepository.deleteMessage(messageId: messageId);
  }
}
