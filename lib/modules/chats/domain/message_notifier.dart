import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/services/app_analytics.dart';
import 'package:lykluk/modules/chats/data/models/index.dart';
import 'package:lykluk/modules/chats/data/repository/impl/chat_repo_impl.dart';
import 'package:lykluk/modules/chats/data/repository/repo/chat_repo.dart';
import 'package:lykluk/utils/pagination/pagination.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:uuid/uuid.dart';

import 'state/message_state.dart';

final messagesProvider = AsyncNotifierProviderFamily<
  MessagesNotifier,
  PaginatedResponse<MessageModel>,
  String
>(MessagesNotifier.new);

final currentChatId = StateProvider<String?>((_) => null);

class MessagesNotifier
    extends FamilyAsyncNotifier<PaginatedResponse<MessageModel>, String>
    with PaginationController<MessageModel> {
  // late AnalyticsService analyticsService;
  late ChatRepository chatRepository;
  // late SocketService socketService;

  @override
  FutureOr<PaginatedResponse<MessageModel>> build(String arg) {
    // analyticsService = ref.read(analyticsServiceProvider);
    chatRepository = ref.read(chatRepoProvider);
    // socketService = ref.read(socketProvider);
    onNetworkStateChanged();
    onAuthStateChanged();
    onListen();
    // onNewMessage();
    // onMessageUpdate();
    return loadData(PaginatedRequest(limit: 20, page: 1));
  }

  @override
  FutureOr<PaginatedResponse<MessageModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await chatRepository.messages(
        queryParameters: request,
        chatId: arg,
      );
      return res.fold(
        (l) {
          return Future.error(l.message);
        },
        (r) {
          return r.data;
        },
      );
    } catch (e, s) {
      log.e(e, stackTrace: s);
      return Future.error('Something went wrong, please try again later');
    }
  }

  // void onNewMessage() {
  //   chatRepository.onMessage().listen((data) {
  //     if (data == null) return;
  //     final chatId = data['chat']['id'];
  //     final msg = MessageModel.fromJson(data['message']);
  //     if (chatId == arg) {
  //       addTop(msg);
  //       markNewMessage(msgId: msg.id, chatId: chatId);
  //     }
  //   });
  // }

  // void onMessageUpdate() {
  //   chatRepository.onMessageUpdate().listen((data) {
  //     if (data == null) return;
  //     final chatId = data['chat']['id'];
  //     if (chatId == arg) {
  //       findAndUpdate(
  //         where: (e) =>
  //             e.delivery?.status == MessageStatus.delivered &&
  //             e.sender?.id == LocalStorage.user?.id,
  //         update: (e) => e.copyWith(
  //             delivery: e.delivery?.copyWith(status: MessageStatus.read)),
  //       );
  //     }
  //   });
  // }

  // void markNewMessage({required String msgId, required String chatId}) {
  //   final currentChat = ref.read(currentChatId);
  //   if (currentChat != chatId) return;
  //   ref.read(messageNotifierProvider.notifier).markAsRead(
  //         messageId: msgId,
  //         chatId: chatId,
  //       );
  // }

  void onListen() {
    ref.listen(messageNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        sentMessage: (message, msg, chatId) {
          if (chatId != arg) return;
          addTop(msg);
        },
        // readMessage: (chatId) {
        //   if (chatId != arg) return;
        //   findAndUpdate(
        //     where: (e) =>
        //         e.delivery?.status == MessageStatus.delivered &&
        //         e.sender?.id != LocalStorage.user?.id,
        //     update: (e) => e.copyWith(
        //         delivery: e.delivery?.copyWith(status: MessageStatus.read)),
        //   );
        // },
        // readAllMessage: (chatId) {
        //   if (chatId != arg) return;
        //   findAndUpdate(
        //     where: (e) =>
        //         e.delivery?.status == MessageStatus.delivered &&
        //         e.sender?.id != LocalStorage.user?.id,
        //     update: (e) => e.copyWith(
        //         delivery: e.delivery?.copyWith(status: MessageStatus.read)),
        //   );
        // },
      );
    });
  }
}

final messageNotifierProvider = NotifierProvider<MessageNotifier, MessageState>(
  MessageNotifier.new,
);

class MessageNotifier extends Notifier<MessageState> {
  late AnalyticsService analyticsService;
  late ChatRepository chatRepository;
  @override
  MessageState build() {
    // analyticsService = ref.read(analyticsServiceProvider);
    chatRepository = ref.read(chatRepoProvider);
    return MessageState.initail();
  }

  void sendMessage({
    required String message,
    required MessageType type,
    required String userId,
    required String chatId,
  }) async {
    try {
      state = SendingMessage();
      final msg = MessageModel(
        id: Uuid().v4(),
        message: message,
        type: type,

        sender: HiveStorage.userId,
        time: DateTime.now(),
      );
      final res = await chatRepository.sendMessage(
        message: msg,
        chatId: chatId,
      );
      res.fold(
        (l) {
          log.e(l.message);
          if (l.data == null) return;
          state = SentMessage(
            message: l.message,
            msg: l.data!.data,
            chatId: chatId,
          );
        },
        (r) {
          state = SentMessage(message: r.message, msg: r.data, chatId: chatId);
        },
      );
    } catch (e) {
      log.e(e);
      state = SendingMessageFailed(message: e.toString());
    }
  }

  // /// check message sent others and mark it as read
  // void markUnreadMessages(
  //     {required String chatId, required List<MessageModel> messages}) async {
  //   log.d('mark unread messages');
  //   try {
  //     final unreads = messages
  //         .where((e) =>
  //             e.delivery?.status == MessageStatus.delivered &&
  //             e.sender?.id != LocalStorage.user?.id)
  //         .toList();
  //     if (unreads.isEmpty) return;

  //     /// socket emit
  //     final res = await chatRepository.updateMessageStatus(
  //         messageIds: unreads.map((e) => e.id).toList(), chatId: chatId);

  //     res.fold(
  //       (l) {
  //         log.e(l.message);
  //         if (l.data == null) return;
  //         state = ReadAllMessage(chatId: chatId);
  //       },
  //       (r) {
  //         state = ReadAllMessage(chatId: chatId);
  //       },
  //     );
  //   } catch (e) {
  //     log.e(e);
  //     state = ReadMessageFailed(message: e.toString());
  //   }
  // }

  // void markAsRead({required String messageId, required String chatId}) async {
  //   log.d('mark as read message id: $messageId');
  //   try {
  //     /// socket emit
  //     final res = await chatRepository
  //         .updateMessageStatus(messageIds: [messageId], chatId: chatId);

  //     res.fold(
  //       (l) {
  //         log.e(l.message);
  //         if (l.data == null) return;
  //         state = ReadMessage(chatId: chatId);
  //       },
  //       (r) {
  //         state = ReadMessage(chatId: chatId);
  //       },
  //     );
  //   } catch (e) {
  //     log.e(e);
  //     state = ReadMessageFailed(message: e.toString());
  //   }
  // }
}
