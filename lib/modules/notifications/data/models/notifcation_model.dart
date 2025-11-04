import 'package:lykluk/utils/assets_manager.dart';

enum NotificationType { none, request, comment, suggestion }

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final NotificationType type;
  final String? image;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.type,
    this.image,
  });
}

final List<NotificationModel> demoNotifications = [
  NotificationModel(
    id: '1',
    title: 'New request',
    description: 'You have a new request from user1',
    createdAt: DateTime.now(),
    type: NotificationType.request,
  ),
  NotificationModel(
    id: '2',
    title: 'Culture Couture 🌻',
    description: 'Posted a video you might like: Honoured to witness the live ...',
    createdAt: DateTime.now(),
    type: NotificationType.comment,
    image: ImageAssets.post4mage
  ),
  NotificationModel(
    id: '3',
    title: 'New suggestion',
    description: 'User3 suggested a new feature',
    createdAt: DateTime.now(),
    type: NotificationType.suggestion,
  ),
  NotificationModel(
    id: '4',
    title: 'New suggestion',
    description: 'User3 suggested a new feature',
    createdAt: DateTime.now(),
    type: NotificationType.suggestion,
  ),
  NotificationModel(
    id: '5',
    title: 'New suggestion',
    description: 'User3 suggested a new feature',
    createdAt: DateTime.now(),
    type: NotificationType.suggestion,
  ),
  NotificationModel(
    id: '6',
    title: 'New suggestion',
    description: 'User3 suggested a new feature',
    createdAt: DateTime.now(),
    type: NotificationType.suggestion,
  ),


];
