// ignore_for_file: public_member_api_docs, sort_constructors_first

enum MessageType { text, image, video, audio, location, sticker, file }

class MessageModel {
  final String? id;
  final String? message;
  final String? sender;
  final DateTime? time;
  final bool isRead;
  final MessageType? type;

  const MessageModel({
    this.id,
    this.message,
    this.sender,
    this.time,
    this.isRead = false,
    this.type,
  });
}
