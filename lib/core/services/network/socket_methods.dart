import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/services/network/socket_io_manager.dart';

class SocketMethods {
  final _socketClient = SocketIOManager.instance.socket!;

  void emitTyping({
    required String chatId,
    required String firstName,
    required String userName,
    required bool isTyping,
  }) {
    _socketClient.emit('typing', {
      'conversationId': chatId,
      'firstName': firstName,
      'userName': userName,
      'isTyping': isTyping,
    });
    log.d('Typing event emited: $isTyping');
  }

  void emitMessage({
    required String message,
    required String media,
    required String conversation,
    required String senderFirstName,
    String? recipient,
    String? replyTo,
  }) {
    _socketClient.emit('send_message', {
      'message': message,
      'media': media,
      'conversation': conversation,
      'senderFirstName': senderFirstName,
      'recipient': recipient,
      'replyTo': replyTo,
    });
    log.d('Message event emited: $message');
  }
}
