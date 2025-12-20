# Backend Requirements: BytePlus MediaLive Integration

**Date:** December 20, 2025  
**For:** Backend Development Team  
**Project:** LykLuk Live Streaming Platform (Multi-Purpose: Commerce, Social, Podcasts)  
**Status:** ⚠️ MediaLive Core Module Pending Implementation

---

## 🎯 Overview

This document specifies backend requirements for **BytePlus MediaLive integration** - a **unified live streaming infrastructure** that supports multiple use cases:

1. **Live Commerce** - Store owners selling products via livestream
2. **Social Live** - Users going live for social engagement (like Instagram/TikTok Live)
3. **Podcasts** - Audio-only live sessions and recordings (future)

### Architecture Philosophy

**MediaLive is a STANDALONE MODULE** that provides streaming infrastructure:
```
Backend Services:
├── /live/*              ← Core MediaLive service (SHARED INFRASTRUCTURE)
│   ├── BytePlus integration
│   ├── Stream management
│   ├── Viewer access control
│   └── Recording & replays
│
├── /ecommerce/*         ← E-commerce features
│   └── Uses /live/* for commerce streams
│
└── /social/*            ← Social features  
    └── Uses /live/* for social streams
```

**Key Principle:** One BytePlus account, multiple stream types, different authorization rules.

---

## 🏗️ Architecture Layers Explained

```
┌─────────────────────────────────────────────────────────────────┐
│  FLUTTER APP (Frontend)                                         │
├─────────────────────────────────────────────────────────────────┤
│  lib/modules/live_stream/                                       │
│  └─ Calls API Routes via HTTP/WebSocket                        │
└─────────────────────────────────────────────────────────────────┘
                          ↓ HTTP Requests
┌─────────────────────────────────────────────────────────────────┐
│  API ROUTES (Backend Endpoints)                                 │
├─────────────────────────────────────────────────────────────────┤
│  /live/*                  ← Core streaming (ALL types)          │
│  /live/commerce/*         ← Store features (COMMERCE only)      │
│  /live/social/*           ← Social features (SOCIAL only)       │
└─────────────────────────────────────────────────────────────────┘
                          ↓ Business Logic
┌─────────────────────────────────────────────────────────────────┐
│  SERVICES (Backend Code)                                        │
├─────────────────────────────────────────────────────────────────┤
│  live.service.ts          ← Stream management logic             │
│  byteplus.service.ts      ← BytePlus API calls                 │
│  commerce-live.service.ts ← Product pinning, sales tracking    │
│  social-live.service.ts   ← Gifts, comments, engagement        │
└─────────────────────────────────────────────────────────────────┘
                          ↓ Database Queries
┌─────────────────────────────────────────────────────────────────┐
│  DATABASE TABLES (Storage)                                      │
├─────────────────────────────────────────────────────────────────┤
│  live_streams       ← Metadata (ALL types)                      │
│  live_viewers       ← Viewer tracking (ALL types)               │
│  live_payments      ← Transactions (ALL types)                  │
│  live_analytics     ← Metrics (ALL types)                       │
│  live_comments      ← Chat (ALL types)                          │
│  live_products      ← Product pins (COMMERCE only)              │
│  live_gifts         ← Virtual gifts (SOCIAL only)               │
└─────────────────────────────────────────────────────────────────┘
```

### Example Flow: User Creates Commerce Stream

```
1. Flutter App calls:
   POST /live/create
   {
     "streamType": "COMMERCE",
     "storeId": 123,
     "title": "Flash Sale"
   }

2. Backend validates:
   - Check user owns store (query: stores table)
   - Check store verified (query: stores table)
   - Check subscription (query: /ecommerce/subscription/*)
   
3. Backend calls BytePlus API:
   - Get push URL and stream key
   
4. Backend stores in database:
   INSERT INTO live_streams (
     stream_type = 'COMMERCE',
     creator_store_id = 123,
     title = 'Flash Sale',
     ...
   )
   
5. Backend returns to Flutter:
   {
     "streamId": "uuid",
     "pushUrl": "rtmp://...",
     "streamKey": "abc123"
   }
```

### Example: User Pins Product During Stream

```
1. Flutter App calls:
   POST /live/{streamId}/pin-product
   { "productId": 456 }

2. Backend uses MULTIPLE tables:
   - Query live_streams (check stream exists, is COMMERCE type)
   - Query products (get product details from /ecommerce/products)
   - INSERT INTO live_products (streamId, productId, ...)
   
3. Backend broadcasts via WebSocket:
   → All viewers see product card appear
```

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

### Additional Requirements
- [Categories Endpoints (3)](#-categories-3-endpoints---needed-for-content-organization)
- [Health Check Endpoint (1)](#️-health-check-1-endpoint---for-monitoring)
- [Implementation Priority](#-implementation-priority)
- [Backend Team Action Items](#-backend-team-action-items)

### Resources & Deployment
- [Deployment Checklist](#-deployment-checklist)
- [Questions for Backend Team](#-questions-for-backend-team)
- [Resources](#-resources)

---

### Architecture Decision

**MediaLive is a STANDALONE service/module:**

```
Backend Architecture:

1. CORE LIVE MODULE (/live/*)
   ├── live.controller.ts
   ├── live.service.ts
   ├── byteplus.service.ts      ← BytePlus OpenAPI integration
   ├── stream.repository.ts
   └── dto/
       ├── create-stream.dto.ts
       ├── stream-access.dto.ts
       └── stream-response.dto.ts

2. COMMERCE INTEGRATION (/ecommerce/live/* or /live/commerce/*)
   ├── commerce-live.controller.ts
   ├── commerce-live.service.ts
   └── Uses /live/* core + adds:
       - Store verification checks
       - Subscription validation
       - Product pinning
       - Commission tracking

3. SOCIAL INTEGRATION (/social/live/* or /live/social/*)
   ├── social-live.controller.ts
   ├── social-live.service.ts
   └── Uses /live/* core + adds:
       - Follower notifications
       - Virtual gifts
       - Live comments
       - Social graph integration

4. PODCAST INTEGRATION (future: /live/podcast/*)
   ├── podcast-live.controller.ts
   └── Uses /live/* core + adds:
       - Audio-only mode
       - RSS feed generation
       - Episode management
```

### Stream Type Differentiation

Each stream has a `streamType` field:

```typescript
enum StreamType {
  COMMERCE = 'COMMERCE',  // Store owner selling products
  SOCIAL = 'SOCIAL',      // User going live for engagement
  PODCAST = 'PODCAST',    // Audio-only session
}
```

**Authorization rules vary by type:**
- **COMMERCE**: Requires verified store + paid subscription
- **SOCIAL**: Any verified user can go live
- **PODCAST**: Verified creators only (future)

### Database Schema

```sql
CREATE TABLE live_streams (
  id UUID PRIMARY KEY,
  stream_type VARCHAR(20) NOT NULL,  -- 'COMMERCE' | 'SOCIAL' | 'PODCAST'
  
  -- Creator (flexible - can be user OR store)
  creator_user_id UUID,              -- For social/podcast
  creator_store_id INT,              -- For commerce
  
  -- Stream details
  title VARCHAR(255) NOT NULL,
  description TEXT,
  thumbnail_url VARCHAR(500),
  
  -- BytePlus credentials
  byteplus_stream_key VARCHAR(255),
  byteplus_push_url VARCHAR(500),
  byteplus_pull_url VARCHAR(500),
  
  -- Status
  status VARCHAR(20) NOT NULL,       -- 'DRAFT' | 'LIVE' | 'ENDED'
  scheduled_start_time TIMESTAMP,
  actual_start_time TIMESTAMP,
  actual_end_time TIMESTAMP,
  
  -- Monetization (varies by type)
  monetization_type VARCHAR(50),
  price DECIMAL(10, 2),
  currency VARCHAR(3),
  
  -- Analytics
  current_viewers INT DEFAULT 0,
  total_views INT DEFAULT 0,
  peak_viewers INT DEFAULT 0,
  
  -- Recording
  recording_enabled BOOLEAN DEFAULT false,
  recording_url VARCHAR(500),
  
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  
  -- Constraints
  CONSTRAINT check_creator CHECK (
    (creator_user_id IS NOT NULL AND creator_store_id IS NULL AND stream_type IN ('SOCIAL', 'PODCAST'))
    OR
    (creator_store_id IS NOT NULL AND creator_user_id IS NULL AND stream_type = 'COMMERCE')
  )
);
```

---

## 📍 Quick Reference: Routes vs Tables

**To answer "which subdomain are live_streams, live_viewers, live_payments implemented?"**

👉 **These are DATABASE TABLES, not subdomains or API routes!**

They're stored in PostgreSQL/MySQL on the backend server. The frontend never calls them directly.

### Here's What the Frontend Actually Calls:

| What User Sees | Frontend Calls (Route) | Database Tables Used |
|----------------|------------------------|---------------------|
| Create commerce stream | `POST https://api.lykluk.com/live/create` | `live_streams` |
| Create social stream | `POST https://api.lykluk.com/live/create` | `live_streams` |
| Watch live stream | `GET https://api.lykluk.com/live/{id}` | `live_streams`, `live_viewers` |
| Pin product | `POST https://api.lykluk.com/live/commerce/{id}/pin-product` | `live_products`, `live_streams` |
| Send gift | `POST https://api.lykluk.com/live/social/{id}/gift` | `live_gifts`, `live_payments` |
| Send comment | `POST https://api.lykluk.com/live/{id}/comment` | `live_comments` |
| View analytics | `GET https://api.lykluk.com/live/{id}/analytics` | `live_analytics`, `live_streams` |
| Buy event ticket | `POST https://api.lykluk.com/live/{id}/purchase` | `live_payments`, `live_viewers` |

### ⚡ Key Points:

1. **There's only ONE domain:** `https://api.lykluk.com`
2. **All live features use `/live/*` routes** (no separate subdomains)
3. **Database tables are shared** by ALL stream types (commerce, social, podcast)
4. **The `stream_type` column** differentiates between stream types in the database
5. **Tables are INTERNAL** - your Flutter app never sees them, only the backend does

### Architecture:

```
Flutter App
    ↓ (calls)
https://api.lykluk.com/live/create
    ↓ (processed by)
Backend Service (live.service.ts)
    ↓ (queries/inserts)
Database Table: live_streams
```

**No subdomains involved!** Everything is at `api.lykluk.com/live/*` and stores to the same database.

---

## � Core API Endpoints (Shared Infrastructure)

**Base:** `/live/*` (stream type agnostic)

### 1. Create Stream (Universal)
```
POST /live/create
Authorization: Bearer <user_token>
```

**Request:**
```json
{
  "streamType": "COMMERCE" | "SOCIAL" | "PODCAST",
  "title": "My Live Stream",
  "description": "Stream description",
  "thumbnailUrl": "https://...",
  "monetizationType": "FREE" | "LIVE_COMMERCE" | "LIVE_EVENT" | "MASTERCLASS",
  "price": 9.99,              // Optional
  "currency": "NGN",
  "recordingEnabled": true,
  "scheduledStartTime": "2025-12-20T19:00:00Z",
  
  // Type-specific fields
  "storeId": 123,             // Required if streamType = COMMERCE
  "maxViewers": 100           // Optional for MASTERCLASS
}
```

**Business Logic:**
```typescript
async createStream(userId: string, dto: CreateStreamDto) {
  // 1. Validate based on stream type
  if (dto.streamType === 'COMMERCE') {
    // Check user owns store
    await this.validateStoreOwnership(userId, dto.storeId);
    // Check store is verified
    await this.validateStoreVerified(dto.storeId);
    // Check subscription tier
    await this.validateSubscription(dto.storeId);
  } else if (dto.streamType === 'SOCIAL') {
    // Check user is verified
    await this.validateUserVerified(userId);
    // Optional: Check user reputation/limits
  }
  
  // 2. Call BytePlus API to get stream credentials
  const byteplusResponse = await this.byteplusService.createLiveStream({
    streamId: generateUniqueId(),
  });
  
  // 3. Store in database
  const stream = await this.streamRepository.create({
    ...dto,
    creatorUserId: dto.streamType === 'SOCIAL' ? userId : null,
    creatorStoreId: dto.streamType === 'COMMERCE' ? dto.storeId : null,
    byteplusStreamKey: byteplusResponse.streamKey,
    byteplusPushUrl: byteplusResponse.pushUrl,
    byteplusPullUrl: byteplusResponse.pullUrl,
    status: 'DRAFT',
  });
  
  return {
    streamId: stream.id,
    pushUrl: stream.byteplusPushUrl,
    streamKey: stream.byteplusStreamKey,
    status: stream.status,
  };
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "streamId": "uuid",
    "pushUrl": "rtmp://push.byteplus.com/live/abc123",
    "streamKey": "secret_key_xyz",
    "status": "DRAFT",
    "expiresAt": "2025-12-21T19:00:00Z"
  }
}
```

---

### 2. Start Stream
```
POST /live/{streamId}/start
Authorization: Bearer <user_token>
```

**Logic:**
- Verify user is the stream creator
- Update status to LIVE
- Notify followers/store followers (based on stream type)
- Return pull URL for viewers

---

### 3. End Stream
```
POST /live/{streamId}/end
Authorization: Bearer <user_token>
```

**Logic:**
- Verify user is the stream creator
- Call BytePlus API to stop stream
- Update status to ENDED
- Trigger recording processing (if enabled)
- Calculate analytics

---

### 4. Get Active Streams
```
GET /live/active?type=COMMERCE|SOCIAL&page=1&limit=20
```

**Response:**
```json
{
  "success": true,
  "data": {
    "streams": [
      {
        "streamId": "uuid",
        "streamType": "COMMERCE",
        "title": "Flash Sale Live",
        "thumbnailUrl": "https://...",
        "creatorName": "Fashion Store",
        "creatorAvatar": "https://...",
        "currentViewers": 234,
        "monetizationType": "LIVE_COMMERCE"
      },
      {
        "streamId": "uuid2",
        "streamType": "SOCIAL",
        "title": "Just Chatting",
        "creatorName": "John Doe",
        "currentViewers": 45,
        "monetizationType": "FREE"
      }
    ],
    "pagination": {
      "total": 15,
      "page": 1,
      "limit": 20
    }
  }
}
```

---

### 5. Get Stream Details
```
GET /live/{streamId}
```

**Response includes type-specific data:**
```json
{
  "success": true,
  "data": {
    "streamId": "uuid",
    "streamType": "COMMERCE",
    "title": "Live Sale",
    "description": "...",
    "status": "LIVE",
    "currentViewers": 234,
    "monetizationType": "LIVE_COMMERCE",
    
    // COMMERCE-specific fields
    "storeId": 123,
    "storeName": "Fashion Hub",
    "pinnedProduct": {
      "id": 456,
      "name": "T-Shirt",
      "price": 29.99,
      "imageUrl": "https://..."
    },
    
    // SOCIAL-specific fields (if type=SOCIAL)
    "creatorUserId": "uuid",
    "creatorFollowers": 1200
  }
}
```

---

## 🛒 Commerce-Specific Endpoints

**Base:** `/live/commerce/*` or `/ecommerce/live/*`

### Pin Product During Stream
```
POST /live/{streamId}/pin-product
Authorization: Bearer <store_owner_token>
```

**Request:**
```json
{
  "productId": 456
}
```

**Validation:**
- Stream must be type COMMERCE
- User must own the store
- Product must belong to the store

---

### Get Commerce Stream Analytics
```
GET /live/commerce/{streamId}/analytics
Authorization: Bearer <store_owner_token>
```

**Response:**
```json
{
  "success": true,
  "data": {
    "totalRevenue": 1250.00,
    "orderCount": 23,
    "averageOrderValue": 54.35,
    "productsSold": [
      {"productId": 456, "name": "T-Shirt", "quantity": 12, "revenue": 359.88}
    ],
    "viewerEngagement": {
      "peakViewers": 345,
      "averageWatchTime": "4m 32s"
    }
  }
}
```

---

## � API Response Requirements - What Frontend Needs

### 1. Create Stream Response

**POST /live/create → Must return:**

```json
{
  "success": true,
  "data": {
    "streamId": "uuid",                    // For all subsequent API calls
    "pushUrl": "rtmp://push.example.com/live/abc123",
    "streamKey": "secret_key_xyz",         // SENSITIVE - handle securely
    "pullUrl": "https://pull.example.com/live/abc123.flv",
    "status": "DRAFT",
    "monetizationType": "LIVE_COMMERCE",
    "expiresAt": "2025-12-21T19:00:00Z",
    
    // Metadata for UI
    "title": "My Live Stream",
    "thumbnailUrl": "https://...",
    
    // For analytics display
    "streamType": "COMMERCE",
    "currentViewers": 0,
    "totalViews": 0
  }
}
```

---

### 2. Get Stream Details Response

**GET /live/{streamId} → Must return complete metadata:**

```json
{
  "success": true,
  "data": {
    // Core Info
    "streamId": "uuid",
    "streamType": "COMMERCE" | "SOCIAL" | "PODCAST",
    "title": "Flash Sale Live",
    "description": "20% off everything!",
    "thumbnailUrl": "https://...",
    "status": "LIVE",
    
    // Timing
    "scheduledStartTime": "2025-12-20T19:00:00Z",
    "actualStartTime": "2025-12-20T19:02:15Z",
    "actualEndTime": null,
    "streamDurationSeconds": 3600,
    
    // Creator Info (type-dependent)
    "creator": {
      // For COMMERCE streams:
      "type": "store",
      "storeId": 123,
      "storeName": "Fashion Hub",
      "storeAvatar": "https://...",
      "storeVerified": true,
      
      // For SOCIAL streams:
      "type": "user",
      "userId": "uuid",
      "username": "johndoe",
      "displayName": "John Doe",
      "avatar": "https://...",
      "verified": true,
      "followerCount": 1200
    },
    
    // Real-time Metrics
    "currentViewers": 234,
    "totalViews": 1520,
    "peakViewers": 345,
    "totalLikes": 450,
    "totalComments": 89,
    
    // Monetization
    "monetizationType": "LIVE_COMMERCE",
    "price": 9.99,
    "currency": "NGN",
    "requiresPayment": false,
    
    // Viewer's Access (if authenticated)
    "viewerAccess": {
      "hasAccess": true,
      "accessType": "FREE",
      "joinedAt": "2025-12-20T19:05:00Z",
      "watchDurationSeconds": 180
    },
    
    // Stream URLs
    "pullUrl": "https://pull.example.com/live/abc123.flv",  // HLS/FLV URL
    
    // COMMERCE-specific fields
    "pinnedProduct": {
      "productId": 456,
      "name": "Cotton T-Shirt",
      "description": "Comfortable cotton tee",
      "price": 29.99,
      "specialPrice": 23.99,
      "discountPercentage": 20,
      "imageUrl": "https://...",
      "inStock": true,
      "stockCount": 50
    },
    
    // Settings
    "recordingEnabled": true,
    "allowComments": true,
    "allowGifts": true,
    "maxViewers": null,
    
    // Category & Discovery
    "categoryId": 2,
    "categoryName": "Fashion",
    "tags": ["fashion", "sale", "clothing"],
    "language": "en"
  }
}
```

---

### 3. Get Active Streams Response

**GET /live/active?type=COMMERCE&page=1&limit=20 → Must return list with preview data:**

```json
{
  "success": true,
  "data": {
    "streams": [
      {
        "streamId": "uuid",
        "streamType": "COMMERCE",
        "title": "Flash Sale Live",
        "description": "Short preview...",
        "thumbnailUrl": "https://...",
        "status": "LIVE",
        
        // Creator preview
        "creator": {
          "name": "Fashion Hub",
          "avatar": "https://...",
          "verified": true
        },
        
        // Metrics for discovery
        "currentViewers": 234,
        "totalViews": 1520,
        "startedAt": "2025-12-20T19:00:00Z",
        
        // Monetization
        "monetizationType": "LIVE_COMMERCE",
        "isFree": true,
        
        // Preview info
        "categoryName": "Fashion",
        "tags": ["sale", "clothing"],
        "language": "en"
      }
    ],
    "pagination": {
      "total": 45,
      "page": 1,
      "limit": 20,
      "totalPages": 3
    }
  }
}
```

---

### 4. Stream Analytics Response

**GET /live/{streamId}/analytics → Must return comprehensive metrics:**

```json
{
  "success": true,
  "data": {
    // Overview
    "streamId": "uuid",
    "streamType": "COMMERCE",
    "status": "ENDED",
    "duration": "1h 15m",
    
    // Viewer Metrics
    "viewers": {
      "total": 1520,
      "unique": 890,
      "peak": 345,
      "average": 210,
      "averageWatchTime": "4m 32s",
      "totalWatchTime": "95h 12m"
    },
    
    // Engagement
    "engagement": {
      "totalLikes": 450,
      "totalComments": 289,
      "totalShares": 34,
      "engagementRate": 15.2  // Percentage
    },
    
    // Geographic Distribution
    "geography": {
      "topCountries": [
        {"code": "NG", "name": "Nigeria", "viewers": 650},
        {"code": "GH", "name": "Ghana", "viewers": 120},
        {"code": "KE", "name": "Kenya", "viewers": 80}
      ],
      "topCities": [
        {"name": "Lagos", "viewers": 450},
        {"name": "Accra", "viewers": 95}
      ]
    },
    
    // Devices
    "devices": {
      "mobile": 75,       // Percentage
      "desktop": 20,
      "tablet": 5
    },
    
    // Revenue (COMMERCE only)
    "revenue": {
      "totalRevenue": 1250.50,
      "totalOrders": 23,
      "averageOrderValue": 54.37,
      "conversionRate": 2.6,  // (orders / viewers) * 100
      "productsSold": [
        {
          "productId": 456,
          "name": "Cotton T-Shirt",
          "quantitySold": 12,
          "revenue": 287.88,
          "viewCount": 890,
          "clickCount": 234,
          "conversionRate": 5.1
        }
      ]
    },
    
    // Gifts (SOCIAL only)
    "gifts": {
      "totalGifts": 145,
      "totalValue": 450.00,
      "currency": "NGN",
      "topGiftTypes": [
        {"type": "rose", "count": 45, "value": 135.00},
        {"type": "heart", "count": 100, "value": 100.00}
      ],
      "topSenders": [
        {
          "userId": "uuid",
          "username": "viewer123",
          "giftsSent": 25,
          "totalValue": 75.00
        }
      ]
    },
    
    // Timeline (hourly breakdown)
    "timeline": [
      {
        "hour": "19:00",
        "viewers": 120,
        "engagement": 34,
        "revenue": 125.50
      },
      {
        "hour": "20:00",
        "viewers": 345,
        "engagement": 89,
        "revenue": 487.25
      }
    ]
  }
}
```

---

### 5. Viewer Access Request Response

**POST /live/{streamId}/access → Must return access decision:**

```json
{
  "success": true,
  "data": {
    "streamId": "uuid",
    "accessGranted": true,
    "accessType": "FREE",        // 'FREE', 'PAID', 'GIFT'
    
    // Stream URLs (if access granted)
    "pullUrl": "https://pull.example.com/live/abc123.flv",
    "pullUrlHLS": "https://pull.example.com/live/abc123.m3u8",
    "pullUrlFLV": "https://pull.example.com/live/abc123.flv",
    
    // Access token for authenticated viewing
    "accessToken": "jwt_token",
    "expiresAt": "2025-12-20T21:00:00Z",
    
    // Stream info
    "title": "Flash Sale Live",
    "status": "LIVE",
    "startedAt": "2025-12-20T19:00:00Z"
  }
}
```

**If payment required:**
```json
{
  "success": false,
  "error": {
    "code": "PAYMENT_REQUIRED",
    "message": "This stream requires payment to access",
    "paymentDetails": {
      "price": 9.99,
      "currency": "NGN",
      "paymentUrl": "/live/uuid/purchase"
    }
  }
}
```

---

### 6. Get Viewer List Response

**GET /live/{streamId}/viewers → For creator/moderator:**

```json
{
  "success": true,
  "data": {
    "totalViewers": 234,
    "activeViewers": 210,
    "viewers": [
      {
        "userId": "uuid",
        "username": "johndoe",
        "displayName": "John Doe",
        "avatar": "https://...",
        "joinedAt": "2025-12-20T19:05:00Z",
        "watchDuration": "15m 30s",
        "isActive": true,
        "totalComments": 5,
        "totalGifts": 3,
        "totalSpent": 15.00
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 50,
      "total": 210
    }
  }
}
```

---

### 7. Payment Transaction Response

**POST /live/{streamId}/purchase → Must return payment result:**

```json
{
  "success": true,
  "data": {
    "paymentId": "uuid",
    "transactionId": "TXN123456",
    "status": "COMPLETED",
    "amount": 9.99,
    "currency": "NGN",
    
    // Access credentials
    "accessGranted": true,
    "accessToken": "jwt_token",
    "pullUrl": "https://pull.example.com/live/abc123.flv",
    "expiresAt": "2025-12-20T21:00:00Z",
    
    // Receipt
    "receipt": {
      "paymentMethod": "card",
      "last4": "4242",
      "paidAt": "2025-12-20T19:10:00Z"
    }
  }
}
```

---

### 8. Live Comments Response (Real-time)

**GET /live/{streamId}/comments?page=1&limit=50:**

```json
{
  "success": true,
  "data": {
    "comments": [
      {
        "commentId": "uuid",
        "userId": "uuid",
        "username": "johndoe",
        "displayName": "John Doe",
        "avatar": "https://...",
        "message": "Great stream!",
        "messageType": "TEXT",
        "likeCount": 12,
        "isPinned": false,
        "createdAt": "2025-12-20T19:15:23Z",
        
        // Mentions
        "mentions": [
          {"userId": "uuid2", "username": "jane"}
        ]
      }
    ],
    "pagination": {
      "total": 289,
      "page": 1,
      "limit": 50
    }
  }
}
```

---

## 🔄 Real-time Updates (WebSocket/SSE)

**Frontend needs real-time updates for:**

### 1. Viewer Count Updates
```json
{
  "type": "VIEWER_COUNT_UPDATE",
  "streamId": "uuid",
  "data": {
    "currentViewers": 245,
    "change": +5
  }
}
```

### 2. New Comments
```json
{
  "type": "NEW_COMMENT",
  "streamId": "uuid",
  "data": {
    "commentId": "uuid",
    "userId": "uuid",
    "username": "johndoe",
    "message": "Awesome!",
    "createdAt": "2025-12-20T19:15:23Z"
  }
}
```

### 3. Product Pinned (COMMERCE)
```json
{
  "type": "PRODUCT_PINNED",
  "streamId": "uuid",
  "data": {
    "productId": 456,
    "name": "Cotton T-Shirt",
    "price": 29.99,
    "specialPrice": 23.99,
    "imageUrl": "https://..."
  }
}
```

### 4. Gift Sent (SOCIAL)
```json
{
  "type": "GIFT_SENT",
  "streamId": "uuid",
  "data": {
    "giftId": "uuid",
    "senderId": "uuid",
    "senderName": "johndoe",
    "giftType": "rose",
    "quantity": 5,
    "animation": "rose_shower"
  }
}
```

### 5. Stream Status Change
```json
{
  "type": "STREAM_STATUS_CHANGE",
  "streamId": "uuid",
  "data": {
    "oldStatus": "DRAFT",
    "newStatus": "LIVE",
    "startedAt": "2025-12-20T19:00:00Z"
  }
}
```

---

## �👥 Social-Specific Endpoints

**Base:** `/live/social/*` or `/social/live/*`

### Send Virtual Gift
```
POST /live/{streamId}/gift
Authorization: Bearer <viewer_token>
```

**Request:**
```json
{
  "giftType": "heart" | "star" | "diamond",
  "quantity": 10
}
```

---

### Get Live Comments
```
GET /live/{streamId}/comments?page=1&limit=50
```

**Response:**
```json
{
  "success": true,
  "data": {
    "comments": [
      {
        "id": "uuid",
        "userId": "uuid",
        "username": "johndoe",
        "avatar": "https://...",
        "message": "Great stream!",
        "timestamp": "2025-12-20T19:15:23Z"
      }
    ]
  }
}
```

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

## 📊 Database Schema - Complete

> **IMPORTANT:** Database tables are backend storage, NOT API routes!
> 
> - **Tables** = Where backend stores data (PostgreSQL/MySQL)
> - **Routes** = API endpoints frontend calls (`/live/*`, `/live/commerce/*`)
> 
> One route can access multiple tables, and one table can serve multiple routes.

---

## 🗺️ Route → Table Mapping

Here's which API routes use which database tables:

### Core Routes (`/live/*`) - Universal endpoints

| API Route | Database Tables Used | Purpose |
|-----------|---------------------|---------|
| `POST /live/create` | `live_streams` | Create stream record |
| `POST /live/{id}/start` | `live_streams` | Update status to LIVE |
| `POST /live/{id}/end` | `live_streams`, `live_analytics` | End stream, calculate analytics |
| `GET /live/active` | `live_streams` | Query active streams |
| `GET /live/{id}` | `live_streams`, `live_viewers`, `live_comments` | Get full stream details |
| `POST /live/{id}/access` | `live_streams`, `live_viewers`, `live_payments` | Grant/check viewer access |
| `GET /live/{id}/analytics` | `live_analytics`, `live_streams` | Get aggregated metrics |

### Commerce Routes (`/live/commerce/*`) - Store owner features

| API Route | Database Tables Used | Purpose |
|-----------|---------------------|---------|
| `POST /live/{id}/pin-product` | `live_products`, `live_streams` | Pin product during stream |
| `GET /live/commerce/{id}/analytics` | `live_analytics`, `live_products`, `orders` | Commerce-specific metrics |
| `GET /live/commerce/{id}/sales` | `orders`, `live_products` | Real-time sales tracking |

### Social Routes (`/live/social/*`) - User engagement features

| API Route | Database Tables Used | Purpose |
|-----------|---------------------|---------|
| `POST /live/{id}/gift` | `live_gifts`, `live_payments`, `live_streams` | Send virtual gift |
| `POST /live/{id}/comment` | `live_comments`, `live_streams` | Post comment |
| `GET /live/{id}/comments` | `live_comments` | Get chat history |
| `GET /live/social/{id}/gifts` | `live_gifts` | Get gift leaderboard |

### All Stream Types Use These Tables:

- **`live_streams`** - Core metadata (title, status, creator) - ALL streams
- **`live_viewers`** - Who's watching - ALL streams  
- **`live_analytics`** - Metrics - ALL streams
- **`live_comments`** - Chat messages - ALL streams (if enabled)
- **`live_payments`** - Transactions - ALL paid features

### Type-Specific Tables:

- **`live_products`** - ONLY used by COMMERCE streams
- **`live_gifts`** - ONLY used by SOCIAL streams

---

### 1. Core Table: `live_streams`

**Stores all stream metadata and state:**

```sql
CREATE TABLE live_streams (
  -- Identity
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stream_type VARCHAR(20) NOT NULL CHECK (stream_type IN ('COMMERCE', 'SOCIAL', 'PODCAST')),
  
  -- Creator (flexible - user OR store)
  creator_user_id UUID,                    -- For SOCIAL/PODCAST streams
  creator_store_id INT,                    -- For COMMERCE streams
  
  -- Metadata
  title VARCHAR(255) NOT NULL,
  description TEXT,
  thumbnail_url VARCHAR(500),
  category_id INT REFERENCES categories(id),
  tags TEXT[],                             -- Array of tags
  language VARCHAR(10) DEFAULT 'en',       -- Stream language
  
  -- BytePlus Integration (secure credentials)
  byteplus_stream_id VARCHAR(255) UNIQUE NOT NULL,
  byteplus_stream_key VARCHAR(255) NOT NULL,  -- ENCRYPTED
  byteplus_push_url VARCHAR(500) NOT NULL,
  byteplus_pull_url VARCHAR(500) NOT NULL,
  
  -- Stream Status & Timing
  status VARCHAR(20) NOT NULL DEFAULT 'DRAFT' CHECK (status IN ('DRAFT', 'SCHEDULED', 'LIVE', 'ENDED', 'CANCELLED')),
  scheduled_start_time TIMESTAMP,
  actual_start_time TIMESTAMP,
  actual_end_time TIMESTAMP,
  stream_duration_seconds INT,             -- Calculated on end
  
  -- Monetization
  monetization_type VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2),
  currency VARCHAR(3) DEFAULT 'NGN',
  commission_percentage DECIMAL(5, 2),     -- Store's rate
  total_revenue DECIMAL(10, 2) DEFAULT 0,  -- Running total
  
  -- Analytics Counters
  current_viewers INT DEFAULT 0,
  total_views INT DEFAULT 0,
  peak_viewers INT DEFAULT 0,
  unique_viewers INT DEFAULT 0,
  total_watch_time_seconds BIGINT DEFAULT 0,
  average_watch_time_seconds INT DEFAULT 0,
  
  -- Engagement Metrics
  total_likes INT DEFAULT 0,
  total_comments INT DEFAULT 0,
  total_shares INT DEFAULT 0,
  total_gifts_received INT DEFAULT 0,      -- For social streams
  
  -- Commerce Metrics (COMMERCE type only)
  total_orders INT DEFAULT 0,
  total_products_sold INT DEFAULT 0,
  conversion_rate DECIMAL(5, 2),           -- (orders / views) * 100
  
  -- Recording
  recording_enabled BOOLEAN DEFAULT false,
  recording_status VARCHAR(20),            -- 'PROCESSING', 'READY', 'FAILED'
  recording_url VARCHAR(500),
  recording_duration_seconds INT,
  
  -- Settings
  max_viewers INT,                         -- For MASTERCLASS
  is_public BOOLEAN DEFAULT true,
  allow_comments BOOLEAN DEFAULT true,
  allow_gifts BOOLEAN DEFAULT true,
  moderation_mode VARCHAR(20) DEFAULT 'AUTO',
  
  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP,                    -- Soft delete
  
  -- Constraints
  CONSTRAINT check_creator CHECK (
    (creator_user_id IS NOT NULL AND creator_store_id IS NULL AND stream_type IN ('SOCIAL', 'PODCAST'))
    OR
    (creator_store_id IS NOT NULL AND creator_user_id IS NULL AND stream_type = 'COMMERCE')
  )
);

-- Indexes for performance
CREATE INDEX idx_live_streams_status ON live_streams(status, actual_start_time DESC);
CREATE INDEX idx_live_streams_creator_user ON live_streams(creator_user_id, status);
CREATE INDEX idx_live_streams_creator_store ON live_streams(creator_store_id, status);
CREATE INDEX idx_live_streams_type ON live_streams(stream_type, status);
CREATE INDEX idx_live_streams_scheduled ON live_streams(scheduled_start_time) WHERE status = 'SCHEDULED';
```

---

### 2. Viewer Access & Session Tracking: `live_viewers`

**Tracks who watched, for how long, and payment status:**

```sql
CREATE TABLE live_viewers (
  -- Identity
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stream_id UUID NOT NULL REFERENCES live_streams(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  
  -- Session Tracking
  joined_at TIMESTAMP NOT NULL DEFAULT NOW(),
  left_at TIMESTAMP,
  watch_duration_seconds INT,              -- Calculated on leave
  is_active BOOLEAN DEFAULT true,
  
  -- Access Control
  access_granted BOOLEAN DEFAULT false,
  access_type VARCHAR(20),                 -- 'FREE', 'PAID', 'GIFT', 'VIP'
  payment_id UUID,                         -- Link to live_payments if paid
  
  -- Engagement
  total_comments INT DEFAULT 0,
  total_gifts_sent INT DEFAULT 0,
  total_likes INT DEFAULT 0,
  
  -- Device & Location
  device_type VARCHAR(20),                 -- 'mobile', 'desktop', 'tablet'
  ip_address VARCHAR(45),
  country_code VARCHAR(3),
  city VARCHAR(100),
  
  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  
  CONSTRAINT unique_viewer_session UNIQUE(stream_id, user_id, joined_at)
);

-- Indexes
CREATE INDEX idx_live_viewers_stream ON live_viewers(stream_id, is_active);
CREATE INDEX idx_live_viewers_user ON live_viewers(user_id, joined_at DESC);
CREATE INDEX idx_live_viewers_active ON live_viewers(stream_id, is_active) WHERE is_active = true;
```

---

### 3. Payment Transactions: `live_payments`

**Tracks all monetary transactions (event tickets, gifts, donations):**

```sql
CREATE TABLE live_payments (
  -- Identity
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stream_id UUID NOT NULL REFERENCES live_streams(id),
  user_id UUID NOT NULL,                   -- Payer
  
  -- Payment Details
  payment_type VARCHAR(20) NOT NULL,       -- 'EVENT_TICKET', 'VIRTUAL_GIFT', 'DONATION', 'TIP'
  amount DECIMAL(10, 2) NOT NULL,
  currency VARCHAR(3) DEFAULT 'NGN',
  
  -- Commission Split
  platform_fee DECIMAL(10, 2) NOT NULL,
  creator_earning DECIMAL(10, 2) NOT NULL,
  commission_percentage DECIMAL(5, 2),
  
  -- Payment Gateway
  payment_method VARCHAR(50),              -- 'card', 'bank_transfer', 'mobile_money'
  payment_gateway VARCHAR(50),             -- 'paystack', 'flutterwave'
  gateway_transaction_id VARCHAR(255),
  gateway_reference VARCHAR(255) UNIQUE,
  
  -- Status
  status VARCHAR(20) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED')),
  
  -- Gift-Specific (if payment_type = VIRTUAL_GIFT)
  gift_type VARCHAR(50),                   -- 'heart', 'star', 'diamond', 'rose'
  gift_quantity INT DEFAULT 1,
  
  -- Refund
  refunded_at TIMESTAMP,
  refund_reason TEXT,
  refund_amount DECIMAL(10, 2),
  
  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  completed_at TIMESTAMP,
  
  CONSTRAINT positive_amount CHECK (amount > 0)
);

-- Indexes
CREATE INDEX idx_live_payments_stream ON live_payments(stream_id, status);
CREATE INDEX idx_live_payments_user ON live_payments(user_id, created_at DESC);
CREATE INDEX idx_live_payments_gateway_ref ON live_payments(gateway_reference);
CREATE INDEX idx_live_payments_status ON live_payments(status, created_at DESC);
```

---

### 4. Product Pinning (Commerce): `live_products`

**Tracks products showcased during commerce streams:**

```sql
CREATE TABLE live_products (
  -- Identity
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stream_id UUID NOT NULL REFERENCES live_streams(id) ON DELETE CASCADE,
  product_id INT NOT NULL,                 -- References ecommerce.products
  
  -- Pinning Timeline
  pinned_at TIMESTAMP NOT NULL DEFAULT NOW(),
  unpinned_at TIMESTAMP,
  pin_duration_seconds INT,                -- How long it was pinned
  is_currently_pinned BOOLEAN DEFAULT true,
  pin_position INT DEFAULT 0,              -- For multiple pins
  
  -- Product Snapshot (cache at pin time)
  product_name VARCHAR(255),
  product_price DECIMAL(10, 2),
  product_image_url VARCHAR(500),
  
  -- Stream-Specific Pricing
  special_price DECIMAL(10, 2),            -- Optional stream discount
  discount_percentage DECIMAL(5, 2),
  
  -- Performance Metrics
  view_count INT DEFAULT 0,                -- How many viewers saw it
  click_count INT DEFAULT 0,               -- How many clicked
  add_to_cart_count INT DEFAULT 0,
  purchase_count INT DEFAULT 0,
  revenue_generated DECIMAL(10, 2) DEFAULT 0,
  
  CONSTRAINT unique_stream_product UNIQUE(stream_id, product_id, pinned_at)
);

-- Indexes
CREATE INDEX idx_live_products_stream ON live_products(stream_id, pinned_at DESC);
CREATE INDEX idx_live_products_product ON live_products(product_id);
CREATE INDEX idx_live_products_active ON live_products(stream_id, is_currently_pinned) WHERE is_currently_pinned = true;
```

---

### 5. Stream Analytics (Aggregated): `live_analytics`

**Daily/hourly aggregated metrics for reporting:**

```sql
CREATE TABLE live_analytics (
  -- Identity
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stream_id UUID NOT NULL REFERENCES live_streams(id),
  
  -- Time Window
  date DATE NOT NULL,
  hour INT,                                -- 0-23, NULL for daily aggregates
  
  -- Viewer Metrics
  total_viewers INT DEFAULT 0,
  unique_viewers INT DEFAULT 0,
  peak_concurrent_viewers INT DEFAULT 0,
  average_watch_time_seconds INT DEFAULT 0,
  total_watch_time_seconds BIGINT DEFAULT 0,
  
  -- Engagement Metrics
  total_comments INT DEFAULT 0,
  total_likes INT DEFAULT 0,
  total_shares INT DEFAULT 0,
  total_gifts INT DEFAULT 0,
  
  -- Revenue Metrics (COMMERCE type)
  total_orders INT DEFAULT 0,
  total_revenue DECIMAL(10, 2) DEFAULT 0,
  average_order_value DECIMAL(10, 2),
  conversion_rate DECIMAL(5, 2),
  
  -- Geographic Distribution
  top_countries JSONB,                     -- {"NG": 120, "GH": 45, ...}
  top_cities JSONB,
  
  -- Device Distribution
  mobile_percentage DECIMAL(5, 2),
  desktop_percentage DECIMAL(5, 2),
  tablet_percentage DECIMAL(5, 2),
  
  created_at TIMESTAMP DEFAULT NOW(),
  
  CONSTRAINT unique_stream_period UNIQUE(stream_id, date, hour)
);

-- Indexes
CREATE INDEX idx_live_analytics_stream_date ON live_analytics(stream_id, date DESC);
CREATE INDEX idx_live_analytics_date ON live_analytics(date DESC);
```

---

### 6. Live Comments (Real-time): `live_comments`

**Stores chat messages during streams:**

```sql
CREATE TABLE live_comments (
  -- Identity
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stream_id UUID NOT NULL REFERENCES live_streams(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  
  -- Content
  message TEXT NOT NULL,
  message_type VARCHAR(20) DEFAULT 'TEXT', -- 'TEXT', 'EMOJI', 'STICKER', 'SYSTEM'
  
  -- Moderation
  is_visible BOOLEAN DEFAULT true,
  is_pinned BOOLEAN DEFAULT false,
  is_flagged BOOLEAN DEFAULT false,
  moderation_status VARCHAR(20) DEFAULT 'APPROVED',
  
  -- Reactions
  like_count INT DEFAULT 0,
  
  -- Metadata
  mentioned_user_ids UUID[],               -- @mentions
  
  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP,                    -- Soft delete
  
  CONSTRAINT message_length CHECK (LENGTH(message) <= 500)
);

-- Indexes
CREATE INDEX idx_live_comments_stream ON live_comments(stream_id, created_at DESC);
CREATE INDEX idx_live_comments_user ON live_comments(user_id, created_at DESC);
CREATE INDEX idx_live_comments_visible ON live_comments(stream_id, is_visible, created_at DESC) WHERE is_visible = true;
```

---

### 7. Virtual Gifts (Social): `live_gifts`

**Tracks gifts sent during social streams:**

```sql
CREATE TABLE live_gifts (
  -- Identity
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  stream_id UUID NOT NULL REFERENCES live_streams(id),
  sender_user_id UUID NOT NULL,
  receiver_user_id UUID NOT NULL,          -- Stream creator
  
  -- Gift Details
  gift_type VARCHAR(50) NOT NULL,          -- 'heart', 'star', 'rose', 'diamond'
  gift_quantity INT NOT NULL DEFAULT 1,
  gift_value DECIMAL(10, 2) NOT NULL,      -- Total value
  unit_price DECIMAL(10, 2) NOT NULL,      -- Price per gift
  
  -- Payment
  payment_id UUID REFERENCES live_payments(id),
  
  -- Display
  display_animation VARCHAR(50),           -- Animation type for UI
  is_combo BOOLEAN DEFAULT false,          -- Combo gift (multiple at once)
  combo_count INT DEFAULT 1,
  
  -- Timestamps
  sent_at TIMESTAMP DEFAULT NOW(),
  
  CONSTRAINT positive_quantity CHECK (gift_quantity > 0)
);

-- Indexes
CREATE INDEX idx_live_gifts_stream ON live_gifts(stream_id, sent_at DESC);
CREATE INDEX idx_live_gifts_sender ON live_gifts(sender_user_id, sent_at DESC);
CREATE INDEX idx_live_gifts_receiver ON live_gifts(receiver_user_id, sent_at DESC);
```

---

### 8. Update Existing Tables

**Add livestream tracking to orders:**

```sql
-- Add columns to existing orders table
ALTER TABLE orders ADD COLUMN order_source VARCHAR(20) DEFAULT 'REGULAR';
ALTER TABLE orders ADD COLUMN source_stream_id UUID REFERENCES live_streams(id);
ALTER TABLE orders ADD COLUMN viewer_session_id UUID REFERENCES live_viewers(id);

CREATE INDEX idx_orders_source ON orders(order_source, created_at DESC);
CREATE INDEX idx_orders_stream ON orders(source_stream_id) WHERE source_stream_id IS NOT NULL;
```

**Add livestream relation to stores:**

```sql
-- No structural change needed - live_streams already references stores
-- Just add an index for performance
CREATE INDEX idx_stores_live_enabled ON stores(id) WHERE subscription_plan != 'FREE';
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

## � ADDITIONAL REQUIREMENTS

**Note:** MediaLive depends on existing e-commerce infrastructure (stores, products, subscriptions). Those core endpoints are documented separately.

### Base URL: `https://api.lykluk.com`

---

### 📂 CATEGORIES (3 endpoints) - Needed for Content Organization

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

### ⚕️ HEALTH CHECK (1 endpoint) - For Monitoring

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

### Phase 1 - Core Live Infrastructure (Week 1-2)
**Goal:** Basic livestreaming works for ANY type

1. **Database Setup**
   - Create `live_streams` table (with `stream_type` field)
   - Create `live_viewers` table
   - Create `live_analytics` table

2. **BytePlus Integration**
   - Set up BytePlus account
   - Implement BytePlus OpenAPI SDK
   - Test stream creation/termination

3. **Core API Endpoints**
   - `POST /live/create` (type-agnostic)
   - `POST /live/{id}/start`
   - `POST /live/{id}/end`
   - `GET /live/active?type=COMMERCE|SOCIAL`
   - `GET /live/{id}`

4. **Testing**
   - Create COMMERCE stream (requires store)
   - Create SOCIAL stream (requires user)
   - Verify BytePlus credentials work

---

### Phase 2 - Commerce Integration (Week 3)
**Goal:** Store owners can sell products live

1. **Commerce Validation**
   - Check store ownership
   - Check store verification status
   - Validate subscription tier (at `/ecommerce/subscription/*`)
   - Enforce tier limits (streams/month, duration)

2. **Commerce Features**
   - `POST /live/{id}/pin-product`
   - Track product views during stream
   - Link orders to livestream source
   - Commerce analytics dashboard

3. **UI Integration**
   - Update Flutter `live_stream` module
   - Add `streamType` to models
   - Show different UI for COMMERCE vs SOCIAL

---

### Phase 3 - Social Integration (Week 4)
**Goal:** Regular users can go live

1. **Social Validation**
   - Check user verification status
   - Optional: Check user reputation score
   - Set stream limits for new users

2. **Social Features**
   - `POST /live/{id}/gift` (virtual gifts)
   - WebSocket for live comments
   - Follower notifications
   - Social analytics

3. **UI Updates**
   - Add "Go Live" button to social profile
   - Live comment overlay
   - Virtual gift animations

---

### Phase 4 - Monetization & Polish (Week 5-6)

1. **Payment Integration**
   - Paid events (`LIVE_EVENT`, `MASTERCLASS`)
   - Virtual gift purchases
   - Commission tracking
   - Payouts to creators

2. **Advanced Features**
   - Replays & VOD
   - Scheduled streams
   - Co-hosting
   - Stream moderation tools

---

### Phase 5 - Podcast (Future)

1. **Audio-Only Mode**
   - Disable video track
   - Lower bandwidth requirements
   - Background playback support

2. **Podcast Features**
   - RSS feed generation
   - Episode management
   - Podcast discovery
   - Audio-only player

---

## 🧪 Testing Status

**Last tested:** December 20, 2025

### E-Commerce Endpoints (Verified Working)
| Endpoint | Status | Result |
|----------|--------|--------|
| GET /ecommerce/store/my-store | ✅ Exists | 401 (needs auth) |
| GET /ecommerce/products | ✅ Working | 200 (returns data) |
| GET /ecommerce/categories | ✅ Working | 200 (8 categories) |
| GET /ecommerce/cart | ✅ Exists | 401 (needs auth) |
| GET /ecommerce/orders | ✅ Exists | 401 (needs auth) |

### MediaLive Endpoints (Not Implemented)
| Endpoint | Status | Result |
|----------|--------|--------|
| POST /live/create | ❌ Not Implemented | 404 |
| POST /live/{id}/start | ❌ Not Implemented | 404 |
| POST /live/{id}/end | ❌ Not Implemented | 404 |
| GET /live/active | ❌ Not Implemented | 404 |
| GET /live/{id} | ❌ Not Implemented | 404 |
| POST /live/{id}/pin-product | ❌ Not Implemented | 404 |
| POST /live/{id}/access | ❌ Not Implemented | 404 |
| GET /live/replays | ❌ Not Implemented | 404 |

---

## 📋 Backend Team Action Items

### IMMEDIATE (Phase 1 - Core Setup):
- [ ] Create `live_streams` table with `stream_type` enum
- [ ] Set up BytePlus MediaLive account
- [ ] Integrate BytePlus OpenAPI SDK (Node.js/Python/Go)
- [ ] Implement stream key encryption
- [ ] Create `/live/create` endpoint (type-agnostic)
- [ ] Create `/live/{id}/start` endpoint
- [ ] Create `/live/{id}/end` endpoint
- [ ] Create `/live/active` endpoint
- [ ] Test with both COMMERCE and SOCIAL stream types

### SHORT-TERM (Phase 2 - Commerce):
- [ ] Add store validation to COMMERCE streams
- [ ] Add subscription validation (check `/ecommerce/subscription/*`)
- [ ] Implement `/live/{id}/pin-product`
- [ ] Track sales from livestreams
- [ ] Add commerce analytics

### MEDIUM-TERM (Phase 3 - Social):
- [ ] Add user verification checks
- [ ] Implement `/live/{id}/gift` endpoint
- [ ] Add WebSocket for live comments
- [ ] Implement follower notifications
- [ ] Add social analytics

### LONG-TERM (Phase 4 - Monetization):
- [ ] Implement paid event access
- [ ] Process virtual gift payments
- [ ] Calculate and track commissions
- [ ] Implement creator payouts
- [ ] Add replay/VOD system

---

## 🎯 Success Criteria

**Phase 1 Complete When:**
- ✅ Can create COMMERCE stream (requires storeId)
- ✅ Can create SOCIAL stream (just userId)
- ✅ BytePlus returns valid push URL/stream key
- ✅ Can start/end streams successfully
- ✅ Active streams list shows both types

**Phase 2 Complete When:**
- ✅ COMMERCE streams validate store ownership
- ✅ COMMERCE streams check subscription tier
- ✅ Can pin products during commerce stream
- ✅ Sales tracked back to livestream source

**Phase 3 Complete When:**
- ✅ SOCIAL streams validate user verification
- ✅ Virtual gifts can be sent and tracked
- ✅ Live comments work via WebSocket
- ✅ Followers get notified when creator goes live

---

**Note:** The core `/live/*` infrastructure serves ALL stream types. Type-specific logic (store validation, subscription checks, product pinning) happens in middleware/validation layers, not in core stream management.
