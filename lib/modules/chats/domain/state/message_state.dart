import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lykluk/modules/chats/data/models/index.dart';

part 'message_state.freezed.dart';

@freezed
class MessageState with _$MessageState {
  const factory MessageState.initail() = MessageInitial;
  const factory MessageState.sendingMessage() = SendingMessage;
  const factory MessageState.sentMessage({
    required String message,
    required MessageModel msg,
    required String chatId,
  }) = SentMessage;
  const factory MessageState.sendingMessageFailed({required String message}) =
      SendingMessageFailed;

  /// mark all message read
  const factory MessageState.readMessage({required String chatId}) =
      ReadMessage;
  const factory MessageState.readAllMessage({required String chatId}) =
      ReadAllMessage;
  const factory MessageState.readMessageFailed({required String message}) =
      ReadMessageFailed;
}
