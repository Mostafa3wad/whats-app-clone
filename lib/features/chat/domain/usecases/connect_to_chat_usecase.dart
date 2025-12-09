import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/chat/domain/repositories/chat_repository.dart';

class ConnectToChatUsecase {
  final ChatRepository chatRepository;

  ConnectToChatUsecase(this.chatRepository);

  Future<Either<Failure, Unit>> call({required int chatId}) {
    return chatRepository.connectToChat(chatId);
  }
}
