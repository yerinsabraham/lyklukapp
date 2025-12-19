# Backend Requirements: BytePlus MediaLive & E-Commerce Integration

**Date:** December 19, 2025 (Updated - Added Missing E-Commerce Endpoints)  
**For:** Backend Development Team  
**Project:** LykLuk Live Streaming + E-Commerce Platform  
**Status:** ⚠️ 14 E-Commerce Endpoints Pending Implementation

---

## 🎯 Overview

This document specifies all backend requirements for:
1. **BytePlus MediaLive** integration for live streaming
2. **Missing E-Commerce Endpoints** that need implementation (Categories, Logistics, Health Check)

Live streaming is implemented as a **premium e-commerce feature** under `/api/v1/ecommerce/live`.

---

## 📑 Table of Contents

### Live Streaming Integration
- [Architecture Decision](#architecture-decision)
- [E-Commerce Integration](#-e-commerce-integration-critical)
  - [Store Subscription Requirements](#store-subscription-requirements)
  - [Store Verification Requirements](#store-verification-requirements)
- [Database Schema Changes](#-database-schema-changes)
  - [live_streams Table](#new-table-live_streams)
  - [live_products Table](#new-table-live_products)
  - [live_viewers Table](#new-table-live_viewers)
- [E-Commerce Integration Requirements](#️-e-commerce-integration-requirements)
  - [Store Subscription Validation](#store-subscription-validation)
  - [Commission Rate Calculation](#commission-rate-calculation)
  - [Product Pinning Validation](#product-pinning-validation)
  - [Order Source Tracking](#order-source-tracking)
  - [Analytics Integration](#analytics-integration)
- [API Endpoints Required](#-api-endpoints-required)
  - [1. Create Live Stream](#1-create-live-stream)
  - [2. Request Stream Access](#2-request-stream-access-viewer)
  - [3. Start Live Stream](#3-start-live-stream)
  - [4. End Live Stream](#4-end-live-stream)
  - [5. Pin Product](#5-pin-product-live-commerce)
  - [6. Get Active Streams](#6-get-active-streams)
  - [7. Get Stream Details](#7-get-stream-details)
  - [8. Purchase Stream Access](#8-purchase-stream-access)
  - [9. Get Replays](#9-get-replays)
  - [10. Check Creator Tier Limits](#10-check-creator-tier-limits)
- [BytePlus Callback Integration](#-byteplus-callback-integration)
- [Payment & Commission Calculation](#-payment--commission-calculation)
- [African Payment Integration](#-african-payment-integration-requirements)
- [Security Requirements](#-security-requirements)
- [Testing Requirements](#-testing-requirements)
- [BytePlus OpenAPI Integration](#-byteplus-openapi-integration)

### Missing E-Commerce Endpoints
- [Missing E-Commerce Endpoints Overview](#-missing-e-commerce-endpoints-not-yet-implemented)
  - [Categories Endpoints (3)](#-categories-3-endpoints---not-implemented)
  - [Logistics & Carriers Endpoints (11)](#-logistics--carriers-11-endpoints---not-implemented)
  - [Health Check Endpoint (1)](#️-health-check-1-endpoint---not-implemented)
- [Implementation Priority](#-implementation-priority)
- [Testing Status](#-testing-status)
- [Backend Team Action Items](#-backend-team-action-items)

### Resources & Deployment
- [Deployment Checklist](#-deployment-checklist)
- [Questions for Backend Team](#-questions-for-backend-team)
- [Resources](#-resources)

---

### Architecture Decision
**Live streaming is NOT a separate service** - it's a module within the e-commerce service:
```
e-commerce/
├── src/
│   ├── store/          # Existing
│   ├── product/        # Existing
│   ├── order/          # Existing
│   ├── subscription/   # Existing
│   └── live/           # NEW: Live streaming module
│       ├── live.controller.ts
│       ├── live.service.ts
│       ├── live.module.ts
│       └── dto/
```

### Core Principles
1. ✅ **Requires verified store** (uses existing StoreKYC)
2. ✅ **Subscription-gated** (FREE can't stream, BASIC+ only)
3. ✅ **Store-based monetization** (uses existing commission rates)
4. ✅ **Product pinning** (references existing products)
5. ✅ **Analytics integration** (extends existing dashboard)
6. ✅ **BytePlus OpenAPI** (server-side stream management)

---

## 🔗 E-Commerce Integration (CRITICAL)

### Store Subscription Requirements

**Live streaming is a PREMIUM feature** - enforced by subscription tier:

| Plan | Monthly Price | Live Streaming | Max Streams/Month | Max Duration | Commission |
|------|--------------|----------------|-------------------|--------------|------------|
| **FREE** | ₦0 | ❌ **BLOCKED** | 0 | - | 10% |
| **BASIC** | ₦9.9 (~$10) | ✅ Allowed | 5 | 1 hour | 7% |
| **CLASSIC** | ₦19.9 (~$20) | ✅ Allowed | Unlimited | 3 hours | 5% |
| **PREMIUM** | ₦34.5 (~$35) | ✅ Allowed | Unlimited | Unlimited | 3% |

**Implementation:**
```typescript
// Check before allowing stream creation
async canCreateLiveStream(storeId: number) {
  const store = await prisma.store.findUnique({
    where: { id: storeId },
    include: { subscription: true }
  })
  
  // 1. Must have verified store
  if (!store?.verified) {
    throw new ForbiddenException('Store must be verified to go live')
  }
  
  // 2. Must have paid plan
  if (store.subscriptionPlan === 'FREE') {
    throw new ForbiddenException(
      'Live streaming requires BASIC plan or higher. Upgrade now!'
    )
  }
  
  // 3. Check monthly limits
  const limits = SUBSCRIPTION_LIMITS[store.subscriptionPlan]
  const thisMonthStreams = await this.countStreamsThisMonth(storeId)
  
  if (limits.maxStreamsPerMonth > 0 && 
      thisMonthStreams >= limits.maxStreamsPerMonth) {
    throw new ForbiddenException(
      `Monthly limit reached (${limits.maxStreamsPerMonth}). Upgrade to CLASSIC!`
    )
  }
  
  return true
}
```

### Store Verification Requirements

**EVERY live stream requires:**
1. ✅ Verified store (StoreKYC approved by admin)
2. ✅ Identity document on file
3. ✅ Active subscription (BASIC or higher)
4. ✅ At least 1 product in store (can pin during stream)

**Why:** Prevents spam, scams, and builds trust

---

## 📊 Database Schema Changes

### New Table: `live_streams`

```prisma
model LiveStream {
  id                    String                @id @default(uuid())
  store                 Store                 @relation(fields: [storeId], references: [id])
  storeId               Int                   // Links to existing Store
  title                 String                @db.VarChar(100)
  description           String?               @db.VarChar(500)
  thumbnailUrl          String?
  
  // Monetization (uses store commission rate)
  monetizationType      LiveMonetizationType  @default(LIVE_COMMERCE)
  price                 Decimal?              @db.Decimal(10, 2)
  currency              String                @default("NGN")
  commissionPercentage  Decimal               // Copied from store subscription
  
  // BytePlus Integration
  byteplusStreamKey     String                @unique
  byteplusPushUrl       String
  byteplusPullUrl       String
  byteplusStreamId      String?
  
  // Stream State
  status                LiveStreamStatus      @default(DRAFT)
  scheduledStartTime    DateTime?
  actualStartTime       DateTime?
  actualEndTime         DateTime?
  
  // Metrics
  currentViewers        Int                   @default(0)
  totalViews            Int                   @default(0)
  peakViewers           Int                   @default(0)
  
  // Settings
  recordingEnabled      Boolean               @default(false)
  recordingUrl          String?
  maxViewers            Int?                  // For MASTERCLASS
  
  createdAt             DateTime              @default(now())
  updatedAt             DateTime              @updatedAt
  
  // Relations
  pinnedProducts        LiveProduct[]
  viewers               LiveViewer[]
  orders                Order[]               // Orders from this stream
  
  @@index([storeId, status])
  @@index([status, actualStartTime])
}

enum LiveMonetizationType {
  FREE              // Free to watch
  LIVE_COMMERCE     // Product sales (main model)
  LIVE_EVENT        // Paid ticket
  MASTERCLASS       // Paid class
  BRAND_SPONSORED   // Sponsored content
}

enum LiveStreamStatus {
  DRAFT
  SCHEDULED
  LIVE
  ENDED
  CANCELLED
}
```

### New Table: `live_products`

```prisma
model LiveProduct {
  id            String      @id @default(uuid())
  liveStream    LiveStream  @relation(fields: [streamId], references: [id])
  streamId      String
  product       Product     @relation(fields: [productId], references: [id])
  productId     Int         // Links to existing Product
  
  pinnedAt      DateTime    @default(now())
  unpinnedAt    DateTime?
  position      Int         @default(0)
  
  // Stream-specific pricing
  specialPrice  Decimal?    @db.Decimal(10, 2)
  soldCount     Int         @default(0)
  
  isActive      Boolean     @default(true)
  
  @@index([streamId, isActive])
  @@index([productId])
}
```

### New Table: `live_viewers`

```prisma
model LiveViewer {
  id         String      @id @default(uuid())
  liveStream LiveStream  @relation(fields: [streamId], references: [id])
  streamId   String
  user       User        @relation(fields: [userId], references: [id])
  userId     Int
  
  joinedAt   DateTime    @default(now())
  leftAt     DateTime?
  duration   Int?        // Seconds watched
  
  // For paid streams
  hasPaid    Boolean     @default(false)
  paymentId  String?
  
  @@unique([streamId, userId])
  @@index([streamId, joinedAt])
}
```

### Update Existing `Order` Model

```prisma
model Order {
  // ... existing fields ...
  
  // NEW: Track live stream sales
  orderSource   String?     // "LIVE_STREAM" or "REGULAR"
  liveStream    LiveStream? @relation(fields: [streamId], references: [id])
  streamId      String?
  
  @@index([orderSource, createdAt])
}
```

### Update Existing `Store` Model

```prisma
model Store {
  // ... existing fields ...
  
  // NEW: Live streaming relation
  liveStreams   LiveStream[]
}
```

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

## 🛒 MISSING E-COMMERCE ENDPOINTS (NOT YET IMPLEMENTED)

**Status:** These 14 endpoints return **404 Not Found** and need to be implemented.

### Base URL: `https://api.lykluk.com`

---

### 📂 CATEGORIES (3 endpoints) - NOT IMPLEMENTED

#### 1. Get All Categories
```
GET /categories
```
**Description:** Get all product categories with hierarchy
**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Electronics",
      "slug": "electronics",
      "parentId": null,
      "icon": "https://...",
      "productCount": 1234,
      "children": [
        {
          "id": 2,
          "name": "Smartphones",
          "slug": "smartphones",
          "parentId": 1,
          "productCount": 456
        }
      ]
    }
  ]
}
```

#### 2. Get Root Categories
```
GET /categories/root
```
**Description:** Get only top-level categories (parentId is null)
**Response:** Same structure as above, but filtered to root categories only

#### 3. Get Category by ID
```
GET /categories/{id}
```
**Description:** Get single category with all details and subcategories
**Response:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "Electronics",
    "slug": "electronics",
    "description": "Electronic devices and accessories",
    "icon": "https://...",
    "productCount": 1234,
    "children": [...],
    "products": [...]
  }
}
```

---

### 🚚 LOGISTICS & CARRIERS (11 endpoints) - NOT IMPLEMENTED

#### 1. Get Available Carriers
```
GET /logistics/carriers
```
**Description:** Get all available shipping carriers
**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "fedex",
      "name": "FedEx",
      "description": "Fast and reliable worldwide shipping",
      "logo": "https://...",
      "deliveryTime": "2-3 days",
      "baseRate": 9.99,
      "supported": true
    }
  ]
}
```

#### 2. Get Carrier Details
```
GET /logistics/carriers/{id}
```
**Description:** Get detailed information about a specific carrier
**Response:**
```json
{
  "success": true,
  "data": {
    "id": "fedex",
    "name": "FedEx",
    "description": "Fast and reliable worldwide shipping",
    "logo": "https://...",
    "features": ["tracking", "insurance", "signature"],
    "deliveryTimes": {
      "domestic": "2-3 days",
      "international": "5-7 days"
    },
    "rates": {
      "base": 9.99,
      "perKg": 2.50
    }
  }
}
```

#### 3. Get Recommended Carriers
```
GET /logistics/carriers/recommend
Query Params: ?weight=5&destination=US&origin=NG
```
**Description:** Get recommended carriers based on order parameters
**Response:**
```json
{
  "success": true,
  "data": {
    "recommended": [
      {
        "carrierId": "fedex",
        "estimatedCost": 25.99,
        "estimatedDays": 3,
        "confidence": 0.95
      }
    ]
  }
}
```

#### 4. Get Store Configured Carriers
```
GET /logistics/stores/{storeId}/carriers
```
**Description:** Get carriers configured for a specific store
**Response:**
```json
{
  "success": true,
  "data": {
    "storeId": 42,
    "carriers": ["fedex", "ups", "dhl"],
    "defaultCarrier": "fedex",
    "preferences": {...}
  }
}
```

#### 5. Add Logistics Preference
```
POST /store/logistics/preferences
Authorization: Bearer <token>
```
**Request Body:**
```json
{
  "name": "Domestic Standard",
  "description": "Standard shipping for domestic orders",
  "carrierId": "fedex",
  "zone": "US",
  "weightLimit": 50,
  "isActive": true
}
```
**Response:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "storeId": 42,
    "name": "Domestic Standard",
    "createdAt": "2025-12-19T10:00:00Z"
  }
}
```

#### 6. Get Store Logistics Preferences
```
GET /store/logistics/preferences
Authorization: Bearer <token>
```
**Description:** Get all logistics preferences for authenticated store
**Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "storeId": 42,
      "name": "Domestic Standard",
      "description": "Standard shipping for domestic orders",
      "carrierId": "fedex",
      "zone": "US",
      "weightLimit": 50,
      "isActive": true
    }
  ]
}
```

#### 7. Update Logistics Preference
```
PUT /store/logistics/preferences/{id}
Authorization: Bearer <token>
```
**Request Body:** Same as Add (partial update supported)
**Response:** Updated preference object

#### 8. Delete Logistics Preference
```
DELETE /store/logistics/preferences/{id}
Authorization: Bearer <token>
```
**Response:**
```json
{
  "success": true,
  "message": "Preference deleted successfully"
}
```

#### 9. Set Preferred Carriers
```
PUT /store/logistics/preferred
Authorization: Bearer <token>
```
**Request Body:**
```json
{
  "carrierIds": ["fedex", "ups", "dhl"]
}
```
**Description:** Set the store's preferred carriers in priority order
**Response:**
```json
{
  "success": true,
  "data": {
    "storeId": 42,
    "preferredCarriers": ["fedex", "ups", "dhl"],
    "updatedAt": "2025-12-19T10:00:00Z"
  }
}
```

---

### ⚕️ HEALTH CHECK (1 endpoint) - NOT IMPLEMENTED

#### Health Check
```
GET /health
```
**Description:** API health status check (for monitoring/DevOps)
**Response:**
```json
{
  "status": "ok",
  "timestamp": "2025-12-19T10:00:00Z",
  "services": {
    "database": "healthy",
    "redis": "healthy",
    "storage": "healthy"
  },
  "version": "1.0.0"
}
```

---

## 📊 Implementation Priority

### HIGH PRIORITY (Needed for MVP):
1. ✅ **Categories** - Required for product browsing/filtering
2. ✅ **Health Check** - Required for monitoring

### MEDIUM PRIORITY (Enhance UX):
3. ✅ **Basic Logistics** - Get carriers, store carriers
4. ⚠️ **Carrier Recommendations** - Nice to have (can use basic selection first)

### LOW PRIORITY (Advanced Features):
5. ⚠️ **Logistics Preferences** - Can be added after MVP
6. ⚠️ **Preferred Carriers** - Store configuration feature

---

## 🧪 Testing Status

| Endpoint Group | Status | Test Date | Result |
|----------------|--------|-----------|--------|
| Store Management | ✅ Working | 2025-12-19 | 401 (Authenticated) |
| Product Management | ✅ Working | 2025-12-19 | 401 (Authenticated) |
| Cart | ✅ Working | 2025-12-19 | 401 (Authenticated) |
| Orders | ✅ Working | 2025-12-19 | 401 (Authenticated) |
| Subscriptions | ✅ Working | 2025-12-19 | 401 (Authenticated) |
| Social | ✅ Working | 2025-12-19 | 401 (Authenticated) |
| Recommendations | ✅ Working | 2025-12-19 | 401 (Authenticated) |
| Analytics | ✅ Working | 2025-12-19 | 401 (Authenticated) |
| Addresses | ✅ Working | 2025-12-19 | 401 (Authenticated) |
| **Categories** | ❌ Not Implemented | 2025-12-19 | **404** |
| **Logistics** | ❌ Not Implemented | 2025-12-19 | **404** |
| **Health Check** | ❌ Not Implemented | 2025-12-19 | **404** |

**Note:** 401 responses mean endpoints exist and require authentication (working correctly). 404 means endpoints don't exist yet.

---

## 📋 Backend Team Action Items

### Immediate (This Week):
- [ ] Implement `/categories` endpoints (3 endpoints)
- [ ] Implement `/health` endpoint (1 endpoint)
- [ ] Add category seeding/migration with basic categories

### Next Sprint:
- [ ] Implement basic `/logistics/carriers` endpoints (2 endpoints)
- [ ] Implement `/logistics/stores/{id}/carriers` endpoint
- [ ] Add carrier configuration to store settings

### Future (Post-MVP):
- [ ] Implement logistics preferences endpoints (5 endpoints)
- [ ] Implement carrier recommendation algorithm
- [ ] Add rate calculation API

---

**Contact Frontend Team if you need clarification on any requirements.**
