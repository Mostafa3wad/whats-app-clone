import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/chat/domain/repositories/chat_repository.dart';

class StartTypingUsecase {
  final ChatRepository chatRepository;

  StartTypingUsecase(this.chatRepository);

  Future<Either<Failure, Unit>> call({required int chatId}) {
    return chatRepository.startTyping(chatId);
  }
}
