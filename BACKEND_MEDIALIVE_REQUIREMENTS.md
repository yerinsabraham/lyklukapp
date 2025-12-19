# Backend Requirements: BytePlus MediaLive Integration

**Date:** December 18, 2025  
**For:** Backend Development Team  
**Project:** LykLuk Live Streaming (Paid Monetization)  
**E-Commerce Integration:** ✅ Integrated with existing store/product system

---

## 🎯 Overview

This document specifies all backend requirements for integrating **BytePlus MediaLive** into LykLuk. The live streaming feature is **monetization-first** and **fully integrated with the existing e-commerce system**.

### Core Principles
1. ✅ **All stream credentials generated server-side**
2. ✅ **Payment enforcement before stream access**
3. ✅ **BytePlus OpenAPI integration for stream management**
4. ✅ **Callback handling for stream lifecycle events**
5. ✅ **Integrated with existing stores and products**
6. ✅ **Uses store subscription limits and commission rates**

---

## 🔗 E-Commerce Integration

### Store Association
- **Every live stream belongs to a store** (required `storeId`)
- Users select which store when creating a stream
- If user has only one store, auto-select it
- Store must be **verified** to create live streams

### Subscription Limits
Live streaming feature gates based on existing store subscription:

| Plan | Live Streaming | Concurrent Streams | Commission Rate |
|------|---------------|-------------------|----------------|
| FREE | ❌ Not allowed | 0 | 10% |
| BASIC | ✅ Allowed | 1 | 7% |
| CLASSIC | ✅ Allowed | 2 | 5% |
| PREMIUM | ✅ Allowed | 5 | 3% |

**Important:** Use store's subscription commission rate, not hardcoded 8%

### Product Pinning
- Products pinned during `LIVE_COMMERCE` streams reference existing e-commerce products
- Backend must verify product belongs to same store as stream
- Product must be ACTIVE status
- Use existing product data (price, images, inventory)

### Order Tracking
- Sales during live streams create regular e-commerce orders
- Add `orderSource` field: `"LIVE_STREAM"` vs `"REGULAR"`
- Add optional `streamId` to orders for analytics
- Use store's commission rate from subscription plan

---

## 📊 Database Schema Requirements

### 1. `live_streams` Table/Collection

```json
{
  "id": "string (UUID)",
  "creatorId": "string (user ID reference)",
  "storeId": "integer (references stores.id) - REQUIRED",
  "title": "string (max 100 chars)",
  "description": "string (max 500 chars)",
  "thumbnailUrl": "string (optional)",
  "monetizationType": "enum [FREE, LIVE_COMMERCE, LIVE_EVENT, MASTERCLASS, BRAND_SPONSORED]",
  "price": "number (decimal, nullable - for LIVE_EVENT, MASTERCLASS)",
  "currency": "string (ISO 4217, e.g., NGN, USD)",
  "commissionPercentage": "number (decimal - from store subscription, NOT hardcoded)",
  "status": "enum [DRAFT, SCHEDULED, LIVE, ENDED, CANCELLED]",
  "byteplusStreamKey": "string (generated from BytePlus, encrypted)",
  "byteplusPushUrl": "string (generated from BytePlus, encrypted)",
  "byteplusPullUrl": "string (generated from BytePlus, encrypted)",
  "byteplusStreamId": "string (BytePlus internal ID)",
  "recordingEnabled": "boolean (default: false)",
  "recordingUrl": "string (nullable - populated after stream ends)",
  "maxViewers": "number (nullable - for MASTERCLASS)",
  "currentViewers": "number (default: 0)",
  "totalViews": "number (default: 0)",
  "scheduledStartTime": "timestamp (nullable)",
  "actualStartTime": "timestamp (nullable)",
  "actualEndTime": "timestamp (nullable)",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

**Indexes:**
- `creatorId` (for creator's streams listing)
- `storeId` (for store's streams - ADDED)
- `status` (for active streams query)
- `monetizationType` (for filtering)
- `scheduledStartTime` (for upcoming streams)

---

### 2. `live_access` Table/Collection

Tracks who has paid/been granted access to a stream.

```json
{
  "id": "string (UUID)",
  "streamId": "string (references live_streams.id)",
  "userId": "string (user ID)",
  "monetizationType": "enum (copied from stream)",
  "accessGrantedAt": "timestamp",
  "expiresAt": "timestamp (nullable - for time-limited sessions)",
  "paymentId": "string (nullable - references payment transaction)",
  "accessToken": "string (JWT or signed token for pull URL)",
  "isActive": "boolean (default: true)",
  "createdAt": "timestamp"
}
```

**Indexes:**
- `streamId + userId` (composite unique index)
- `userId` (for user's purchased streams)
- `accessToken` (for validation)

---

### 3. `live_products` Table/Collection

For LIVE_COMMERCE mode - products pinned during stream.

```json
{
  "id": "string (UUID)",
  "streamId": "string (references live_streams.id)",
  "productId": "integer (references products.id) - CHANGED to integer for e-commerce integration",
  "pinnedAt": "timestamp",
  "unpinnedAt": "timestamp (nullable)",
  "position": "number (display order)",
  "specialPrice": "number (nullable - stream-specific pricing)",
  "inventory": "number (nullable - stream-specific inventory)",
  "soldCount": "number (default: 0)",
  "isActive": "boolean (default: true)",
  "createdAt": "timestamp"
}
```

**Indexes:**
- `streamId + isActive` (composite)
- `productId`

---

### 4. `live_payments` Table/Collection

Tracks payments for stream access (extends existing payment system).

```json
{
  "id": "string (UUID)",
  "streamId": "string (references live_streams.id)",
  "userId": "string (user ID)",
  "creatorId": "string (stream creator ID)",
  "amount": "number (decimal)",
  "currency": "string",
  "platformFee": "number (decimal - calculated)",
  "creatorEarning": "number (decimal - calculated)",
  "paymentMethod": "string",
  "paymentStatus": "enum [PENDING, COMPLETED, FAILED, REFUNDED]",
  "transactionId": "string (payment gateway transaction ID)",
  "paidAt": "timestamp (nullable)",
  "createdAt": "timestamp"
}
```

**Indexes:**
- `streamId`
- `userId`
- `creatorId`
- `paymentStatus`

---

### 5. `live_replays` Table/Collection

For recorded streams available for replay.

```json
{
  "id": "string (UUID)",
  "streamId": "string (references live_streams.id)",
  "title": "string",
  "recordingUrl": "string (BytePlus recording URL)",
  "duration": "number (seconds)",
  "thumbnailUrl": "string",
  "monetizationType": "enum [FREE, PAID, BUNDLED]",
  "price": "number (nullable)",
  "currency": "string (nullable)",
  "viewCount": "number (default: 0)",
  "isPublished": "boolean (default: false)",
  "publishedAt": "timestamp (nullable)",
  "createdAt": "timestamp"
}
```

**Indexes:**
- `streamId`
- `isPublished`

---

### 6. `creator_plans` Table/Collection (Enhancement)

**Add new fields to existing creator plans:**

```json
{
  // ... existing fields ...
  "tier": "enum [FREE, STARTER, PRO, BUSINESS]",
  "monthlyPrice": "number (0 for FREE, regional pricing for others)",
  "liveStreamingEnabled": "boolean (default: false)",
  "maxLiveStreamsPerMonth": "number (nullable - null = unlimited)",
  "maxLiveStreamDuration": "number (minutes, nullable)",
  "maxConcurrentStreams": "number (default: 1)",
  "recordingEnabled": "boolean (default: false)",
  "brandSponsorshipEnabled": "boolean (default: false)",
  "commissionRate": "number (varies by tier: 10% free, 8% starter, 5% pro)"
}
```

**Plan Examples for Nigeria:**

**FREE TIER** (₦0/month)
- `liveStreamingEnabled: true` ✅ Changed - allow free testing
- `maxLiveStreamsPerMonth: 3`
- `maxLiveStreamDuration: 30` (minutes)
- `recordingEnabled: false`
- `commissionRate: 10%`
- Purpose: Test and build audience

**STARTER TIER** (₦5,000-10,000/month ≈ $10-20)
- `liveStreamingEnabled: true`
- `maxLiveStreamsPerMonth: null` (unlimited)
- `maxLiveStreamDuration: 180` (3 hours)
- `recordingEnabled: true`
- `commissionRate: 8%`
- `maxConcurrentStreams: 2`

**PRO TIER** (₦25,000-50,000/month ≈ $50-100)
- All Starter features
- `commissionRate: 5%` ✅ Lower for serious creators
- `brandSponsorshipEnabled: true`
- Advanced analytics
- Priority support

**BUSINESS TIER** (Custom pricing)
- All Pro features
- `commissionRate: negotiable (3-5%)`
- Dedicated account manager
- Custom integrations

---

### 7. `regional_config` Table/Collection (NEW)

Store region-specific settings for pricing and commissions.

```json
{
  "id": "string (UUID)",
  "region": "string (ISO country code, e.g., NG, GH, KE, ZA)",
  "currency": "string (NGN, GHS, KES, ZAR)",
  "defaultCommissionRate": "number (5-10% for Africa)",
  "paymentProviders": "array [Paystack, Flutterwave, etc.]",
  "minimumPayout": "number (in local currency)",
  "isActive": "boolean",
  "createdAt": "timestamp"
}
```

**Example Configurations:**

**Nigeria (NG)**
- Currency: NGN
- Default commission: 8%
- Payment providers: [Paystack, Flutterwave, Bank Transfer]
- Minimum payout: ₦5,000

**Ghana (GH)**
- Currency: GHS
- Default commission: 8%
- Payment providers: [Paystack, Flutterwave, Mobile Money]
- Minimum payout: GH₵50

**Kenya (KE)**
- Currency: KES
- Default commission: 9%
- Payment providers: [Flutterwave, M-Pesa]
- Minimum payout: KES 500

**South Africa (ZA)**
- Currency: ZAR
- Default commission: 10%
- Payment providers: [Paystack, Flutterwave, Card]
- Minimum payout: R100

---

## ⚙️ E-Commerce Integration Requirements

### Store Subscription Validation

**Before allowing stream creation, validate:**

```typescript
// Pseudo-code for validation
async function validateStreamCreation(userId: string) {
  // 1. Get user's store
  const store = await Store.findFirst({ where: { userId } })
  
  if (!store) {
    throw new Error('You must create a store before live streaming')
  }
  
  // 2. Check store verification
  if (!store.verified) {
    throw new Error('Your store must be verified to start live streaming')
  }
  
  // 3. Check subscription plan
  if (store.subscriptionPlan === 'FREE') {
    throw new Error('Live streaming requires BASIC plan or higher. Please upgrade your subscription.')
  }
  
  // 4. Check concurrent stream limit
  const activeStreams = await LiveStream.count({
    where: { storeId: store.id, status: 'LIVE' }
  })
  
  const limits = {
    BASIC: 1,
    CLASSIC: 2,
    PREMIUM: 5
  }
  
  if (activeStreams >= limits[store.subscriptionPlan]) {
    throw new Error(`Your ${store.subscriptionPlan} plan allows ${limits[store.subscriptionPlan]} concurrent stream(s)`)
  }
  
  return store
}
```

### Commission Rate Calculation

**Use store subscription rate, not hardcoded values:**

```typescript
async function calculateCommission(orderId: string) {
  const order = await Order.findById(orderId)
  const stream = await LiveStream.findById(order.streamId)
  const store = await Store.findById(stream.storeId)
  
  // Get commission from store subscription
  const commissionRates = {
    FREE: 0.10,    // 10%
    BASIC: 0.07,   // 7%
    CLASSIC: 0.05, // 5%
    PREMIUM: 0.03  // 3%
  }
  
  const rate = commissionRates[store.subscriptionPlan]
  const commission = order.subtotal * rate
  
  return {
    subtotal: order.subtotal,
    commission: commission,
    storeEarning: order.subtotal - commission,
    commissionRate: rate
  }
}
```

### Product Pinning Validation

**When pinning products during LIVE_COMMERCE:**

```typescript
async function pinProduct(streamId: string, productId: number) {
  const stream = await LiveStream.findById(streamId)
  const product = await Product.findById(productId)
  
  // 1. Verify product exists and is active
  if (!product || product.status !== 'ACTIVE') {
    throw new Error('Product not found or inactive')
  }
  
  // 2. Verify product belongs to same store as stream
  if (product.storeId !== stream.storeId) {
    throw new Error('Can only pin products from your own store')
  }
  
  // 3. Create live_products record
  return await LiveProduct.create({
    streamId,
    productId,
    pinnedAt: new Date(),
    originalPrice: product.price,
    specialPrice: null, // Can set stream-specific discount
    inventory: product.inventory
  })
}
```

### Order Source Tracking

**Add to existing order creation:**

```typescript
// Extend existing POST /orders endpoint
interface CreateOrderDto {
  // ... existing fields
  streamId?: string  // NEW: Optional stream ID
}

async function createOrder(dto: CreateOrderDto, userId: string) {
  const order = await Order.create({
    ...dto,
    userId,
    orderSource: dto.streamId ? 'LIVE_STREAM' : 'REGULAR', // NEW field
    streamId: dto.streamId || null, // NEW field
  })
  
  // If from live stream, use store's commission rate
  if (dto.streamId) {
    const stream = await LiveStream.findById(dto.streamId)
    const store = await Store.findById(stream.storeId)
    order.platformCommission = calculateCommission(order, store.subscriptionPlan)
  }
  
  return order
}
```

### Analytics Integration

**Live stream sales should appear in existing store analytics:**

```typescript
// No changes needed - existing analytics will automatically include live stream orders
// But you can add specific live stream metrics:

async function getStoreAnalytics(storeId: number) {
  const analytics = await getExistingAnalytics(storeId) // Your existing function
  
  // Add live streaming metrics
  const liveStreamMetrics = {
    totalLiveStreams: await LiveStream.count({ where: { storeId } }),
    activeLiveStreams: await LiveStream.count({ where: { storeId, status: 'LIVE' } }),
    liveStreamRevenue: await Order.sum('total', {
      where: { storeId, orderSource: 'LIVE_STREAM' }
    }),
    liveStreamOrders: await Order.count({
      where: { storeId, orderSource: 'LIVE_STREAM' }
    })
  }
  
  return {
    ...analytics,
    liveStreaming: liveStreamMetrics
  }
}
```

---

## 🔌 API Endpoints Required

### Base URL
```
/api/v1/live
```

---

### 1. **Create Live Stream**

**Endpoint:** `POST /live/create`

**Headers:**
```
Authorization: Bearer <user_token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "storeId": 42,
  "title": "My Live Stream",
  "description": "Stream description here",
  "thumbnailUrl": "https://...",
  "monetizationType": "LIVE_COMMERCE",
  "price": 9.99,
  "currency": "NGN",
  "recordingEnabled": true,
  "maxViewers": 100,
  "scheduledStartTime": "2025-12-20T19:00:00Z"
}
```

**Server Logic:**
1. Validate user is authenticated
2. **Validate store (NEW):**
   - Get store by `storeId` (or user's first store if omitted)
   - Verify store is verified
   - Check `subscriptionPlan !== 'FREE'`
   - Check concurrent stream limit based on plan
3. Validate monetization rules:
   - If `LIVE_EVENT` or `MASTERCLASS`, price must be > 0
   - If `LIVE_COMMERCE`, price is optional (products have prices)
   - If `FREE`, check creator hasn't exceeded monthly limit (3 streams)
4. **Calculate commission rate from store subscription (NEW)**
5. **Call BytePlus MediaLive OpenAPI:**
   - Generate stream key and push/pull URLs
   - Use BytePlus domains from console setup
6. Store stream data in `live_streams` table (status: DRAFT)
7. Return response

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "streamId": "uuid",
    "storeId": 42,
    "pushUrl": "rtmp://zjughtfyocph-push.bpmedialive.com/live/stream_id",
    "streamKey": "encrypted_stream_key_here",
    "status": "DRAFT",
    "monetizationType": "LIVE_COMMERCE",
    "price": null,
    "commissionPercentage": 7.0,
    "currency": "NGN"
  }
}
```

**Error Responses:**
- `400` - Validation error (missing fields, invalid monetization)
- `403` - Store not verified or FREE plan (upgrade required)
- `404` - Store not found
- `429` - Max concurrent streams limit reached
- `500` - BytePlus API error

---

### 2. **Request Stream Access (Viewer)**

**Endpoint:** `POST /live/access`

**Headers:**
```
Authorization: Bearer <user_token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "streamId": "uuid"
}
```

**Server Logic:**
1. Validate user is authenticated
2. Check stream status:
   - If status is not `LIVE`, return error (stream not live)
   - If status is `ENDED`, suggest replay
3. Check monetization type:
   - **FREE:** Grant access (check creator tier limits)
   - **LIVE_COMMERCE:** Grant access (free to watch)
   - **LIVE_EVENT:** Check if user has paid (query `live_access` or `live_payments`)
   - **MASTERCLASS:** Check payment + check `maxViewers` limit
   - **BRAND_SPONSORED:** Check custom access rules
4. If payment required and not paid:
   - Return `403` with paywall info
5. If access granted:
   - Create or retrieve `live_access` record
   - Generate signed `accessToken` (JWT with expiry)
   - Return signed pull URL or token

**Success Response (200) - Access Granted:**
```json
{
  "success": true,
  "data": {
    "accessGranted": true,
    "pullUrl": "https://pull.example.com/live/stream_id?token=signed_token",
    "accessToken": "jwt_token_here",
    "expiresAt": "2025-12-20T21:00:00Z"
  }
}
```

**Response (403) - Payment Required:**
```json
{
  "success": false,
  "error": {
    "code": "PAYMENT_REQUIRED",
    "message": "You must purchase access to this stream",
    "data": {
      "streamId": "uuid",
      "price": 9.99,
      "currency": "USD",
      "monetizationType": "TICKETED_LIVE"
    }
  }
}
```

**Error Responses:**
- `400` - Invalid stream ID
- `404` - Stream not found
- `403` - Stream ended or not live
- `429` - Max viewers reached (for PAID_SESSION)

---

### 3. **Start Live Stream**

**Endpoint:** `POST /live/{streamId}/start`

**Headers:**
```
Authorization: Bearer <user_token>
```

**Server Logic:**
1. Validate user is the stream creator
2. Update stream status to `LIVE`
3. Set `actualStartTime` to current timestamp
4. Optionally notify followers/subscribers (push notifications)

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "streamId": "uuid",
    "status": "LIVE",
    "actualStartTime": "2025-12-20T19:05:00Z"
  }
}
```

---

### 4. **End Live Stream**

**Endpoint:** `POST /live/{streamId}/end`

**Headers:**
```
Authorization: Bearer <user_token>
```

**Server Logic:**
1. Validate user is the stream creator
2. Update stream status to `ENDED`
3. Set `actualEndTime` to current timestamp
4. If recording enabled, trigger BytePlus recording processing
5. Close all active access tokens
6. Process final payment settlements

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "streamId": "uuid",
    "status": "ENDED",
    "actualEndTime": "2025-12-20T20:30:00Z",
    "totalViews": 234,
    "recordingUrl": "https://... (if available)"
  }
}
```

---

### 5. **Pin Product (Live Commerce)**

**Endpoint:** `POST /live/{streamId}/pin-product`

**Headers:**
```
Authorization: Bearer <user_token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "productId": 456,
  "specialPrice": 99.99,
  "inventory": 50
}
```

**Server Logic:**
1. Validate user is the stream creator
2. **Validate product (E-COMMERCE INTEGRATION):**
   - Fetch product from e-commerce `products` table by `productId`
   - Verify product exists and status is `ACTIVE`
   - **Verify `product.storeId === stream.storeId`** (critical security check)
3. Check if already pinned (un-pin if needed)
4. Create `live_products` record with:
   - `productId` (integer from e-commerce)
   - `specialPrice` (optional stream discount)
   - `inventory` (optional stream-specific limit)
   - Product details from e-commerce (name, images, original price)
5. Return pinned product data

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "uuid",
    "streamId": "stream_uuid",
    "productId": 456,
    "pinnedAt": "2025-12-20T19:15:00Z",
    "position": 0,
    "specialPrice": 99.99,
    "originalPrice": 129.99,
    "inventory": 50,
    "soldCount": 0,
    "product": {
      "id": 456,
      "name": "Product Name",
      "images": ["cdn-path/product.jpg"],
      "description": "Product description",
      "category": "Electronics"
    }
  }
}
```

**Error Responses:**
- `403` - Not stream creator or product belongs to different store
- `404` - Product not found or inactive
- `400` - Invalid product ID

**Request Body:**
```json
{
  "productId": "uuid",
  "specialPrice": 19.99,
  "inventory": 50
}
```

**Server Logic:**
1. Validate user is the stream creator
2. Validate stream is `LIVE`
3. Validate product exists
4. Unpin any currently pinned product (set `unpinnedAt`)
5. Create new `live_products` entry with `isActive: true`

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "liveProductId": "uuid",
    "productId": "uuid",
    "specialPrice": 19.99,
    "inventory": 50,
    "pinnedAt": "2025-12-20T19:15:00Z"
  }
}
```

---

### 6. **Get Active Streams**

**Endpoint:** `GET /live/active`

**Query Params:**
```
?monetizationType=LIVE_COMMERCE (optional filter)
&limit=20
&offset=0
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "streams": [
      {
        "streamId": "uuid",
        "title": "My Live Stream",
        "thumbnailUrl": "https://...",
        "creatorId": "uuid",
        "creatorName": "John Doe",
        "creatorAvatar": "https://...",
        "monetizationType": "TICKETED_LIVE",
        "price": 9.99,
        "currency": "USD",
        "currentViewers": 45,
        "startedAt": "2025-12-20T19:05:00Z"
      }
    ],
    "total": 15
  }
}
```

---

### 7. **Get Stream Details**

**Endpoint:** `GET /live/{streamId}`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "streamId": "uuid",
    "title": "My Live Stream",
    "description": "Description here",
    "thumbnailUrl": "https://...",
    "creatorId": "uuid",
    "creatorName": "John Doe",
    "creatorAvatar": "https://...",
    "monetizationType": "TICKETED_LIVE",
    "price": 9.99,
    "currency": "USD",
    "status": "LIVE",
    "currentViewers": 45,
    "totalViews": 120,
    "startedAt": "2025-12-20T19:05:00Z",
    "recordingEnabled": true,
    "pinnedProduct": {
      "productId": "uuid",
      "name": "Product Name",
      "imageUrl": "https://...",
      "price": 19.99
    }
  }
}
```

---

### 8. **Purchase Stream Access**

**Endpoint:** `POST /live/{streamId}/purchase`

**Headers:**
```
Authorization: Bearer <user_token>
Content-Type: application/json
```

**Request Body:**
```json
{
  "paymentMethodId": "pm_xxx"
}
```

**Server Logic:**
1. Validate user is authenticated
2. Validate stream requires payment
3. Check if user already has access
4. Process payment via existing payment gateway
5. Create `live_payments` record
6. Create `live_access` record
7. Generate access token

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "paymentId": "uuid",
    "accessToken": "jwt_token",
    "pullUrl": "https://...",
    "expiresAt": "2025-12-20T21:00:00Z"
  }
}
```

---

### 9. **Get Replays**

**Endpoint:** `GET /live/replays`

**Query Params:**
```
?creatorId=uuid (optional)
&limit=20
&offset=0
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "replays": [
      {
        "replayId": "uuid",
        "streamId": "uuid",
        "title": "Replay Title",
        "thumbnailUrl": "https://...",
        "duration": 3600,
        "monetizationType": "FREE",
        "price": null,
        "viewCount": 450,
        "publishedAt": "2025-12-20T21:00:00Z"
      }
    ],
    "total": 5
  }
}
```

---

### 10. **Check Creator Tier Limits**

**Endpoint:** `POST /live/check-limits`

**Headers:**
```
Authorization: Bearer <user_token>
```

**Server Logic:**
1. Get creator's current tier
2. Check limits:
   - Monthly stream count
   - Stream duration limits
   - Concurrent streams
3. Return remaining quota

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "tier": "STARTER",
    "canCreateStream": true,
    "streamsThisMonth": 5,
    "maxStreamsPerMonth": null,
    "maxDuration": 180,
    "commissionRate": 8.0
  }
}
```

**Response (403) - Limit Reached:**
```json
{
  "success": false,
  "error": {
    "code": "LIMIT_REACHED",
    "message": "You've reached your free tier limit (3 streams/month)",
    "upgradeUrl": "/pricing"
  }
}
```

---

### 10. **Check Creator Tier Limits**

**Endpoint:** `POST /live/check-limits`

**Headers:**
```
Authorization: Bearer <user_token>
```

**Server Logic:**
1. Get creator's current tier
2. Check limits:
   - Monthly stream count
   - Stream duration limits
   - Concurrent streams
3. Return remaining quota

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "tier": "STARTER",
    "canCreateStream": true,
    "streamsThisMonth": 5,
    "maxStreamsPerMonth": null,
    "maxDuration": 180,
    "commissionRate": 8.0
  }
}
```

**Response (403) - Limit Reached:**
```json
{
  "success": false,
  "error": {
    "code": "LIMIT_REACHED",
    "message": "You've reached your free tier limit (3 streams/month)",
    "upgradeUrl": "/pricing"
  }
}
```

---

## 🔄 BytePlus Callback Integration

BytePlus MediaLive sends callbacks for stream lifecycle events. You must implement webhook endpoints to handle these.

### Callback Endpoint

**Endpoint:** `POST /api/webhooks/byteplus/callback`

**Expected Events:**
1. `stream.started` - Stream went live
2. `stream.ended` - Stream ended
3. `stream.recording_ready` - Recording processed
4. `stream.error` - Stream error occurred

**Webhook Payload Example:**
```json
{
  "event": "stream.started",
  "timestamp": "2025-12-20T19:05:00Z",
  "data": {
    "streamId": "byteplus_stream_id",
    "status": "live"
  }
}
```

**Server Actions:**
1. **stream.started:**
   - Update `live_streams.status = LIVE`
   - Set `actualStartTime`
   - Send push notifications to followers

2. **stream.ended:**
   - Update `live_streams.status = ENDED`
   - Set `actualEndTime`
   - Invalidate access tokens

3. **stream.recording_ready:**
   - Update `live_streams.recordingUrl`
   - Create `live_replays` entry if applicable

4. **stream.error:**
   - Log error
   - Update stream status
   - Notify creator

**Security:**
- Validate callback signature (BytePlus provides signing mechanism)
- Only accept callbacks from BytePlus IPs

---

## 💰 Payment & Commission Calculation

### Formula

```
commissionPercentage = creatorTier.commissionRate OR regional.defaultCommissionRate
platformFee = price × (commissionPercentage / 100)
creatorEarning = price - platformFee
```

**Example for Nigeria (Starter Tier, 8% commission):**
- Stream price: ₦10,000
- Commission: 8%
- Platform fee: ₦800
- Creator earning: ₦9,200

**Example for Live Commerce Product Sale:**
- Product price: ₦50,000
- Creator tier: Pro (5% commission)
- Platform fee: ₦2,500
- Creator earning: ₦47,500

### Regional Commission Tiers

| Region | Free Tier | Starter | Pro | Business |
|--------|-----------|---------|-----|----------|
| Nigeria | 10% | 8% | 5% | 3-5% |
| Ghana | 10% | 8% | 6% | 4-6% |
| Kenya | 10% | 9% | 6% | 4-6% |
| Other | 10% | 10% | 8% | 5-8% |

**Note:** Commission is taken on transactions (product sales, event tickets), not on subscription fees.

### Live Commerce

For products sold during `LIVE_COMMERCE`:
```
productPlatformFee = productPrice × (commissionPercentage / 100)
creatorEarning = productPrice - productPlatformFee
```

---

## 💳 African Payment Integration Requirements

### Priority 1: Nigeria

**Paystack (Primary)**
- Cards (Visa, Mastercard, Verve)
- Bank transfer
- USSD codes
- Integration: https://paystack.com/docs

**Flutterwave (Secondary)**
- Cards
- Bank transfer
- Mobile money
- Integration: https://developer.flutterwave.com

### Priority 2: Ghana, Kenya, Uganda

**Mobile Money Required:**
- Ghana: MTN Mobile Money, Vodafone Cash
- Kenya: M-Pesa, Airtel Money
- Uganda: MTN Mobile Money

**Flutterwave** supports all these markets

### Payment Flow Requirements

1. **Checkout must feel local:**
   - Show prices in local currency (₦, GH₵, KES)
   - Support local payment methods first
   - Mobile-optimized checkout

2. **Transaction fees:**
   - Platform absorbs payment gateway fees OR
   - Clearly show fees before checkout

3. **Refund policy:**
   - Simple refund process
   - Refunds processed within 5-7 business days
   - Clear refund terms

4. **Payout to creators:**
   - Support local bank transfers
   - Mobile money for smaller creators
   - Minimum payout: ₦5,000 (Nigeria), adjust per region
   - Payout frequency: Weekly or bi-weekly

### API Integration

**Backend must integrate:**

```javascript
// Paystack (Nigeria primary)
const paystack = require('paystack')(SECRET_KEY);

// Initialize transaction
paystack.transaction.initialize({
  email: user.email,
  amount: amount * 100, // in kobo
  currency: 'NGN',
  callback_url: 'https://app.lykluk.com/payment/callback',
  metadata: {
    streamId: streamId,
    userId: userId
  }
});

// Verify transaction
paystack.transaction.verify(reference);
```

**Flutterwave (Multi-country)**
```javascript
const Flutterwave = require('flutterwave-node-v3');

const flw = new Flutterwave(PUBLIC_KEY, SECRET_KEY);

const payload = {
  tx_ref: generateReference(),
  amount: amount,
  currency: 'NGN', // or GHS, KES, etc.
  payment_options: 'card,mobilemoney,ussd',
  redirect_url: 'https://app.lykluk.com/payment/callback',
  customer: {
    email: user.email,
    phonenumber: user.phone,
    name: user.name
  },
  customizations: {
    title: 'LykLuk Live Event',
    description: streamTitle
  }
};
```

---

## 🔐 Security Requirements

### 1. Stream Key Encryption
- **Never** store stream keys in plain text
- Encrypt `byteplusStreamKey` using AES-256 or similar
- Decrypt only when serving to verified creator

### 2. Pull URL Signing
- Generate time-limited signed URLs for pull access
- Use JWT with claims:
  ```json
  {
    "userId": "uuid",
    "streamId": "uuid",
    "exp": 1703102400
  }
  ```
- Validate token on every playback request

### 3. Access Token Validation
- Implement middleware to validate `accessToken` on pull URL requests
- Check token expiry
- Check if stream is still live
- Check if user access was revoked

### 4. Rate Limiting
- Limit stream creation: 10 per day per creator
- Limit access requests: 100 per minute per user
- Limit callback endpoint: 1000 per minute

---

## 🧪 Testing Requirements

### Test Cases Backend Must Cover

1. ✅ **Stream Creation**
   - Valid creation with all monetization types
   - Reject if plan not eligible
   - Reject if concurrent stream limit reached
   - BytePlus API failure handling

2. ✅ **Access Control**
   - Deny access without payment (TICKETED_LIVE, PAID_SESSION)
   - Grant access for LIVE_COMMERCE
   - Enforce max viewers for PAID_SESSION
   - Validate access tokens

3. ✅ **Payment Flow**
   - Successful payment creates access
   - Failed payment denies access
   - Commission calculation accuracy

4. ✅ **Callbacks**
   - Handle all BytePlus events
   - Validate callback signatures
   - Update stream status correctly

5. ✅ **Edge Cases**
   - Stream ended but viewer tries to access
   - Creator ends stream during active viewers
   - Recording processing failures

---

## 📋 BytePlus OpenAPI Integration

### Required BytePlus API Calls

You will need to integrate with BytePlus MediaLive OpenAPI:

#### 1. Create Live Stream
**Endpoint:** `POST /live/v1/CreateLiveStream`

**Request:**
```json
{
  "DomainList": ["push.example.com", "pull.example.com"],
  "App": "live",
  "Stream": "unique_stream_id"
}
```

**Response:**
```json
{
  "ResponseMetadata": { ... },
  "Result": {
    "PushURL": "rtmp://push.example.com/live/unique_stream_id",
    "StreamKey": "generated_stream_key",
    "PullURL": "https://pull.example.com/live/unique_stream_id.flv"
  }
}
```

#### 2. End Live Stream
**Endpoint:** `POST /live/v1/ForbidStream`

#### 3. Get Stream Info
**Endpoint:** `GET /live/v1/DescribeLiveStreamState`

### Authentication
Use BytePlus Access Key and Secret Key (server-side only):
```
AccessKeyId: your_access_key
SecretAccessKey: your_secret_key
```

---

## 🚀 Deployment Checklist

- [ ] All database tables/collections created
- [ ] Indexes added for performance
- [ ] API endpoints implemented and tested
- [ ] BytePlus OpenAPI integration completed
- [ ] Webhook callback endpoint deployed
- [ ] BytePlus callback URL configured in BytePlus console
- [ ] Stream key encryption implemented
- [ ] Access token signing/validation implemented
- [ ] Rate limiting configured
- [ ] Payment flow integrated
- [ ] Commission calculation tested
- [ ] Error logging and monitoring set up
- [ ] API documentation generated (Swagger/OpenAPI)

---

## 📞 Questions for Backend Team

**Please confirm:**
1. Can you implement BytePlus OpenAPI integration?
2. What is the expected timeline for API endpoints?
3. How will you handle webhook signature validation?
4. Will you extend the existing payment system or create new tables?
5. Do you need any additional information about BytePlus MediaLive?

---

## 📚 Resources

- **BytePlus MediaLive Console:** https://console.byteplus.com/medialive
- **BytePlus OpenAPI Docs:** Provided by BytePlus (requires account)
- **BytePlus Server SDKs:** Java, Python, Go, PHP available
- **License File Location:** `~/Downloads/l-1905778193-ch-fcdn_byteplus-a-918011.lic`

---

**Contact Frontend Team if you need clarification on any requirements.**
