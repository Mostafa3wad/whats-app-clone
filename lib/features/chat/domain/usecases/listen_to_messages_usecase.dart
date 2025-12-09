import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whats_app_clone/features/chat/domain/repositories/chat_repository.dart';

class ListenToMessagesUsecase {
  final ChatRepository chatRepository;

  ListenToMessagesUsecase(this.chatRepository);

  Stream<Either<Failure, MessageEntity>> call({required int chatId}) {
    return chatRepository.listenToMessages(chatId);
  }
}
