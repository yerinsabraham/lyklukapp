# Backend Event Implementation Requirements

## 📋 Overview

This document specifies the additional event types that backend needs to implement beyond traditional notifications.

---

## 🎯 Event Categories

### 1. Traditional Notifications (Already Implemented ✅)
- `profile_followed`
- `video_comment`
- `video_like`
- `follow_request`
- `live_stream_started`
- etc.

### 2. Wallet Events (NEW - To Implement 🚧)
- `points_earned`
- `points_deducted`
- `wallet_update`

### 3. Message Events (NEW - To Implement 🚧)
- `message_preview`
- `message_received`
- `typing_indicator`

---

## 💰 Wallet Events Specification

### Event: `points_earned`

**When to Send:**

**For Viewers (requires 100+ following):**
- User likes a video → +1 LykCoin
- User views a video → +1 LykCoin
- User shares a video → +2 LykCoins
- User comments on a video → +2 LykCoins

**For Content Creators (requires 1000+ followers):**
- Video receives 1 like → +1 LykCoin (1000 likes = 1000 LykCoins)
- Video receives 1 view → +0.1 LykCoin (1000 views = 100 LykCoins)
- Video receives 1 share → +1 LykCoin (1000 shares = 1000 LykCoins)
- User uploads a video → +5 LykCoins (1000 uploads = 5000 LykCoins)

**Important Eligibility Rules:**
- **Viewers**: Must have 100+ following to earn LykCoins
- **Creators**: Must have 1000+ followers to earn LykCoins
- Backend must check eligibility before awarding points

**Payload Structure:**

**Example 1: Viewer likes video** (viewer has 100+ following)
```json
{
  "type": "points_earned",
  "eventType": "wallet:points:earned",
  "recipientIds": [123],
  "data": {
    "userId": 123,
    "action": "video_liked",
    "points": 1,
    "newBalance": 150,
    "previousBalance": 149,
    "reason": "Liked a video",
    "timestamp": "2025-12-23T12:00:00Z",
    "metadata": {
      "videoId": "456",
      "videoTitle": "Amazing Dance",
      "userType": "viewer"
    }
  }
}
```

**Example 2: Creator's video gets 1000 views** (creator has 1000+ followers)
```json
{
  "type": "points_earned",
  "eventType": "wallet:points:earned",
  "recipientIds": [789],
  "data": {
    "userId": 789,
    "action": "view_received",
    "points": 100,
    "newBalance": 5250,
    "previousBalance": 5150,
    "reason": "Your video received 1000 views",
    "timestamp": "2025-12-23T12:00:00Z",
    "metadata": {
      "videoId": "456",
      "videoTitle": "Amazing Dance",
      "totalViews": 1000,
      "userType": "creator"
    }
  }
}
```

**Fields:**
- `type`: Always `"points_earned"`
- `eventType`: Always `"wallet:points:earned"`
- `recipientIds`: Array with userId who earned points
- `data.userId`: User who earned points
- `data.action`: Action that triggered points (enum below)
- `data.points`: Number of points earned (can be decimal)
- `data.newBalance`: User's new wallet balance
- `data.previousBalance`: User's previous balance
- `data.reason`: Human-readable reason
- `data.timestamp`: When points were earned
- `data.metadata`: Optional additional context

**Action Types (Enum):**
```typescript
type PointsAction = 
  // Viewer actions (requires 100+ following)
  | "video_liked"           // +1 LykCoin
  | "video_viewed"          // +1 LykCoin
  | "video_shared"          // +2 LykCoins
  | "comment_posted"        // +2 LykCoins
  
  // Creator actions (requires 1000+ followers)
  | "video_uploaded"        // +5 LykCoins
  | "like_received"         // +1 LykCoin (per like)
  | "view_received"         // +0.1 LykCoin (per view)
  | "share_received";       // +1 LykCoin (per share)
```

---

### Event: `points_deducted`

**When to Send:**
- User purchases premium feature
- User withdraws LYKS
- User gets penalty for violation
- User gifts LYKS to another user

**Payload Structure:**
```json
{
  "type": "points_deducted",
  "eventType": "wallet:points:deducted",
  "recipientIds": [123],
  "data": {
    "userId": 123,
    "action": "purchase",
    "points": 50,
    "newBalance": 100,
    "previousBalance": 150,
    "reason": "Purchased premium badge",
    "timestamp": "2025-12-23T12:00:00Z",
    "metadata": {
      "itemId": "badge_premium",
      "itemName": "Premium Badge"
    }
  }
}
```

**Action Types (Enum):**
```typescript
type DeductionAction = 
  | "purchase"
  | "withdrawal"
  | "penalty"
  | "gift_sent"
  | "boost_post";
```

---

### Event: `wallet_update` (Optional - for balance corrections)

**Payload Structure:**
```json
{
  "type": "wallet_update",
  "eventType": "wallet:balance:updated",
  "recipientIds": [123],
  "data": {
    "userId": 123,
    "newBalance": 175,
    "previousBalance": 150,
    "reason": "Balance adjustment",
    "timestamp": "2025-12-23T12:00:00Z"
  }
}
```

---

## 💬 Message Events Specification

### Event: `message_preview`

**When to Send:**
- User sends a message in any conversation
- Send to ALL participants EXCEPT the sender
- Updates conversation list preview

**Payload Structure:**
```json
{
  "type": "message_preview",
  "eventType": "chat:message:sent",
  "recipientIds": [456, 789],
  "data": {
    "conversationId": "conv_123",
    "lastMessage": "Hello, how are you?",
    "lastMessageId": "msg_456",
    "senderId": 123,
    "senderUsername": "john_doe",
    "senderProfilePic": "https://cdn.lykluk.com/profiles/john_doe.jpg",
    "messageType": "text",
    "timestamp": "2025-12-23T12:00:00Z",
    "unreadCount": 3
  }
}
```

**Fields:**
- `type`: Always `"message_preview"`
- `eventType`: Always `"chat:message:sent"`
- `recipientIds`: All conversation participants EXCEPT sender
- `data.conversationId`: Unique conversation ID
- `data.lastMessage`: Preview text (truncate to 50 chars)
- `data.lastMessageId`: ID of the message
- `data.senderId`: User who sent the message
- `data.senderUsername`: Sender's username
- `data.senderProfilePic`: Sender's profile picture URL
- `data.messageType`: Type of message (see enum below)
- `data.timestamp`: When message was sent
- `data.unreadCount`: Number of unread messages for this recipient

**Message Types (Enum):**
```typescript
type MessageType = 
  | "text"
  | "image"
  | "video"
  | "audio"
  | "gif"
  | "sticker";
```

**Preview Text Rules:**
- `text`: Show first 50 characters
- `image`: Show "📷 Photo"
- `video`: Show "🎥 Video"
- `audio`: Show "🎵 Audio"
- `gif`: Show "GIF"
- `sticker`: Show "Sticker"

---

### Event: `message_received` (For active chat screen)

**When to Send:**
- User sends a message
- Send to recipients who have the chat screen open
- Adds message to active conversation

**Payload Structure:**
```json
{
  "type": "message_received",
  "eventType": "chat:message:received",
  "recipientIds": [456],
  "data": {
    "conversationId": "conv_123",
    "messageId": "msg_456",
    "senderId": 123,
    "senderUsername": "john_doe",
    "senderProfilePic": "https://cdn.lykluk.com/profiles/john_doe.jpg",
    "content": "Hello, how are you?",
    "messageType": "text",
    "mediaUrl": null,
    "timestamp": "2025-12-23T12:00:00Z"
  }
}
```

---

### Event: `typing_indicator` (Optional - Real-time typing)

**When to Send:**
- User starts typing in a conversation
- Send every 2-3 seconds while typing
- Stop when user stops typing for 3 seconds

**Payload Structure:**
```json
{
  "type": "typing_indicator",
  "eventType": "chat:typing:started",
  "recipientIds": [456],
  "data": {
    "conversationId": "conv_123",
    "userId": 123,
    "username": "john_doe",
    "isTyping": true
  }
} - if they have 100+ following)
```json
{
  "type": "points_earned",
  "recipientIds": [123],
  "data": {
    "action": "video_liked",
    "points": 1,
    "newBalance": 151,
    "reason": "Liked a video"
  }
}
```

**Event C: Wallet event** (to video owner - if they have 1000+ followers)
```json
{
  "type": "points_earned",
  "recipientIds": [999],
  "data": {
    "action": "like_received",
    "points": 1,
    "newBalance": 5001,
    "reason": "Your video received a like"
  }
}
```

**Frontend Actions:**
- Video owner: Shows "john_doe liked your video" in notification page + "+1 LykCoin ✨" animation
- User who liked: Shows "+1 LykCoin ✨" animation, updates wallet balance
- Both see wallet balance update in real-tim
```json
{
  "type": "video_like",
  "recipientIds": [999],
  "data": {
    "actorId": 123,
    "actorUsername": "john_doe",
    "videoId": "456"
  }
}
```

**Event B: Wallet event** (to user who liked)
```json
{
  "type": "points_earned",
  "recipientIds": [123],
  "data": {
    "action": "video_liked",
    "points": 1,
    "newBalance": 151
  }
}
```

**Frontend Actions:**
- Video owner: Shows "john_doe liked your video" in notification page
- User who liked: Shows "+1 LYK ✨" animation, updates wallet balance

---

### Example 2: User Sends Message → Updates Conversation List

**Sequence:**
1. User types "Hello" and sends
2. Frontend calls `POST /conversations/conv_123/messages`
3. Backend processes message
4. Backend sends ONE event:

**Event: Message preview** (to recipient)
```json
{
  "type": "message_preview",
  "recipientIds": [456],
  "data": {
    "conversationId": "conv_123",
    "lastMessage": "Hello",
    "senderId": 123,
    "senderUsername": "john_doe",
    "unreadCount": 3
  }
}
```

**Frontend Actions:**
- ❌ Does NOT show in notification page
- ✅ Updates conversation list
- ✅ Shows "Hello" as preview
- ✅ Shows unread badge "3"
- ✅ Moves conversation to top

---

## 🎯 Priority & Timeline

### Phase 1 (Immediate - Notifications Working) ✅
- Traditional notification events
- Device registration
- WebSocket connection
- Notification page UI

### Phase 2 (High Priority - Wallet Integration) 🔴
- `points_earned` event
- `points_deducted` event
- Wallet balance updates
- LYKS animation

**Dependencies:**
- Wallet system implementation
- Points calculation logic
- User balance tracking

### Phase 3 (High Priority - Messaging) 🟠
- `message_preview` event
- Conversation list updates
- Unread count tracking

**Dependencies:**
- Messaging system implementation
- Conversation storage
- Message delivery

### Phase 4 (Nice to Have) 🟢
- `typing_indicator`
- `message_read` status
- `wallet_update` corrections

---

## 📊 Technical Requirements

### 1. WebSocket Gateway

**Current Implementation:**
```javascript
// Already implemented for notifications
socket.on('connect', (socket) => {
  const { token } = socket.handshake.auth;
  const userId = verifyToken(token);
  socket.join(`user:${userId}`);
});
```

**Reuse same connection for new events:**
```javascript
// Emit wallet event
io.to(`user:${userId}`).emit('notification', {
  type: 'points_earned',
  data: { ... }
});

// Emit message event
io.to(`user:${recipientId}`).emit('notification', {
  type: 'message_preview',
  data: { ... }
});
```

### 2. Event Queue

Ensure events are delivered reliably:
- Use Redis/RabbitMQ for event queue
- Retry failed deliveries
- Store events in database for offline users

**Viewer Earnings (100+ following required):**
- [ ] User with 100+ following likes video → receives +1 LykCoin
- [ ] User with 100+ following views video → receives +1 LykCoin
- [ ] User with 100+ following shares video → receives +2 LykCoins
- [ ] User with 100+ following comments → receives +2 LykCoins
- [ ] User with <100 following → receives NO LykCoins

**Creator Earnings (1000+ followers required):**
- [ ] Creator with 1000+ followers uploads video → receives +5 LykCoins
- [ ] Creator's video gets 1 like → receives +1 LykCoin
- [ ] Creator's video gets 1 view → receives +0.1 LykCoin
- [ ] Creator's video gets 1 share → receives +1 LykCoin
- [ ] Creator with <1000 followers → receives NO LykCoins

**General:**
- [ ] Frontend shows "+X LykCoin ✨"

**Wallet Events Table:**
```sql
CREATE TABLE wallet_transactions (
  id UUID PRIMARY KEY,
  user_id INT NOT NULL,
  action VARCHAR(50) NOT NULL,
  points DECIMAL(10,2) NOT NULL,
  balance_before DECIMAL(10,2),
  balance_after DECIMAL(10,2),
  reason TEXT,
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);
```

**Message Events Table:**
```sql
CREATE TABLE messages (
  id UUID PRIMARY KEY,
  conversation_id UUID NOT NULL,
  sender_id INT NOT NULL,
  content TEXT,
  message_type VARCHAR(20),
  media_url TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE conversations (
  id UUID PRIMARY KEY,
  last_message_id UUID,
  last_message_text TEXT,
  last_message_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

## ✅ Testing Checklist

### Wallet Events
- [ ] User likes video → receives `points_earned` event
- [ ] Frontend shows +1 LYK animation
- [ ] Wallet balance updates correctly
- [ ] Multiple rapid actions don't duplicate points
- [ ] Points deduction works for purchases
- [ ] Balance never goes negative

### Message Events
- [ ] User sends message → recipient receives `message_preview`
- [ ] Conversation list updates with preview text
- [ ] Unread count increments
- [ ] Multiple messages update preview to latest
- [ ] Image messages show "📷 Photo" preview
- [ ] Typing indicator shows/hides correctly

---

## 📞 Contact

**Frontend Team:**
- Yerin (Lead)
- Questions: Review `/EVENT_DRIVEN_ARCHITECTURE.md`

**Backend Team:**
- Prince (princewhyte02@gmail.com)
- Implementation questions: Reference this document

---

**Document Version:** 1.0  
**Last Updated:** December 23, 2025  
**Status:** Awaiting Backend Implementation
