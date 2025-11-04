class ChatModel {
  final String id;
  final String name;
  final String imageUrl;
  final String lastMessage;
  final String lastMessageTime;
  final bool isGroup;

   const ChatModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isGroup,
  });
}
