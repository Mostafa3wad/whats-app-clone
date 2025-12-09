import 'package:whats_app_clone/core/service_locator/service_locator.dart';
import 'package:whats_app_clone/features/chat/data/datasources/chat_ws_datasource.dart';
import 'package:whats_app_clone/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:whats_app_clone/features/chat/domain/repositories/chat_repository.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/connect_to_chat_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/disconnect_from_chat_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/listen_to_messages_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/start_typing_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/stop_typing_usecase.dart';
import 'package:whats_app_clone/features/chat/domain/usecases/update_message_usecase.dart';

void chatLocator() {
  // =============== Data Sources ===============
  sl.registerLazySingleton<ChatWsDataSource>(
    () => ChatWsDataSource(manager: sl(), storage: sl()),
  );

  // =============== Repositories ===============
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(wsDataSource: sl(), networkInfo: sl()),
  );

  // =============== Use Cases ===============
  sl.registerLazySingleton(() => ConnectToChatUsecase(sl()));
  sl.registerLazySingleton(() => DisconnectFromChatUsecase(sl()));
  sl.registerLazySingleton(() => ListenToMessagesUsecase(sl()));
  sl.registerLazySingleton(() => SendMessageUsecase(sl()));
  sl.registerLazySingleton(() => UpdateMessageUsecase(sl()));
  sl.registerLazySingleton(() => DeleteMessageUsecase(sl()));
  sl.registerLazySingleton(() => StartTypingUsecase(sl()));
  sl.registerLazySingleton(() => StopTypingUsecase(sl()));

  // Note: ChatDetailsCubit is registered as Factory (not Singleton)
  // because we need a new instance for each chat
  // Register it where you navigate to the chat details screen
}
