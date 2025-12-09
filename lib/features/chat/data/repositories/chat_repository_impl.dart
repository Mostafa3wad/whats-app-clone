import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/core/network/network_info.dart';
import 'package:whats_app_clone/features/chat/data/datasources/chat_ws_datasource.dart';
import 'package:whats_app_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whats_app_clone/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatWsDataSource wsDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({required this.wsDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> connectToChat(int chatId) async {
    if (!await networkInfo.isConnected) {
      return const Left(ServerFailure());
    }
    try {
      final result = await wsDataSource.connectToChat(chatId);
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMessage({required int messageId}) async {
    if (!await networkInfo.isConnected) {
      return const Left(ServerFailure());
    }
    try {
      final result = await wsDataSource.sendDeleteMessage(messageId: messageId);
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> disconnectFromChat(int chatId) async {
    if (!await networkInfo.isConnected) {
      return const Left(ServerFailure());
    }
    try {
      final result = await wsDataSource.disconnect();
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, MessageEntity>> listenToMessages(int chatId) async* {
    if (!await networkInfo.isConnected) {
      yield const Left(ServerFailure());
      return;
    }
    try {
      // yield* wsDataSource
      //     .listenToMessages(chatId)
      //     .map((message) => Right(message));
      yield* wsDataSource.listenToMessages(chatId).map(Right.new);
    } on Exception catch (e) {
      yield Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage({
    required int chatId,
    required String content,
    required String messageType,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(ServerFailure());
    }
    try {
      final result = await wsDataSource.sendCreateMessage(
        chatId: chatId,
        content: content,
        messageType: messageType,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> startTyping(int chatId) async {
    if (!await networkInfo.isConnected) {
      return const Left(ServerFailure());
    }
    try {
      final result = await wsDataSource.sendTyping();
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> stopTyping(int chatId) async {
    if (!await networkInfo.isConnected) {
      return const Left(ServerFailure());
    }
    try {
      final result = await wsDataSource.sendTyping();
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateMessage({
    required int messageId,
    required String newContent,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(ServerFailure());
    }
    try {
      final result = await wsDataSource.sendUpdateMessage(
        messageId: messageId,
        newContent: newContent,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
