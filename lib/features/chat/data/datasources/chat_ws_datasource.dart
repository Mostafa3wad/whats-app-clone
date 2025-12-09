import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/constants/paths/api_endpoints.dart';
import 'package:whats_app_clone/core/helpers/app_storage.dart';
import 'package:whats_app_clone/core/network/web_socket_service.dart';
import 'package:whats_app_clone/features/chat/data/models/message_model.dart';

class ChatWsDataSource {
  final WebSocketService manager;
  final AppStorage storage;

  ChatWsDataSource({required this.manager, required this.storage});

  Future<Unit> connectToChat(int chatId) async {
    log(chatId.toString());
    final token = await storage.getToken();
    final url = '${ApiEndpoints.wsUrl}/$chatId/?token=$token';
    manager.connect(url);
    return unit;
  }

  Future<Unit> disconnect() async {
    await manager.disconnect();
    return unit;
  }

  Stream<MessageModel> listenToMessages(int chatID) {
    return manager.stream!
        .map((event) => jsonDecode(event))
        .where((json) => json['type'] == 'chat_message')
        .map((json) => MessageModel.fromJson(json, chatID));
  }

  Future<Unit> sendCreateMessage({
    required int chatId,
    required String content,
    required String messageType,
  }) async {
    manager.send({
      'type': 'create_message',
      'content': content,
      'message_type': messageType,
    });
    return unit;
  }

  Future<Unit> sendUpdateMessage({
    required int messageId,
    required String newContent,
  }) async {
    manager.send({
      'type': 'update_message',
      'message_id': messageId,
      'new_content': newContent,
    });
    return unit;
  }

  Future<Unit> sendDeleteMessage({required int messageId}) async {
    manager.send({'type': 'delete_message', 'message_id': messageId});
    return unit;
  }

  Future<Unit> sendTyping() async {
    manager.send({'type': 'typing'});
    return unit;
  }
}
