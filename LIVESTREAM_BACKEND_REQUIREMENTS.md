# Livestream Backend Requirements

This document outlines the backend requirements for the livestream feature based on frontend analysis.

**✅ UPDATE (Jan 25, 2026):** Frontend models have been updated to handle backend field mappings automatically.

---

## 1. Stream Details API (`GET /live-streams/{streamId}`)

### Backend Response (Current)

The backend returns this structure which is now correctly mapped by the frontend:

```json
{
  "success": true,
  "data": {
    "id": "stream-uuid",
    "userId": 109,                          // ✅ Mapped to creatorId
    "user": {
      "id": 109,
      "username": "@yashwardhan7057875",    // ✅ Mapped to creatorId & creatorName
      "verified_profile": false,
      "profile": {
        "avatar": "default/profile/default1.jpeg"  // ✅ Mapped to creatorAvatar
      }
    },
    "title": "Stream Title",
    "description": "Stream description",
    "status": "LIVE",                       // ✅ LIVE, ENDED, SCHEDULED mapped
    "streamType": "SOCIAL",
    "monetizationType": "FREE",             // ✅ FREE, PAID mapped
    "currentViewers": 5,
    "totalViews": 100,
    "totalLikes": 50,
    "totalComments": 25
    // ... other fields
  }
}
```

### ✅ Field Mapping (Frontend handles this automatically)

| Backend Field | Frontend Field | Status |
|---------------|----------------|--------|
| `user.username` | `creatorId` | ✅ Auto-mapped |
| `user.username` | `creatorName` | ✅ Auto-mapped |
| `user.profile.avatar` | `creatorAvatar` | ✅ Auto-mapped |
| `userId` (fallback) | `creatorId` | ✅ Auto-mapped |
| `status` (uppercase) | `status` (enum) | ✅ Auto-mapped |
| `monetizationType` (uppercase) | `monetizationType` (enum) | ✅ Auto-mapped |

---

## 2. WebSocket Events

### Connection
- **URL**: `wss://api.lykluk.com/media-live`
- **Auth**: `{ auth: { token: <jwt_token> } }`

### Room Management

#### `joinStream` (emit)
```json
{ "streamId": "stream-uuid" }
```
**⚠️ IMPORTANT**: Both broadcaster AND viewers must join the stream room to receive events.

#### `leaveStream` (emit)
```json
{ "streamId": "stream-uuid" }
```

---

## 3. Comment Broadcasting (CRITICAL)

### Current Issue
**Comments sent by viewers are NOT being received by the broadcaster.**

### Expected Flow
1. Viewer emits `comment` event:
```json
{
  "streamId": "stream-uuid",
  "text": "Hello!"
}
```

2. Server should broadcast `comment` to **ALL participants in the stream room** including:
   - The sender (for confirmation)
   - All other viewers
   - **The broadcaster** ⬅️ Currently not receiving

### Expected `comment` Event Data (listen)
```json
{
  "id": "comment-uuid",
  "userId": "user-uuid-or-username",
  "username": "displayName",
  "userAvatar": "profile/avatar.jpg",   // ⚠️ Relative path or full URL
  "text": "Hello!",
  "timestamp": "2026-01-23T10:00:00.000Z",
  "isHost": false,
  "isPinned": false
}
```

### Required Fields for Comments

| Field | Requirement | Notes |
|-------|-------------|-------|
| `id` | Required | Unique comment ID |
| `userId` | Required | User identifier |
| `username` | Required | Display name |
| `userAvatar` | Optional | Profile picture (relative or full URL) |
| `text` | Required | Comment text |
| `timestamp` | Required | ISO8601 format |

---

## 4. Viewer Count Events

### `viewerJoined` (listen)
```json
{
  "userId": "user-uuid",
  "username": "displayName",
  "viewerCount": 5
}
```

### `viewerLeft` (listen)
```json
{
  "userId": "user-uuid",
  "viewerCount": 4
}
```

### Issue Check
- Are these events being emitted when viewers join/leave?
- Is `viewerCount` being updated correctly?
- The frontend displays 0 viewers even when someone is watching

---

## 5. Follow API (`POST /profile/follow/{username}`)

### Requirement
The follow API expects a **username** (not UUID) in the path.

**Current code**:
```dart
profileRepo.followUnfollow(userName: stream.creatorId)
```

**Endpoint**: `POST /profile/follow/{username}`

### ⚠️ This means:
`stream.creatorId` from the stream details API **MUST be the username**, not a UUID.

---

## 6. Gift Events

### `gift` (emit)
```json
{
  "streamId": "stream-uuid",
  "giftType": "HEART",
  "quantity": 1
}
```

### `gift` (listen)
```json
{
  "id": "gift-uuid",
  "userId": "user-uuid",
  "username": "displayName",
  "userAvatar": "profile/avatar.jpg",
  "giftType": "HEART",
  "quantity": 1,
  "message": "Optional message",
  "timestamp": "2026-01-23T10:00:00.000Z"
}
```

---

## Summary of Issues to Fix

### ✅ Resolved (Frontend Updated)

1. **Creator Name/ID/Avatar Mapping**: 
   - Frontend now extracts from `user.username` and `user.profile.avatar`
   - No backend changes needed

2. **Comment User Info**:
   - Frontend now handles nested `user` object in comments
   - Also handles `user.profile.avatar` for avatars

3. **Viewer Info**:
   - Frontend now handles nested `user` object

### ⚠️ Backend Fixes Still Needed

1. **Comment Broadcasting**: 
   - Ensure `comment` events are broadcast to **ALL** participants in the stream room, including the broadcaster

2. **Viewer Count**:
   - Verify `viewerJoined`/`viewerLeft` events are being emitted
   - Include `viewerCount` in the event payload

---

## Testing Checklist

- [ ] Start a livestream as broadcaster
- [ ] Join stream as viewer from different account
- [ ] Verify broadcaster sees viewer join notification
- [ ] Send comment as viewer
- [ ] **Verify broadcaster receives comment in real-time**
- [ ] Send gift as viewer
- [ ] Verify broadcaster receives gift animation
- [ ] Check viewer count updates on both sides
- [ ] Test follow button works (follows the creator)
- [ ] Verify creator name displays correctly (not "Unknown")
- [ ] Verify avatar shows in comments (not colored placeholder)
