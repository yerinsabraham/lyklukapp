# Backend API Handoff — Lykluk (frontend expectations)

This document lists the REST API endpoints the frontend currently calls or expects, which items are already present, and where the backend needs to verify or add behavior to avoid frontend regressions.

Assumptions:
- The app is running in REST API mode (see `Endpoints.baseUrl` / `BackendConfig`).
- All responses follow the pattern `{ "data": <...>, "message": "..." }` unless noted.

Priority: High items block UX; Medium items are important but not blocking; Low are optional improvements.

---

**1. FYP / Follow status consistency**
- Status: Needs verification
- Frontend usage: `GET ${Endpoints.videoForYou}` (code: `Endpoints.videoForYou` -> `/video/fyp`) returns paginated videos parsed by `PostRepoImpl.getPosts` and `PostModel.fromJson`.
- Frontend expects each video JSON to include `User.followedBy` (array) OR a boolean flag indicating whether the current user follows that video owner. The frontend computes `PostModel.isFollowing` from `post.user.followedBy`.
- Action for backend: Ensure the video list responses include either:
  - `User.followedBy`: array of users (each with `id`) containing current user when applicable; OR
  - `User.isFollowedByCurrentUser`: boolean (preferred lighter payload).
- Request: same as current FYP query params (cursor/pagination). No change to method.
- Response (suggested minimal):
```
{
  "data": {
    "videos": [
      {
        "id": 123,
        "User": { "userId": 45, "username": "alice", "followedBy": [ { "User": { "id": 99 } } ], "isFollowedByCurrentUser": true },
        ...
      }
    ],
    "cursor": "..."
  }
}
```

**2. FYP like consistency (likes reflected in feed)**
- Status: Needs verification
- Frontend usage: `PostModel.videoLikes` must be present for `isLiked` to work. The frontend toggles likes using `POST ${Endpoints.videoLikeToggle}{postID}` and expects the response payload to contain `{ data: { like: <bool> } }`.
- Action for backend: Ensure feed responses include either `videoLikes` (list) or a boolean `isLiked` for each video and that the like toggle returns `{ data: { like: true|false } }`.
- Example response for toggle:
```
{ "data": { "like": true }, "message": "" }
```

**3. Saved videos (retrieve and toggle)**
- Status: Implemented (verify behavior)
- Endpoints: `GET ${Endpoints.getSavedVideos}` -> `/video/saved` and toggle via `POST ${Endpoints.saveVideo}{videoId}` or `POST ${Endpoints.unsaveVideo}{videoId}`.
- Frontend expects `getSavedPosts` to return a paginated object with `videos` array (cursor pagination). Ensure response shape matches `CursorPaginatedResponse` (field `videos`).

**4. Comments retrieval and replies**
- Status: Implemented (verify response shape)
- Endpoints:
  - Get comments: `GET ${Endpoints.commentToVideo}{videoId}` -> `/video/comment/{videoId}`
  - Get replies: `GET ${Endpoints.videoComments}{videoId}/reply/{commentId}` (code constructs these variants)
  - Post comment: `POST ${Endpoints.commentToVideo}{videoId}`
  - Reply: `POST ${Endpoints.commentReply.replace...}`
- Frontend expects a paginated `data` array and uses `PaginatedResponse` with field `data`. Confirm backend returns `{ data: [ ... ], meta?: {...} }` or `{ data: { data: [...], pagination... } }` in the exact shape used by `CommentRepoImpl.getComments`.

**5. Mutuals (feed / visibility option)**
- Status: Missing / optional (frontend currently treats Mutuals as 'same as feed' in places)
- Context: UI exposes a "Mutuals" tab (people you follow back). There is no dedicated `/mutuals` endpoint in `Endpoints`.
- Action for backend (optional but recommended): Provide an endpoint to fetch mutuals or include `isMutual`/`visibility` metadata in profile and post payloads to support the "Mutuals" audience and faster server-side filtering.
- Suggested endpoint: `GET /profile/mutuals?userId={id}&cursor=...` returning paginated list of mutual connections or videos.

**6. Reposts**
- Status: Implemented
- Endpoints: `POST ${Endpoints.repostVideo}{videoId}` and `POST ${Endpoints.unrepostVideo}{videoId}` exist. Response expected: `{ data: { repost: true|false } }`.

**7. Download / sharing URLs**
- Status: Implemented (verify behavior)
- Endpoints: `POST ${Endpoints.sharingDownload}` -> `/download` and `GET ${Endpoints.sharingCheckDownload}` -> `/get_download` (see `Endpoints` constants).
- Action for backend: Confirm the download endpoint returns a signed URL / file URL and any watermarking enforcement (Lykluk logo) happens server-side or the generated asset includes watermark. Provide the expected payload schema and TTL for signed URLs.

**8. Notifications (REST vs Firebase)**
- Status: Implemented (REST endpoints present) — verify
- Endpoints: `GET/PUT/DELETE ${Endpoints.notifications}` (`/notifications`) plus `/notifications/settings`, `/notifications/stats`, `/notifications/unread-count`.
- Frontend details: When `BackendConfig.useRestApiNotifications` is true the app uses REST above to list, delete, mark-as-read, etc. The push delivery still uses FCM for incoming push messages.
- Action for backend: Ensure the REST APIs return notification objects with metadata compatible with `NotificationModel` in the frontend (id, type, createdAt, read/unread, payload metadata, optional `mutualCount`). Provide examples of notification payloads used by the app.

**9. Social sign-in (Google / Apple)**
- Status: Implemented
- Endpoint: `POST ${Endpoints.authSocial}` -> `/auth/social-verified`.
- Frontend sends body: `{"provider": "google|apple", "idToken": "...", "interestIds": [...]}` and expects an auth response consistent with sign-in/signup (`AuthResponse` with `siginUser`, `accessToken`, `refreshToken`).

**10. Video view counts (increment / updates)**
- Status: Partial — endpoint constant exists, no frontend usage found
- Endpoint: `POST ${Endpoints.videoView}{videoId}` -> `/video/view/{videoId}` is defined but not invoked by repo code. The frontend listens for socket `video_update` events to receive live updates.
- Action for backend: Clarify expected flow:
  - If view counting is server-side only, ensure the server increments view count when streaming/delivery occurs and emits `video_update` socket events with updated counts.
  - If frontend should report views, provide the REST contract (POST `/video/view/{videoId}`) and expected response `{ data: { views: <int> } }` and confirm any anti-abuse rules (unique per-user/day, required headers, etc.).

---

Notes & Recommendations
- Where the frontend expects specific keys (e.g., like toggle returns `{ data: { like: bool } }`, repost returns `{ data: { repost: bool } }`), please confirm server responses match those keys or add compatibility on the frontend.
- Prefer sending small boolean flags on list endpoints (e.g., `User.isFollowedByCurrentUser`, `isLiked`, `isSaved`) instead of embedding arrays (`followedBy`, `videoLikes`) to reduce payload sizes.
- Provide sample payloads for the main endpoints so frontend and backend can iterate quickly.
