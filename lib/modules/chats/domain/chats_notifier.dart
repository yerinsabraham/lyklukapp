import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/modules/chats/data/models/chat_model.dart';
import 'package:lykluk/modules/chats/data/repository/impl/chat_repo_impl.dart';
import 'package:lykluk/modules/chats/data/repository/repo/chat_repo.dart';
import 'package:lykluk/utils/pagination/pagination.dart';

final chatsProvider =
    AsyncNotifierProvider<ChatsNotifier, PaginatedResponse<ChatModel>>(
      ChatsNotifier.new,
    );

class ChatsNotifier extends AsyncNotifier<PaginatedResponse<ChatModel>>
    with PaginationController<ChatModel> {
  late AnalyticsService analyticsService;
  late ChatRepository chatRepository;
  // late UserRepository userRepository;

  @override
  FutureOr<PaginatedResponse<ChatModel>> build() {
    // analyticsService = ref.read(analyticsServiceProvider);
    chatRepository = ref.read(chatRepoProvider);
    // userRepository = ref.read(userRepoProvider);
    onNetworkStateChanged();
    // onCacheNetworkState();
    onAuthStateChanged(canRefreshSelf: true);
    // onNewMessage();
    // onMessageUpdate();
    // onMessageEvents();
    // onConnectionRequestUpdate();
    return loadData(PaginatedRequest(limit: 20, page: 1));
  }

  @override
  FutureOr<PaginatedResponse<ChatModel>> loadData(
    PaginatedRequest request,
  ) async {
    try {
      final res = await chatRepository.chats(queryParameters: request);
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
  //   chatRepository.onMessage().listen(
  //     (data) {
  //       if (data == null) return;
  //       final chatId = data['chat']['id'];
  //       final msg = MessageModel.fromJson(data['message']);
  //       findAndUpdate(
  //           where: (m) => m.id == chatId,
  //           update: (p0) => p0.copyWith(
  //               lastMessage: msg,
  //               totalUnreadMessages: p0.totalUnreadMessages + 1));
  //     },
  //   );
  // }

  // void onMessageUpdate() {
  //   chatRepository.onMessageUpdate().listen((data) {
  //     if (data == null) return;
  //     final chatId = data['chat']['id'];
  //     findAndUpdate(
  //       where: (e) => e.id == chatId,
  //       update: (e) => e.copyWith(
  //         totalUnreadMessages: 0,
  //         lastMessage: e.lastMessage?.copyWith(
  //             delivery: e.lastMessage?.delivery
  //                 ?.copyWith(status: MessageStatus.read)),
  //       ),
  //     );
  //   });
  // }

  // onMessageEvents() {
  //   ref.listen(messageNotifierProvider, (p, n) {
  //     n.maybeWhen(
  //       orElse: () {},
  //       readAllMessage: (chatId) {
  //         findAndUpdate(
  //             where: (m0) => m0.id == chatId,
  //             update: (p0) => p0.copyWith(totalUnreadMessages: 0));
  //       },
  //     );
  //   });
  // }

  // void onConnectionRequestUpdate() {
  //   userRepository.onConnectRequest().listen(
  //     (data) {
  //       try {
  //         if (state.valueOrNull == null) {
  //           ref.invalidateSelf();
  //           return;
  //         }
  //         if (data != null && data['alert']['type'] == 'connect-request') {
  //           final req =
  //               ConnectionRequest.fromJson(data['alert']['connectRequest']);
  //           if (req.status == ConnectionStatus.accepted &&
  //               req.from.id == LocalStorage.userId) {
  //             if (data['alert']['connect'] == null) {
  //               ref.invalidateSelf();
  //               return;
  //             } else {
  //               final chat = ChatModel.fromJson(data['alert']['chat']);
  //               addTop(chat);
  //             }
  //           }
  //         }
  //       } catch (e, s) {
  //         LoggerService.logError(error: e, stackTrace: s);
  //         ref.invalidateSelf();
  //       }
  //     },
  //   );
  // }
}
