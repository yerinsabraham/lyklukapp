# User Presence & Activity Tracking System

---

## 📋 Overview

Implement a comprehensive user presence and activity tracking system to:
- Show online/offline status in messaging
- Track last seen timestamps  
- Display "last login" on user profiles
- Log user activities for admin analytics dashboard
- Match feature parity with TikTok/Instagram Live/DM experiences

---

## 🎯 Phase 1: User Presence System (HIGH PRIORITY)

### 1.1 Database Changes

#### Update `users` table:
```sql
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_online BOOLEAN DEFAULT false;
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_seen TIMESTAMP;
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_login_at TIMESTAMP;
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_active_at TIMESTAMP;

-- Index for performance
CREATE INDEX idx_users_online_status ON users(is_online, last_seen);
```

### 1.2 WebSocket Connection Tracking

**When user connects to WebSocket:**
```javascript
// On 'connection' event
UPDATE users 
SET is_online = true, 
    last_active_at = NOW() 
WHERE id = <userId>;

// Broadcast to relevant users (followers, chat partners)
socket.broadcast.emit('presence_update', {
  userId: <userId>,
  username: <username>,
  status: 'online',
  timestamp: new Date().toISOString()
});
```

**When user disconnects:**
```javascript
// On 'disconnect' event
UPDATE users 
SET is_online = false, 
    last_seen = NOW() 
WHERE id = <userId>;

socket.broadcast.emit('presence_update', {
  userId: <userId>,
  username: <username>,
  status: 'offline',
  lastSeen: new Date().toISOString()
});
```

### 1.3 Messaging API Updates

#### Update existing messaging endpoints to include presence:

**GET /messages/conversations/:id**
```json
{
  "success": true,
  "data": {
    "conversationId": "uuid",
    "participants": [
      {
        "userId": 123,
        "username": "john_doe",
        "displayName": "John Doe",
        "profilePictureUrl": "https://...",
        "isOnline": true,           // ✅ ADD THIS
        "lastSeen": "2026-01-25T10:30:00Z"  // ✅ ADD THIS
      }
    ],
    "messages": [...]
  }
}
```

**GET /messages/conversations** (List all conversations)
```json
{
  "success": true,
  "data": [
    {
      "conversationId": "uuid",
      "otherUser": {
        "userId": 123,
        "username": "jane_smith",
        "profilePictureUrl": "https://...",
        "isOnline": false,          // ✅ ADD THIS
        "lastSeen": "2026-01-25T08:15:00Z"  // ✅ ADD THIS
      },
      "lastMessage": {...}
    }
  ]
}
```

### 1.4 New Presence Endpoint

**GET /users/:username/presence**
```json
{
  "success": true,
  "data": {
    "userId": 123,
    "username": "john_doe",
    "isOnline": true,
    "lastSeen": "2026-01-25T10:30:00Z",
    "lastActiveAt": "2026-01-25T10:35:00Z"
  }
}
```

---

## 🎯 Phase 2: Session & Login Tracking (MEDIUM PRIORITY)

### 2.1 Track Login Events

**On successful login/signup (all auth methods):**
```javascript
// POST /auth/signin
// POST /auth/social-verified
// POST /auth/signup

UPDATE users 
SET last_login_at = NOW(),
    last_active_at = NOW()
WHERE id = <userId>;
```

### 2.2 Update User Profile Endpoints

**GET /users/:username** (Profile endpoint)
```json
{
  "success": true,
  "data": {
    "id": 123,
    "username": "john_doe",
    "bio": "...",
    "profilePictureUrl": "https://...",
    "followersCount": 1500,
    "followingCount": 300,
    
    // ✅ ADD THESE FIELDS
    "isOnline": false,
    "lastSeen": "2026-01-25T08:15:00Z",
    "lastLoginAt": "2026-01-25T07:00:00Z"
  }
}
```

### 2.3 Keep Alive / Activity Updates

**Middleware to track last_active_at:**
```javascript
// Add middleware to authenticated routes
app.use((req, res, next) => {
  if (req.user?.id) {
    // Fire-and-forget update (don't await)
    updateUserActivity(req.user.id);
  }
  next();
});

async function updateUserActivity(userId) {
  await db.query(
    'UPDATE users SET last_active_at = NOW() WHERE id = $1',
    [userId]
  );
}
```

---

## 🎯 Phase 3: Activity Logging for Admin Analytics (LOW PRIORITY)

### 3.1 Create Activity Log Table

```sql
CREATE TABLE user_activity_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  action VARCHAR(50) NOT NULL,
  target_type VARCHAR(30),    -- 'video', 'user', 'livestream', 'message', etc.
  target_id VARCHAR(100),
  metadata JSONB,              -- Flexible field for additional data
  ip_address VARCHAR(45),
  device_type VARCHAR(20),     -- 'ios', 'android', 'web'
  country_code VARCHAR(3),
  region VARCHAR(100),
  timestamp TIMESTAMP DEFAULT NOW(),
  
  INDEX idx_activity_user (user_id, timestamp DESC),
  INDEX idx_activity_action (action, timestamp DESC)
);
```

### 3.2 Actions to Log

| Action | Target Type | Metadata Example |
|--------|-------------|-----------------|
| `login` | - | `{ method: 'email', device: 'ios' }` |
| `logout` | - | `{ duration_seconds: 3600 }` |
| `video_posted` | `video` | `{ videoId: 'abc123', duration: 30 }` |
| `video_watched` | `video` | `{ videoId: 'xyz789', watchDuration: 28 }` |
| `livestream_started` | `livestream` | `{ streamId: 'uuid', type: 'SOCIAL' }` |
| `livestream_ended` | `livestream` | `{ duration: 1800, peakViewers: 150 }` |
| `comment_posted` | `video` | `{ videoId: 'abc', commentId: 'def' }` |
| `user_followed` | `user` | `{ targetUserId: 456 }` |
| `message_sent` | `conversation` | `{ conversationId: 'uuid' }` |

### 3.3 Admin Analytics Endpoints

**GET /admin/analytics/user-activity**
```
Query params:
  - userId (optional)
  - action (optional)
  - startDate
  - endDate
  - limit (default: 100)
  - offset (default: 0)

Response:
{
  "success": true,
  "data": {
    "total": 5000,
    "activities": [
      {
        "id": "uuid",
        "userId": 123,
        "username": "john_doe",
        "action": "video_posted",
        "targetType": "video",
        "targetId": "abc123",
        "timestamp": "2026-01-25T10:00:00Z",
        "metadata": { "duration": 30 }
      }
    ]
  }
}
```

**GET /admin/analytics/user-sessions**
```
Query params:
  - startDate
  - endDate

Response:
{
  "success": true,
  "data": {
    "totalSessions": 15000,
    "averageSessionDuration": 1200,  // seconds
    "activeUsersToday": 3500,
    "topHours": [
      { "hour": 18, "sessions": 2000 },
      { "hour": 19, "sessions": 1800 }
    ]
  }
}
```

---

## 📱 What Frontend Already Has

### ✅ Built & Ready to Use:

1. **Messaging Presence Display**
   - `ParticipantModel` has `isOnline` and `lastSeen` fields
   - UI shows green dot for online users
   - UI shows "Active 5m ago" for offline users

2. **WebSocket Event Listeners**
   - Frontend listens to `presence_update` events
   - Auto-updates UI when users go online/offline

3. **Presence Update Method**
   - Frontend sends presence updates via WebSocket
   - Called on app open and background/foreground changes

4. **Timestamp Display Utilities**
   - Already formats relative times ("2 hours ago", "Active now")

### ⚠️ What Frontend Will Add (After Backend is Ready):

1. Display "Last login: 2 hours ago" on profile pages
2. Show online status on video creator profiles
3. Display activity timeline in admin dashboard (web)

---

## 🔌 WebSocket Event Format (Frontend Expectation)

### Events Frontend is Already Listening For:

**Event: `presence_update`**
```javascript
{
  "userId": 123,
  "username": "john_doe",
  "status": "online",  // or "offline"
  "timestamp": "2026-01-25T10:30:00Z",
  "lastSeen": "2026-01-25T10:30:00Z"  // only if status is offline
}
```

### Events Frontend Will Emit:

**Event: `update_presence`**
```javascript
{
  "userId": 123,
  "status": "online"  // or "offline"
}
```

---

## 🚀 Implementation Checklist

### Phase 1 - Presence System (Highest Priority)
- [ ] Add database columns to `users` table
- [ ] Implement WebSocket connection/disconnection tracking
- [ ] Update messaging endpoints to include presence data
- [ ] Create presence endpoint
- [ ] Test with frontend messaging feature

### Phase 2 - Login Tracking
- [ ] Track `last_login_at` on all auth endpoints
- [ ] Add middleware for `last_active_at` updates
- [ ] Update user profile endpoints
- [ ] Test with frontend profile screens

### Phase 3 - Activity Logging (Optional Enhancement)
- [ ] Create `user_activity_logs` table
- [ ] Implement logging for key actions
- [ ] Create admin analytics endpoints
- [ ] Build admin dashboard (web interface)

---

## 🧪 Testing Checklist

### Presence System:
- [ ] User A logs in → WebSocket connects → `is_online = true`
- [ ] User B's app receives `presence_update` event for User A
- [ ] User A closes app → `is_online = false`, `last_seen` updated
- [ ] User B sees "Active 1m ago" in chat list
- [ ] GET `/users/userA/presence` returns correct status

### Login Tracking:
- [ ] Email login updates `last_login_at`
- [ ] Google Sign-In updates `last_login_at`
- [ ] Apple Sign-In updates `last_login_at`
- [ ] Profile endpoint returns `lastLoginAt` field
- [ ] Frontend displays "Last login: 2 hours ago"

### Activity Logging:
- [ ] Posting a video creates log entry
- [ ] Starting livestream creates log entry
- [ ] Admin endpoint filters by date range
- [ ] Admin endpoint filters by action type

---

## 📊 Performance Considerations

1. **Don't block requests:**
   - Use fire-and-forget for `last_active_at` updates
   - Don't await activity logging (async queue)

2. **Database indexes:**
   - Index `users(is_online, last_seen)` for presence queries
   - Index `user_activity_logs(user_id, timestamp)` for analytics

3. **Caching:**
   - Cache online user count in Redis
   - Cache recent activity logs (5-minute TTL)

4. **Rate limiting:**
   - Limit presence endpoint to 10 req/min per user
   - Debounce `last_active_at` updates (max 1/minute per user)

---

## 🔗 Related Docs

- [Messaging Backend Requirements](MESSAGING_BACKEND_REQUIREMENTS.md)
- [MediaLive Backend Integration](BACKEND_MEDIALIVE_REQUIREMENTS.md)
- [Event-Driven Architecture](EVENT_DRIVEN_ARCHITECTURE.md)

---

## ❓ Questions for Backend Team

1. Do you prefer Redis or database for online user tracking?
2. Should we implement heartbeat pings for mobile apps (to prevent stale online status)?
3. What's your preference for activity log retention (30 days? 90 days?)?
4. Should presence updates be sent to all followers or only active chat partners?

---

**Frontend Team Contact:** Ready to test as soon as Phase 1 is deployed to staging!  
**Estimated Frontend Integration Time:** 1-2 days (mostly just display logic)


