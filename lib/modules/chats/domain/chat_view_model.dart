// MessagingViewModel (optional)
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/chats/data/models/message_model.dart';
import 'package:lykluk/modules/chats/data/repository/impl/chat_repo_impl.dart';
import 'package:lykluk/modules/chats/data/repository/repo/chat_repo.dart';
import 'package:lykluk/utils/pagination/pagination.dart';

final messagingViewModelProvider =
    NotifierProvider<MessagingViewModel, AsyncValue<void>>(
      MessagingViewModel.new,
    );

class MessagingViewModel extends Notifier<AsyncValue<void>> {
  ChatRepository get _repo => ref.read(chatRepoProvider);

  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> createMessage({
    required String chatId,
    required MessageModel msg,
  }) async {
    state = const AsyncLoading();
    final res = await _repo.sendMessage(message: msg, chatId: chatId);
    state = res.fold(
      (failure) => AsyncError<Object>(failure, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final res = await _repo.getMessagingUser(userId: userId);
    return res.fold((_) => null, (r) => r.data);
  }

  Future<Map<String, dynamic>?> updateSettings(
    Map<String, dynamic> body,
  ) async {
    final res = await _repo.updateMessagingSettings(body: body);
    return res.fold((_) => null, (r) => r.data);
  }

  Future<Map<String, dynamic>?> getSettings() async {
    final res = await _repo.getMessagingSettings();
    return res.fold((_) => null, (r) => r.data);
  }

  Future<void> getActivities({int page = 0, int size = 10}) async {
    await _repo.getMessagingActivities(
      queryParameters: PaginatedRequest(page: page, limit: size),
    );
  }
}
