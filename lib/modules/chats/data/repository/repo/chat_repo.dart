import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/chats/data/models/chat_model.dart';
import 'package:lykluk/modules/chats/data/models/message_model.dart';
import 'package:lykluk/utils/pagination/pagination.dart';

/// Minimal activity model (for "Get Activities")
class MessageActivity {
  final String id;
  final String type; // e.g. "message", "mention", "like"
  final String summary;
  final DateTime createdAt;

  const MessageActivity({
    required this.id,
    required this.type,
    required this.summary,
    required this.createdAt,
  });
}

abstract class ChatRepository {
  /// fetch chat conversations
  FutureResponse<PaginatedResponse<ChatModel>> chats({
    required PaginatedRequest queryParameters,
  });

  /// fetch unread chat conversations
  FutureResponse<PaginatedResponse<ChatModel>> unreadChats({
    required PaginatedRequest queryParameters,
  });

  /// fetch frequently conversations
  FutureResponse<PaginatedResponse<ChatModel>> frequentchats({
    required PaginatedRequest queryParameters,
  });

  /// fetch chats messages
  FutureResponse<PaginatedResponse<MessageModel>> messages({
    required PaginatedRequest queryParameters,
    required String chatId,
  });

  /// POST Create (send a message)
  FutureResponse<MessageModel> sendMessage({
    required MessageModel message,
    required String chatId,
  });

  /// DELETE message
  FutureResponse<void> deleteMessage({
    required String messageId,
    required String chatId,
  });

  /// GET Get User (messaging user profile/minimal)
  FutureResponse<Map<String, dynamic>> getMessagingUser({
    required String userId,
  });

  /// PUT Update Settings (messaging-specific settings)
  FutureResponse<Map<String, dynamic>> updateMessagingSettings({
    required Map<String, dynamic> body,
  });

  /// GET Get settings (messaging-specific settings)
  FutureResponse<Map<String, dynamic>> getMessagingSettings();

  /// GET Get Activities (messaging feed/activities)
  FutureResponse<PaginatedResponse<MessageActivity>> getMessagingActivities({
    required PaginatedRequest queryParameters,
  });
}
