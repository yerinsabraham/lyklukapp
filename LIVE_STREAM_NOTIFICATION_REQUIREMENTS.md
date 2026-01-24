# Live Stream "Go Live" Notification System

## Overview

When a user starts a live stream, all their followers should be notified via:
1. **Push Notification** - Even when app is closed/backgrounded
2. **In-App Notification** - Shows in the notifications tab
3. **Optional: Real-time banner** - Shows on home/feed screen (like Instagram)

---

## Current Frontend Implementation Status

### ✅ Already Implemented

1. **Push Notification Handling** (`firebase_messaging_service.dart`)
   - `LIVE_STREAM_STARTED` notification type is already recognized
   - Navigation to live stream on tap is implemented
   ```dart
   case 'LIVE_STREAM_STARTED':
     if (streamId != null) {
       // Navigate to live stream screen
       dev.log('🎥 Navigate to live stream: $streamId');
     }
     break;
   ```

2. **In-App Notification Navigation** (`notification_navigation.dart`)
   - `live_stream_started` type is handled
   - Navigates to `Routes.liveStreamViewerRoute` with `streamId`
   ```dart
   case 'live_stream_started':
     if (metadata?['streamId'] != null) {
       _navigateToLiveStream(context, metadata?['streamId']!);
     }
     break;
   ```

3. **Live Stream Viewer Route** exists and works

### ❌ Not Yet Implemented (Frontend)

1. **Real-time "Go Live" banner on feed** (optional Instagram-style)
2. **Live stream indicator on profile pictures** (optional)

---

## Backend Implementation Required

### 1. Trigger Notification on Stream Start

When the `POST /live-streams/{streamId}/start` endpoint is called:

```
Backend Flow:
1. Update stream status to LIVE
2. Get all followers of the broadcaster (userId)
3. For each follower:
   a. Send Push Notification via FCM
   b. Create In-App Notification record
4. Return stream data to broadcaster
```

### 2. Push Notification Payload

The backend should send FCM notifications with this structure:

```json
{
  "to": "<follower_fcm_token>",
  "notification": {
    "title": "🔴 @username is now LIVE!",
    "body": "Stream title here - Tap to watch",
    "image": "https://cdn.lykluk.com/profile/avatar.jpg"
  },
  "data": {
    "notificationType": "LIVE_STREAM_STARTED",
    "streamId": "stream-uuid-here",
    "userId": "broadcaster-username",
    "title": "Stream Title",
    "thumbnailUrl": "https://cdn.lykluk.com/thumbnails/stream.jpg"
  },
  "android": {
    "priority": "high",
    "notification": {
      "channel_id": "live_streams",
      "sound": "default",
      "priority": "high"
    }
  },
  "apns": {
    "payload": {
      "aps": {
        "sound": "default",
        "badge": 1,
        "content-available": 1
      }
    }
  }
}
```

### 3. In-App Notification Record

Create notification record in database:

```json
{
  "id": "notification-uuid",
  "recipientId": "follower-user-id",
  "actorId": "broadcaster-user-id",
  "type": "live_stream_started",
  "title": "@username started a live video",
  "message": "Stream title here",
  "data": {
    "metadata": {
      "streamId": "stream-uuid",
      "thumbnailUrl": "https://cdn.lykluk.com/thumbnails/stream.jpg"
    }
  },
  "read": false,
  "createdAt": "2026-01-24T10:00:00.000Z"
}
```

### 4. API Endpoint Summary

| Endpoint | Action | Notification Trigger |
|----------|--------|---------------------|
| `POST /live-streams/{id}/start` | Start stream | ✅ Send to all followers |
| `POST /live-streams/{id}/end` | End stream | Optional: Send "stream ended" |
| `POST /live-streams` | Create stream | ❌ No notification (not live yet) |

---

## Implementation Steps

### Backend (Required)

1. **Modify `/live-streams/{id}/start` endpoint**:
   ```javascript
   async function startStream(streamId, userId) {
     // 1. Update stream status
     await db.liveStreams.update(streamId, { status: 'LIVE' });
     
     // 2. Get broadcaster info
     const broadcaster = await db.users.findById(userId);
     
     // 3. Get all followers
     const followers = await db.followers.findByUserId(userId);
     
     // 4. Send notifications (async, don't block response)
     sendLiveNotifications(broadcaster, streamId, followers);
     
     // 5. Return stream data
     return stream;
   }
   
   async function sendLiveNotifications(broadcaster, streamId, followers) {
     const notifications = followers.map(follower => ({
       token: follower.fcmToken,
       notification: {
         title: `🔴 @${broadcaster.username} is now LIVE!`,
         body: stream.title || 'Tap to watch',
       },
       data: {
         notificationType: 'LIVE_STREAM_STARTED',
         streamId: streamId,
         userId: broadcaster.username,
       }
     }));
     
     // Batch send via FCM
     await admin.messaging().sendEach(notifications);
     
     // Create in-app notification records
     await db.notifications.insertMany(
       followers.map(f => ({
         recipientId: f.id,
         actorId: broadcaster.id,
         type: 'live_stream_started',
         data: { metadata: { streamId } }
       }))
     );
   }
   ```

2. **Consider rate limiting / batching** for users with many followers

3. **Add notification preferences** (optional):
   - Let users opt-out of live notifications
   - Notification settings: `notify_live_streams: true/false`

### Frontend (Optional Enhancements)

1. **Add "Go Live" banner on feed** (like Instagram):
   ```dart
   // In feed screen, listen for WebSocket event
   wsService.onStreamStarted((data) {
     // Show banner at top of feed
     showLiveBanner(context, data);
   });
   ```

2. **Add live indicator ring around profile pictures**:
   ```dart
   // Check if user is live when showing profile avatar
   if (user.isLive) {
     // Show gradient ring around avatar
   }
   ```

---

## Testing Checklist

- [ ] User A follows User B
- [ ] User B starts a live stream
- [ ] User A receives push notification (app backgrounded)
- [ ] User A receives in-app notification (in notifications tab)
- [ ] Tapping notification navigates to live stream
- [ ] User A can watch User B's stream
- [ ] Multiple followers all receive notifications
- [ ] Notifications have correct content (username, title, thumbnail)

---

## Performance Considerations

1. **Async Processing**: Don't block the `/start` endpoint waiting for notifications
2. **Batching**: FCM allows sending to 500 devices per batch
3. **Queue System**: For users with 10k+ followers, use a message queue (Redis/SQS)
4. **Rate Limiting**: Prevent spam if user rapidly starts/stops streams

---

## Summary

| Component | Status | Owner |
|-----------|--------|-------|
| Push notification handling | ✅ Ready | Frontend |
| In-app notification navigation | ✅ Ready | Frontend |
| Live stream viewer screen | ✅ Ready | Frontend |
| Send notifications on stream start | ❌ Needed | **Backend** |
| Create in-app notification records | ❌ Needed | **Backend** |
| Get followers for broadcaster | ❌ Needed | **Backend** |
| FCM batch sending | ❌ Needed | **Backend** |

**The frontend is ready.** The backend needs to:
1. Trigger FCM notifications when a stream starts
2. Create in-app notification records for followers
3. Include proper `notificationType: "LIVE_STREAM_STARTED"` and `streamId` in the payload
