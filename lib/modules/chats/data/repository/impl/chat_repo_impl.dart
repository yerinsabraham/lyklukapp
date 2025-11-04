import 'package:fpdart/fpdart.dart';
import 'package:lykluk/core/shared/resources/failure.dart';
import 'package:lykluk/core/shared/resources/response_data.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/chats/data/models/chat_model.dart';
import 'package:lykluk/modules/chats/data/models/message_model.dart';
import 'package:lykluk/modules/chats/data/repository/repo/chat_repo.dart';
import 'package:lykluk/utils/pagination/pagination.dart';
import 'package:riverpod/riverpod.dart';

final chatRepoProvider = Provider<ChatRepository>((ref) => ChatRepoImpl());

class ChatRepoImpl implements ChatRepository {
  // ─── Conversations ────────────────────────────────────────────────────────
  @override
  FutureResponse<PaginatedResponse<ChatModel>> chats({
    required PaginatedRequest queryParameters,
  }) async {
    try {
      final result = PaginatedResponse<ChatModel>(
        dataList: _sampleChats,
        limit: queryParameters.limit ?? 10,
        page: queryParameters.page ?? 0,
        pages: 1,
        total: _sampleChats.length,
        fieldName: 'chats',
      );
      return Right(ResponseData(data: result, message: 'Fetched chats'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureResponse<PaginatedResponse<ChatModel>> unreadChats({
    required PaginatedRequest queryParameters,
  }) async {
    try {
      // final unread =
      // _sampleChats.where((c) => (c.unreadCount ?? 0) > 0).toList();
      final result = PaginatedResponse<ChatModel>(
        dataList: [], //unread,
           limit: queryParameters.limit ?? 10,
        page: queryParameters.page ?? 0,
        total: queryParameters.total,
        pages: queryParameters.pages ?? 0,
        fieldName: 'chats',
      );
      return Right(ResponseData(data: result, message: 'Fetched unread chats'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureResponse<PaginatedResponse<ChatModel>> frequentchats({
    required PaginatedRequest queryParameters,
  }) async {
    try {
      final frequent = _sampleChats.take(3).toList();
      final result = PaginatedResponse<ChatModel>(
        dataList: frequent,
        limit: queryParameters.limit ?? 10,
        page: queryParameters.page ?? 0,
        total: queryParameters.total,
        pages: queryParameters.pages?? 0,
        fieldName: 'chats',
      );
      return Right(
        ResponseData(data: result, message: 'Fetched frequent chats'),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // ─── Messages ─────────────────────────────────────────────────────────────
  @override
  FutureResponse<PaginatedResponse<MessageModel>> messages({
    required PaginatedRequest queryParameters,
    required String chatId,
  }) async {
    try {
      final result = PaginatedResponse<MessageModel>(
        dataList: _msgs,
            limit: queryParameters.limit ?? 10,
        page: queryParameters.page ?? 0,
        total: queryParameters.total,
        pages: queryParameters.pages ?? 0,
       
        fieldName: 'messages',
      );
      return Right(
        ResponseData(data: result, message: 'Successfully fetched messages'),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureResponse<MessageModel> sendMessage({
    required MessageModel message,
    required String chatId,
  }) async {
    try {
      // final withId = message.id(
      //   id:
      //       message.id.isNotEmpty == true
      //           ? message.id
      //           : DateTime.now().millisecondsSinceEpoch.toString(),
      //   time: message.time,
      // );
      final withId = MessageModel(id: message.id, time: message.time);
      _msgs.insert(0, withId);
      return Right(
        ResponseData(data: withId, message: 'Successfully sent message'),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureResponse<void> deleteMessage({
    required String messageId,
    required String chatId,
  }) async {
    try {
      _msgs.removeWhere((m) => m.id == messageId);
      return Right(ResponseData(data: null, message: 'Message deleted'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  // ─── Messaging: Get User / Settings / Activities ──────────────────────────
  @override
  FutureResponse<Map<String, dynamic>> getMessagingUser({
    required String userId,
  }) async {
    try {
      final user = {
        'id': userId,
        'username': '@$userId',
        'displayName': 'User $userId',
        'avatar': 'default/profile/default2.jpeg',
        'verified': false,
      };
      return Right(ResponseData(data: user, message: 'User retrieved'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureResponse<Map<String, dynamic>> updateMessagingSettings({
    required Map<String, dynamic> body,
  }) async {
    try {
      _settings = {..._settings, ...body};
      return Right(ResponseData(data: _settings, message: 'Settings updated'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureResponse<Map<String, dynamic>> getMessagingSettings() async {
    try {
      return Right(
        ResponseData(data: _settings, message: 'Settings retrieved'),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  FutureResponse<PaginatedResponse<MessageActivity>> getMessagingActivities({
    required PaginatedRequest queryParameters,
  }) async {
    try {
      final result = PaginatedResponse<MessageActivity>(
        dataList: _activities,
           limit: queryParameters.limit ?? 10,
        page: queryParameters.page ?? 0,
        total: queryParameters.total,
        pages: queryParameters.pages ?? 0,
        fieldName: 'activities',
      );
      return Right(ResponseData(data: result, message: 'Activities retrieved'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

// ─── Mock Data ───────────────────────────────────────────────────────────────
final _msgs = <MessageModel>[
  MessageModel(
    id: '7736363635252',
    message: 'Hi there, Really nice being your mutuals',
    sender: 'sedee',
    time: DateTime.now(),
    type: MessageType.text,
  ),
];

final _sampleChats = <ChatModel>[
  // ChatModel(
  //   id: 'chat-1',
  //   lastMessage: 'Hey!',
  //   title: 'Alice',
  //   unreadCount: 2,
  //   updatedAt: DateTime.now(),
  // ),
  // ChatModel(
  //   id: 'chat-2',
  //   lastMessage: 'Let’s meet tomorrow',
  //   title: 'Bob',
  //   unreadCount: 0,
  //   updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
  // ),
];

Map<String, dynamic> _settings = <String, dynamic>{
  'notifications': true,
  'readReceipts': true,
  'typingIndicators': true,
};

final _activities = <MessageActivity>[
  MessageActivity(
    id: 'a1',
    type: 'message',
    summary: 'You received a new message from @alice',
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  MessageActivity(
    id: 'a2',
    type: 'mention',
    summary: '@bob mentioned you in #general',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
];
