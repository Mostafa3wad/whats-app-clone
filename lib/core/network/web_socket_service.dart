import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:whats_app_clone/core/helpers/app_storage.dart';
import 'package:whats_app_clone/core/logging/app_logger.dart';

enum WebSocketStatus { disconnected, connecting, connected, error }

class WebSocketService {
  final AppStorage storage;
  final AppLogger _logger;

  WebSocketService({required this.storage}) : _logger = AppLogger();

  WebSocketChannel? _channel;
  WebSocketStatus _status = WebSocketStatus.disconnected;
  StreamSubscription? _streamSubscription;

  Stream<dynamic>? get stream => _channel?.stream;
  WebSocketStatus get status => _status;
  bool get isConnected => _status == WebSocketStatus.connected;

  Future<void> connect(String url) async {
    try {
      // If already connected, disconnect first
      if (_status == WebSocketStatus.connected ||
          _status == WebSocketStatus.connecting) {
        _logger.warning(
          '⚠️ WebSocket already connected/connecting. Disconnecting first...',
        );
        await disconnect();
      }

      _status = WebSocketStatus.connecting;
      _logger.info('🔄 Connecting to WebSocket...');
      _logger.info('📍 Full URL: $url');

      final token = await storage.getToken();

      if (token == null || token.isEmpty) {
        _logger.error(
          '❌ No token found. Cannot connect to WebSocket.',
          null,
          null,
        );
        _status = WebSocketStatus.error;
        return;
      }

      // Establish WebSocket connection (token is in URL query parameter)
      _channel = IOWebSocketChannel.connect(Uri.parse(url));

      // Listen to messages and events
      _streamSubscription = _channel?.stream.listen(
        (message) {
          // Successfully connected when first message is received
          if (_status != WebSocketStatus.connected) {
            _status = WebSocketStatus.connected;
            _logger.warning('✅ WebSocket connected successfully!');
          }
          _logger.info('📨 Received message: $message');
        },
        onError: (error) {
          _status = WebSocketStatus.error;
          _logger.error(
            '❌ WebSocket error occurred',
            error,
            StackTrace.current,
          );
        },
        onDone: () {
          _status = WebSocketStatus.disconnected;
          _logger.warning('⚠️ WebSocket connection closed');
        },
        cancelOnError: false,
      );

      // Small delay to ensure connection is established
      await Future.delayed(const Duration(milliseconds: 500));

      if (_status == WebSocketStatus.connecting) {
        _status = WebSocketStatus.connected;
        _logger.info('✅ WebSocket connection established');
      }
    } catch (error, stackTrace) {
      _status = WebSocketStatus.error;
      _logger.error('❌ Failed to connect to WebSocket', error, stackTrace);
      rethrow;
    }
  }

  void send(Map<String, dynamic> data) {
    if (_status != WebSocketStatus.connected) {
      _logger.warning(
        '⚠️ Cannot send message. WebSocket is not connected. Status: $_status',
      );
      return;
    }

    try {
      final jsonData = jsonEncode(data);
      _logger.info('📤 Sending message: $data');
      _channel?.sink.add(jsonData);
    } catch (error, stackTrace) {
      _logger.error('❌ Failed to send message', error, stackTrace);
    }
  }

  Future<void> disconnect() async {
    try {
      _logger.info('🔌 Disconnecting from WebSocket...');

      await _streamSubscription?.cancel();
      _streamSubscription = null;

      await _channel?.sink.close(1001); // 1001 = going away
      _channel = null;

      _status = WebSocketStatus.disconnected;
      _logger.info('✅ WebSocket disconnected successfully');
    } catch (error, stackTrace) {
      _logger.error('❌ Error during WebSocket disconnect', error, stackTrace);
      _status = WebSocketStatus.error;
    }
  }

  /// Reconnect to the WebSocket
  Future<void> reconnect(String url) async {
    _logger.info('🔄 Reconnecting to WebSocket...');
    await disconnect();
    await Future.delayed(const Duration(seconds: 1));
    await connect(url);
  }
}
