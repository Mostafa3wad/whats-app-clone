import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/chat/domain/repositories/chat_repository.dart';

class UpdateMessageUsecase {
  final ChatRepository chatRepository;

  UpdateMessageUsecase(this.chatRepository);

  Future<Either<Failure, Unit>> call({
    required int messageId,
    required String newContent,
  }) async {
    return chatRepository.updateMessage(
      messageId: messageId,
      newContent: newContent,
    );
  }
}
