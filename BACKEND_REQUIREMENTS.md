# Backend Requirements - Subscription System

**Date:** January 12, 2026  
**Priority:** HIGH  
**Estimated Backend Effort:** 
**Blocking Issue:** `POST /subscription/activate` must be completed first

---

## 🚨 CRITICAL - Phase 2 Blocker

### Endpoint: `POST /subscription/activate`

#### Purpose:
Activate a user's subscription after successful payment verification.

#### Request:
```json
POST /subscription/activate
Content-Type: application/json
Authorization: Bearer <token>

{
  "store_id": 42,
  "plan": "BASIC",  // "BASIC" | "CLASSIC" | "PREMIUM"
  "billing_cycle": "monthly",  // "monthly" | "annual"
  "payment_reference": "ref_abc123xyz",  // From wallet deposit verification
  "promo_code": "LAUNCH2026"  // Optional
}
```

#### Response (Success):
```json
{
  "success": true,
  "subscription": {
    "id": 123,
    "store_id": 42,
    "plan": "BASIC",
    "billing_cycle": "monthly",
    "status": "ACTIVE",
    "started_at": "2026-01-12T10:30:00Z",
    "next_billing_date": "2026-02-12T10:30:00Z",
    "amount_paid": 9.90,
    "currency": "USD",
    "discount_applied": 0,
    "features": {
      "max_products": 10,
      "max_shipping_companies": 3,
      "max_live_sessions_per_month": 5,
      "max_session_duration_minutes": 5,
      "free_ads_per_month": 1,
      "service_fee": 5.0,
      "has_international_shipping": false,
      "can_use_live_commerce": true
    }
  }
}
```

#### Response (Error):
```json
{
  "success": false,
  "error": "INVALID_PAYMENT",
  "message": "Payment reference not found or already used"
}
```

#### Business Logic:
1. Validate payment reference with wallet system
2. Ensure payment amount matches subscription plan price
3. Check if store already has active subscription
4. If upgrading from FREE, activate immediately
5. If upgrading from paid plan, prorate and schedule
6. Update store's `subscription_plan` field in database
7. Create subscription record with billing history
8. Schedule next billing date (monthly + 30 days, annual + 365 days)
9. Send confirmation email/notification
10. Log transaction for audit trail

#### Database Changes:
```sql
-- Subscriptions table
CREATE TABLE subscriptions (
  id SERIAL PRIMARY KEY,
  store_id INTEGER REFERENCES stores(id) ON DELETE CASCADE,
  plan VARCHAR(20) NOT NULL,  -- 'FREE', 'BASIC', 'CLASSIC', 'PREMIUM'
  billing_cycle VARCHAR(20) NOT NULL,  -- 'monthly', 'annual'
  status VARCHAR(20) NOT NULL,  -- 'ACTIVE', 'CANCELLED', 'EXPIRED', 'PENDING'
  started_at TIMESTAMP NOT NULL,
  next_billing_date TIMESTAMP,
  cancelled_at TIMESTAMP,
  amount DECIMAL(10,2) NOT NULL,
  currency VARCHAR(3) NOT NULL,
  payment_reference VARCHAR(255),
  promo_code VARCHAR(50),
  discount_applied DECIMAL(10,2) DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Update stores table
ALTER TABLE stores ADD COLUMN subscription_plan VARCHAR(20) DEFAULT 'FREE';

-- Billing history
CREATE TABLE subscription_invoices (
  id SERIAL PRIMARY KEY,
  subscription_id INTEGER REFERENCES subscriptions(id),
  invoice_number VARCHAR(50) UNIQUE,
  amount DECIMAL(10,2),
  currency VARCHAR(3),
  status VARCHAR(20),  -- 'PAID', 'PENDING', 'FAILED', 'REFUNDED'
  billing_date TIMESTAMP,
  payment_reference VARCHAR(255),
  pdf_url VARCHAR(500),
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

## 1️⃣ Ads Management System

### 1.1 Create Ad
```
POST /ads/create
Authorization: Bearer <token>

Request:
{
  "store_id": 42,
  "title": "Summer Sale - 50% Off!",
  "description": "Limited time offer on all electronics",
  "image_url": "https://storage.googleapis.com/lykluk/ads/ad123.jpg",
  "video_url": null,  // Optional
  "target_url": "lykluk://store/42/products",
  "start_date": "2026-01-15T00:00:00Z",
  "end_date": "2026-01-31T23:59:59Z",
  "target_countries": ["NG", "GH", "KE"],  // ["*"] for all countries
  "status": "DRAFT"  // "DRAFT" | "ACTIVE" | "PAUSED"
}

Response:
{
  "success": true,
  "ad": {
    "id": 456,
    "store_id": 42,
    "title": "Summer Sale - 50% Off!",
    "status": "DRAFT",
    "impressions": 0,
    "clicks": 0,
    "conversions": 0,
    "created_at": "2026-01-12T10:30:00Z"
  },
  "monthly_usage": {
    "ads_this_month": 1,
    "ads_limit": 1
  }
}

Validation:
- Check if store's subscription plan allows ad creation
- FREE plan: Return error "Upgrade required for ads"
- Check if ads_this_month < ads_limit from subscription plan
- Validate dates (end_date > start_date)
- Validate image/video URLs are accessible
```

### 1.2 List Store Ads
```
GET /ads/store/{storeId}
Authorization: Bearer <token>
Query Params: ?status=ACTIVE&limit=20&offset=0

Response:
{
  "success": true,
  "ads": [
    {
      "id": 456,
      "title": "Summer Sale - 50% Off!",
      "status": "ACTIVE",
      "impressions": 12450,
      "clicks": 342,
      "conversions": 18,
      "ctr": 2.75,  // Click-through rate (clicks/impressions * 100)
      "conversion_rate": 5.26,  // (conversions/clicks * 100)
      "start_date": "2026-01-15T00:00:00Z",
      "end_date": "2026-01-31T23:59:59Z",
      "created_at": "2026-01-12T10:30:00Z"
    }
  ],
  "monthly_usage": {
    "ads_this_month": 1,
    "ads_limit": 1
  },
  "pagination": {
    "total": 5,
    "limit": 20,
    "offset": 0
  }
}
```

### 1.3 Update Ad Status
```
PUT /ads/{adId}/status
Authorization: Bearer <token>

Request:
{
  "status": "ACTIVE"  // "ACTIVE" | "PAUSED" | "COMPLETED"
}

Response:
{
  "success": true,
  "ad": { ... }
}
```

### 1.4 Delete Ad
```
DELETE /ads/{adId}
Authorization: Bearer <token>

Response:
{
  "success": true,
  "message": "Ad deleted successfully"
}

Note: Soft delete - keep record but mark as deleted
```

### 1.5 Ad Analytics
```
GET /ads/{adId}/analytics
Authorization: Bearer <token>
Query Params: ?startDate=2026-01-01&endDate=2026-01-31

Response:
{
  "success": true,
  "analytics": {
    "ad_id": 456,
    "title": "Summer Sale - 50% Off!",
    "total_impressions": 12450,
    "total_clicks": 342,
    "total_conversions": 18,
    "ctr": 2.75,
    "conversion_rate": 5.26,
    "geo_distribution": {
      "NG": 8400,
      "GH": 2800,
      "KE": 1250
    },
    "daily_metrics": [
      {
        "date": "2026-01-15",
        "impressions": 1200,
        "clicks": 35,
        "conversions": 2
      },
      {
        "date": "2026-01-16",
        "impressions": 1350,
        "clicks": 42,
        "conversions": 3
      }
    ]
  }
}
```

### 1.6 Track Impression
```
POST /ads/track/impression
Authorization: Bearer <token> (optional - can track anonymous)

Request:
{
  "ad_id": 456,
  "user_id": 789,  // Optional
  "country": "NG",  // User's country code
  "platform": "android",  // "ios" | "android" | "web"
  "timestamp": "2026-01-15T14:30:00Z"
}

Response:
{
  "success": true,
  "tracked": true
}

Note: Rate limit to prevent spam (max 1 impression per ad per user per minute)
```

### 1.7 Track Click
```
POST /ads/track/click
Authorization: Bearer <token> (optional)

Request:
{
  "ad_id": 456,
  "user_id": 789,  // Optional
  "country": "NG",
  "platform": "android",
  "timestamp": "2026-01-15T14:30:05Z"
}

Response:
{
  "success": true,
  "tracked": true,
  "redirect_url": "lykluk://store/42/products"
}
```

### 1.8 Get Feed Ads
```
GET /ads/feed
Authorization: Bearer <token> (optional)
Query Params: ?country=NG&limit=10

Response:
{
  "success": true,
  "ads": [
    {
      "id": 456,
      "title": "Summer Sale - 50% Off!",
      "description": "Limited time offer...",
      "image_url": "https://...",
      "video_url": null,
      "target_url": "lykluk://store/42/products",
      "store": {
        "id": 42,
        "name": "TechGadgets NG",
        "logo_url": "https://..."
      }
    }
  ]
}

Logic:
- Return ACTIVE ads only
- Filter by user's country (if target_countries includes user's country or "*")
- Randomize order with weighted distribution (higher-paying plans get more impressions)
- Cache results for 5 minutes
```

---

## 2️⃣ Geographic Restrictions

**Priority:** 🔴 HIGH  
**Endpoints:** 2

### 2.1 Get Allowed Countries
```
GET /subscription/allowed-countries/{storeId}
Authorization: Bearer <token>

Response:
{
  "success": true,
  "store_id": 42,
  "plan": "BASIC",
  "store_country": "NG",
  "allowed_countries": ["NG"],  // Only Nigeria for BASIC
  "restrictions": {
    "can_sell_internationally": false,
    "can_sell_outside_store_country": false,
    "sales_territory": "User's Country Only"
  }
}

Logic:
- FREE plan: Return only store's country (Nigeria)
- BASIC plan: Return only store's country
- CLASSIC/PREMIUM: Return ["*"] (all countries)
```

### 2.2 Validate Order Country
```
POST /ecommerce/orders/validate-country
Authorization: Bearer <token>

Request:
{
  "store_id": 42,
  "customer_country": "GH"  // Ghana
}

Response (Allowed):
{
  "success": true,
  "allowed": true,
  "message": "Shipping to Ghana is allowed"
}

Response (Denied):
{
  "success": false,
  "allowed": false,
  "message": "This store can only ship to Nigeria",
  "current_plan": "BASIC",
  "required_plan": "CLASSIC",
  "upgrade_required": true
}

Logic:
- Get store's subscription plan
- FREE plan: Only allow store's country (usually NG)
- BASIC plan: Only allow store's country
- CLASSIC/PREMIUM: Allow all countries
- Also check against existing orders endpoint - validate before creating order
```

### Integration with Order Creation:
Modify existing `POST /ecommerce/orders` endpoint to validate country before creating order.

---

## 3️⃣ Analytics & Reporting

**Priority:** 🔴 HIGH  
**Estimated Effort:** 4-5 days  
**Endpoints:** 7

### 3.1 Subscription Analytics Dashboard
```
GET /subscription/analytics/{storeId}
Authorization: Bearer <token>

Response:
{
  "success": true,
  "store_id": 42,
  "plan": "BASIC",
  "usage": {
    "products": {
      "used": 7,
      "limit": 10,
      "percentage": 70.0
    },
    "live_streams": {
      "sessions_used": 3,
      "sessions_limit": 5,
      "minutes_used": 12,
      "minutes_limit": 25,  // 5 sessions × 5 minutes each
      "percentage": 60.0
    },
    "ads": {
      "used": 1,
      "limit": 1,
      "percentage": 100.0
    },
    "shipping_companies": {
      "used": 2,
      "limit": 3,
      "percentage": 66.7
    }
  },
  "revenue": {
    "total_revenue": 125000.00,
    "commission_paid": 8750.00,  // 7% for BASIC
    "commission_rate": 7.0,
    "net_revenue": 116250.00
  },
  "performance": {
    "conversion_rate": 3.5,
    "average_order_value": 12500.00,
    "international_sales_percentage": 0,  // 0% for BASIC (Nigeria only)
    "top_selling_products": [
      {
        "product_id": 123,
        "name": "iPhone 15 Pro",
        "sales": 45,
        "revenue": 56250.00
      }
    ],
    "top_countries": [
      { "country": "NG", "orders": 125, "revenue": 125000.00 }
    ]
  },
  "trends": {
    "revenue_by_month": [
      { "month": "2026-01", "revenue": 125000.00, "orders": 125 }
    ],
    "orders_by_month": [
      { "month": "2026-01", "orders": 125 }
    ],
    "live_streams_by_month": [
      { "month": "2026-01", "sessions": 3, "total_minutes": 12 }
    ]
  }
}
```

### 3.2 Livestream Usage
```
GET /subscription/usage/livestream/{storeId}
Authorization: Bearer <token>

Response:
{
  "success": true,
  "monthly_usage": {
    "sessions_this_month": 3,
    "sessions_limit": 5,
    "minutes_this_month": 12,
    "minutes_limit": 25,
    "percentage": 48.0
  },
  "sessions": [
    {
      "id": "stream_abc123",
      "title": "New Product Launch",
      "start_time": "2026-01-10T15:00:00Z",
      "end_time": "2026-01-10T15:05:00Z",
      "duration_minutes": 5,
      "viewer_count": 234,
      "peak_viewers": 187,
      "revenue": 12500.00,
      "orders": 8
    },
    {
      "id": "stream_def456",
      "title": "Q&A Session",
      "start_time": "2026-01-08T18:00:00Z",
      "end_time": "2026-01-08T18:04:00Z",
      "duration_minutes": 4,
      "viewer_count": 156,
      "peak_viewers": 98,
      "revenue": 0,
      "orders": 0
    }
  ],
  "next_reset": "2026-02-01T00:00:00Z"
}

Logic:
- Count livestreams where start_time is in current month
- Sum duration_minutes for all sessions this month
- Return sessions in descending order (newest first)
```

### 3.3 Product Usage
```
GET /subscription/usage/products/{storeId}
Authorization: Bearer <token>

Response:
{
  "success": true,
  "products_created": 7,
  "products_limit": 10,
  "percentage": 70.0,
  "products": [
    {
      "id": 123,
      "name": "iPhone 15 Pro",
      "sales": 45,
      "revenue": 56250.00,
      "stock": 12,
      "status": "ACTIVE",
      "created_at": "2026-01-05T10:00:00Z"
    }
  ]
}
```

### 3.4 Ads Usage
```
GET /subscription/usage/ads/{storeId}
Authorization: Bearer <token>

Response:
{
  "success": true,
  "ads_this_month": 1,
  "monthly_limit": 1,
  "percentage": 100.0,
  "ads": [
    {
      "id": 456,
      "title": "Summer Sale",
      "impressions": 12450,
      "clicks": 342,
      "conversions": 18,
      "ctr": 2.75,
      "created_at": "2026-01-12T10:30:00Z"
    }
  ],
  "next_reset": "2026-02-01T00:00:00Z"
}
```

### 3.5 Conversion Funnel
```
GET /subscription/conversion-funnel
Authorization: Bearer <admin_token>
Query Params: ?startDate=2026-01-01&endDate=2026-01-31

Response:
{
  "success": true,
  "period": {
    "start": "2026-01-01",
    "end": "2026-01-31"
  },
  "funnel": {
    "free": {
      "stores": 1240,
      "revenue": 0
    },
    "basic": {
      "stores": 156,
      "revenue": 1544.40,
      "upgrades_from_free": 142
    },
    "classic": {
      "stores": 42,
      "revenue": 835.80,
      "upgrades_from_basic": 38
    },
    "premium": {
      "stores": 8,
      "revenue": 276.00,
      "upgrades_from_classic": 7
    }
  },
  "conversion_rates": {
    "free_to_basic": 11.45,  // (142/1240) * 100
    "basic_to_classic": 24.36,
    "classic_to_premium": 16.67
  },
  "total_mrr": 2656.20  // Monthly Recurring Revenue
}

Note: Admin-only endpoint for business metrics
```

### 3.6 Churn Analysis
```
GET /subscription/churn-analysis
Authorization: Bearer <admin_token>
Query Params: ?period=monthly

Response:
{
  "success": true,
  "period": "monthly",
  "total_cancellations": 18,
  "churn_rate": 8.7,  // (18/206) * 100 - total paid subscribers
  "churn_by_plan": {
    "basic": 12,
    "classic": 5,
    "premium": 1
  },
  "top_reasons": [
    { "reason": "Too expensive", "count": 7 },
    { "reason": "Not enough features", "count": 5 },
    { "reason": "Switching to competitor", "count": 3 },
    { "reason": "Business closed", "count": 2 },
    { "reason": "Other", "count": 1 }
  ]
}

Note: Admin-only endpoint
```

### 3.7 Monthly Usage Reset
This is a background job, not an API endpoint.

```typescript
// Cron job that runs at midnight on 1st of every month
async function resetMonthlyUsage() {
  // Reset ads counter
  await db.query(`
    UPDATE stores 
    SET ads_used_this_month = 0
    WHERE ads_used_this_month > 0
  `);
  
  // Reset livestream counter
  // (Don't need to reset - we query by month in analytics)
  
  console.log('Monthly usage counters reset');
}

// Schedule: 0 0 1 * * (At 00:00 on day-of-month 1)
```

---

## 4️⃣ Advanced Payment Features

**Priority:** 🟡 MEDIUM  
**Endpoints:** 12

### 4.1 Promo Code Validation
```
POST /subscription/promo/validate
Authorization: Bearer <token>

Request:
{
  "code": "LAUNCH2026",
  "plan": "BASIC",
  "billing_cycle": "annual"
}

Response (Valid):
{
  "success": true,
  "valid": true,
  "promo": {
    "code": "LAUNCH2026",
    "discount": 20.0,  // 20% off
    "discount_type": "percentage",  // "percentage" | "fixed"
    "original_price": 110.90,
    "discounted_price": 88.72,
    "expires_at": "2026-02-01T00:00:00Z",
    "applicable_plans": ["BASIC", "CLASSIC", "PREMIUM"],
    "max_uses": 1000,
    "uses_remaining": 847
  }
}

Response (Invalid):
{
  "success": false,
  "valid": false,
  "error": "EXPIRED",
  "message": "This promo code has expired"
}

Database:
CREATE TABLE promo_codes (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) UNIQUE NOT NULL,
  discount DECIMAL(10,2) NOT NULL,
  discount_type VARCHAR(20) NOT NULL,
  applicable_plans TEXT[],
  max_uses INTEGER,
  current_uses INTEGER DEFAULT 0,
  expires_at TIMESTAMP,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### 4.2 Apply Promo Code
```
POST /subscription/promo/apply
Authorization: Bearer <token>

Request:
{
  "subscription_id": 123,
  "promo_code": "LAUNCH2026"
}

Response:
{
  "success": true,
  "message": "Promo code applied successfully",
  "discount_applied": 22.18
}
```

### 4.3 Get Invoices
```
GET /subscription/{subscriptionId}/invoices
Authorization: Bearer <token>

Response:
{
  "success": true,
  "invoices": [
    {
      "id": 789,
      "invoice_number": "INV-2026-001-789",
      "amount": 9.90,
      "currency": "USD",
      "status": "PAID",
      "billing_date": "2026-01-12T10:30:00Z",
      "payment_reference": "ref_abc123xyz",
      "pdf_url": "https://storage.googleapis.com/lykluk/invoices/INV-2026-001-789.pdf",
      "plan": "BASIC",
      "billing_cycle": "monthly"
    }
  ]
}
```

### 4.4 Toggle Auto-Renewal
```
PUT /subscription/{subscriptionId}/auto-renew
Authorization: Bearer <token>

Request:
{
  "enabled": false
}

Response:
{
  "success": true,
  "subscription": {
    "id": 123,
    "auto_renew": false,
    "expires_at": "2026-02-12T10:30:00Z"
  },
  "message": "Auto-renewal disabled. Your subscription will expire on 2026-02-12."
}
```

### 4.5 Update Payment Method
```
PUT /subscription/{subscriptionId}/payment-method
Authorization: Bearer <token>

Request:
{
  "gateway": "PAYSTACK",  // "PAYSTACK" | "SQUADCO" | "STARTBUTTON" | "STRIPE"
  "card_token": "tok_abc123xyz"  // Optional - for future card storage
}

Response:
{
  "success": true,
  "message": "Payment method updated successfully"
}
```

### 4.6 Cancel Subscription
```
POST /subscription/cancel
Authorization: Bearer <token>

Request:
{
  "subscription_id": 123,
  "reason": "Too expensive",
  "feedback": "I can't afford it right now but may come back later"
}

Response:
{
  "success": true,
  "cancelled": true,
  "subscription": {
    "id": 123,
    "status": "CANCELLED",
    "valid_until": "2026-02-12T10:30:00Z",  // End of current billing period
    "refund_amount": 0  // No refund for cancellations
  },
  "message": "Subscription cancelled. You can continue using BASIC features until 2026-02-12."
}

Logic:
- Update status to CANCELLED
- Don't immediately downgrade - let them use paid features until end of billing period
- On next_billing_date, downgrade to FREE plan
- Log cancellation reason for analytics
```

### 4.7 Get Referral Code
```
GET /referrals/{userId}/code
Authorization: Bearer <token>

Response:
{
  "success": true,
  "code": "LYKLUK-USER789",
  "url": "https://lykluk.com/signup?ref=LYKLUK-USER789",
  "qr_code_url": "https://storage.googleapis.com/lykluk/qr/user789.png"
}

Database:
CREATE TABLE referral_codes (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  code VARCHAR(50) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### 4.8 Get Referral Stats
```
GET /referrals/{userId}/stats
Authorization: Bearer <token>

Response:
{
  "success": true,
  "total_referrals": 12,
  "pending_referrals": 3,
  "completed_referrals": 9,
  "total_rewards": 45.00,  // $5 per completed referral
  "available_balance": 25.00,
  "referrals": [
    {
      "user_id": 890,
      "username": "techstore_ng",
      "status": "COMPLETED",  // "PENDING" | "COMPLETED"
      "reward": 5.00,
      "date_joined": "2026-01-10T12:00:00Z",
      "subscription_activated": "2026-01-11T15:30:00Z"
    }
  ]
}

Database:
CREATE TABLE referrals (
  id SERIAL PRIMARY KEY,
  referrer_user_id INTEGER REFERENCES users(id),
  referred_user_id INTEGER REFERENCES users(id),
  code VARCHAR(50),
  status VARCHAR(20) DEFAULT 'PENDING',
  reward DECIMAL(10,2) DEFAULT 5.00,
  date_joined TIMESTAMP,
  subscription_activated TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);

Logic:
- PENDING: User signed up but hasn't subscribed to paid plan
- COMPLETED: User subscribed to paid plan, referrer gets $5 reward
```

### 4.9 Redeem Referral Rewards
```
POST /referrals/redeem
Authorization: Bearer <token>

Request:
{
  "user_id": 789,
  "amount": 25.00,
  "redeem_type": "subscription_discount"  // "subscription_discount" | "cash_withdrawal"
}

Response:
{
  "success": true,
  "redeemed": true,
  "amount": 25.00,
  "new_balance": 0,
  "message": "$25 credit applied to your account"
}
```

### 4.10 Multi-Currency Pricing
```
GET /subscription/pricing
Authorization: Bearer <token> (optional)
Query Params: ?currency=NGN

Response:
{
  "success": true,
  "currency": "NGN",
  "exchange_rate": 1515.00,  // 1 USD = 1515 NGN
  "plans": [
    {
      "name": "BASIC",
      "monthly": {
        "amount_usd": 9.90,
        "amount_local": 15000,
        "currency": "NGN",
        "savings": null
      },
      "annual": {
        "amount_usd": 110.90,
        "amount_local": 168000,
        "currency": "NGN",
        "savings": {
          "amount_usd": 8.00,
          "amount_local": 12120,
          "percentage": 6.7
        }
      }
    }
  ]
}

Logic:
- Default to USD if currency not specified
- Use live exchange rates (cache for 1 hour)
- Supported currencies: NGN, USD, GHS, KES, ZAR, GBP, EUR
```

### 4.11 Enterprise Contact
```
POST /subscription/enterprise/contact
Authorization: Bearer <token>

Request:
{
  "store_id": 42,
  "contact_name": "Chinedu Okafor",
  "email": "chinedu@bigstore.com",
  "phone": "+234 803 123 4567",
  "estimated_orders": 5000,
  "custom_requests": [
    "Higher product limit (200+ products)",
    "Custom commission rate",
    "Dedicated account manager"
  ],
  "message": "We're a large retailer looking for enterprise pricing"
}

Response:
{
  "success": true,
  "message": "Thank you! Our enterprise team will contact you within 24 hours.",
  "ticket_id": "ENT-2026-001"
}

Logic:
- Send email to sales team
- Create CRM ticket
- Auto-respond to customer
```

### 4.12 Recurring Billing (Background Job)
This is a cron job, not an API endpoint.

```typescript
// Runs daily at 2 AM to process renewals
async function processSubscriptionRenewals() {
  const now = new Date();
  
  // Get subscriptions due for renewal today
  const dueSubscriptions = await db.query(`
    SELECT * FROM subscriptions 
    WHERE status = 'ACTIVE' 
    AND auto_renew = true
    AND next_billing_date::date = $1::date
  `, [now]);

  for (const sub of dueSubscriptions) {
    try {
      // 1. Charge payment method on file
      const payment = await chargePaymentMethod(sub);
      
      if (payment.success) {
        // 2. Extend subscription
        const nextBillingDate = sub.billing_cycle === 'monthly' 
          ? addMonths(now, 1)
          : addYears(now, 1);
        
        await db.query(`
          UPDATE subscriptions 
          SET next_billing_date = $1,
              updated_at = NOW()
          WHERE id = $2
        `, [nextBillingDate, sub.id]);
        
        // 3. Create invoice
        await createInvoice(sub, payment);
        
        // 4. Send receipt email
        await sendReceiptEmail(sub);
        
      } else {
        // Payment failed
        await handleFailedPayment(sub);
      }
    } catch (error) {
      console.error(`Failed to renew subscription ${sub.id}:`, error);
    }
  }
}

async function handleFailedPayment(sub) {
  // 1. Mark payment as failed
  await db.query(`
    UPDATE subscriptions 
    SET payment_retry_count = payment_retry_count + 1
    WHERE id = $1
  `, [sub.id]);
  
  // 2. Send payment failed email
  await sendPaymentFailedEmail(sub);
  
  // 3. If 3 failed attempts, cancel subscription
  if (sub.payment_retry_count >= 2) {
    await db.query(`
      UPDATE subscriptions 
      SET status = 'EXPIRED',
          updated_at = NOW()
      WHERE id = $1
    `, [sub.id]);
    
    // Downgrade store to FREE plan
    await db.query(`
      UPDATE stores 
      SET subscription_plan = 'FREE'
      WHERE id = $1
    `, [sub.store_id]);
  }
}
```

---

## 📊 Database Schema Summary

### New Tables:
```sql
-- Subscriptions
CREATE TABLE subscriptions (
  id SERIAL PRIMARY KEY,
  store_id INTEGER REFERENCES stores(id) ON DELETE CASCADE,
  plan VARCHAR(20) NOT NULL,
  billing_cycle VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  started_at TIMESTAMP NOT NULL,
  next_billing_date TIMESTAMP,
  cancelled_at TIMESTAMP,
  amount DECIMAL(10,2) NOT NULL,
  currency VARCHAR(3) NOT NULL,
  payment_reference VARCHAR(255),
  promo_code VARCHAR(50),
  discount_applied DECIMAL(10,2) DEFAULT 0,
  auto_renew BOOLEAN DEFAULT true,
  payment_retry_count INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Invoices
CREATE TABLE subscription_invoices (
  id SERIAL PRIMARY KEY,
  subscription_id INTEGER REFERENCES subscriptions(id),
  invoice_number VARCHAR(50) UNIQUE,
  amount DECIMAL(10,2),
  currency VARCHAR(3),
  status VARCHAR(20),
  billing_date TIMESTAMP,
  payment_reference VARCHAR(255),
  pdf_url VARCHAR(500),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Ads
CREATE TABLE ads (
  id SERIAL PRIMARY KEY,
  store_id INTEGER REFERENCES stores(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  image_url VARCHAR(500),
  video_url VARCHAR(500),
  target_url VARCHAR(500),
  start_date TIMESTAMP,
  end_date TIMESTAMP,
  target_countries TEXT[],
  status VARCHAR(20) DEFAULT 'DRAFT',
  impressions INTEGER DEFAULT 0,
  clicks INTEGER DEFAULT 0,
  conversions INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP
);

-- Ad Tracking
CREATE TABLE ad_impressions (
  id SERIAL PRIMARY KEY,
  ad_id INTEGER REFERENCES ads(id),
  user_id INTEGER,
  country VARCHAR(3),
  platform VARCHAR(20),
  timestamp TIMESTAMP DEFAULT NOW()
);

CREATE TABLE ad_clicks (
  id SERIAL PRIMARY KEY,
  ad_id INTEGER REFERENCES ads(id),
  user_id INTEGER,
  country VARCHAR(3),
  platform VARCHAR(20),
  timestamp TIMESTAMP DEFAULT NOW()
);

-- Promo Codes
CREATE TABLE promo_codes (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) UNIQUE NOT NULL,
  discount DECIMAL(10,2) NOT NULL,
  discount_type VARCHAR(20) NOT NULL,
  applicable_plans TEXT[],
  max_uses INTEGER,
  current_uses INTEGER DEFAULT 0,
  expires_at TIMESTAMP,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Referrals
CREATE TABLE referral_codes (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  code VARCHAR(50) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE referrals (
  id SERIAL PRIMARY KEY,
  referrer_user_id INTEGER REFERENCES users(id),
  referred_user_id INTEGER REFERENCES users(id),
  code VARCHAR(50),
  status VARCHAR(20) DEFAULT 'PENDING',
  reward DECIMAL(10,2) DEFAULT 5.00,
  date_joined TIMESTAMP,
  subscription_activated TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);
```

### Modified Tables:
```sql
-- Add subscription_plan to stores
ALTER TABLE stores ADD COLUMN subscription_plan VARCHAR(20) DEFAULT 'FREE';

-- Add counters for monthly usage
ALTER TABLE stores ADD COLUMN ads_used_this_month INTEGER DEFAULT 0;
```

---

## 🔄 Background Jobs

### 1. Monthly Usage Reset
- **Schedule:** 0 0 1 * * (At 00:00 on day-of-month 1)
- **Action:** Reset `ads_used_this_month` to 0 for all stores

### 2. Subscription Renewal
- **Schedule:** 0 2 * * * (Daily at 2 AM)
- **Action:** Process subscriptions due for renewal, charge payment methods

### 3. Expired Subscription Cleanup
- **Schedule:** 0 3 * * * (Daily at 3 AM)
- **Action:** Downgrade stores with expired subscriptions to FREE plan

### 4. Ad Expiry
- **Schedule:** 0 1 * * * (Daily at 1 AM)
- **Action:** Mark ads with `end_date` < now as COMPLETED

---

## 📧 Email Notifications

### Templates Needed:
1. **Subscription Activated** - Welcome email with plan details
2. **Subscription Renewed** - Receipt for automatic renewal
3. **Payment Failed** - Alert with retry information
4. **Subscription Cancelled** - Confirmation with valid-until date
5. **Subscription Expired** - Downgrade notice
6. **Usage Limit Warning** - Email when 80% of limit reached
7. **Referral Completed** - Reward notification

---

## 🧪 Testing Requirements

### Test Accounts:
- Create stores with each subscription plan (FREE, BASIC, CLASSIC, PREMIUM)
- Test upgrade/downgrade flows
- Test payment failures and retries

### Test Promo Codes:
```
LAUNCH2026 - 20% off, valid until 2026-02-01
ANNUAL50 - 50% off annual plans only
FREEMONTH - 100% off first month (BASIC only)
```

### Test Scenarios:
1. FREE user tries to create ad → Denied
2. BASIC user tries to ship to Ghana → Denied
3. CLASSIC user ships to Ghana → Allowed
4. User reaches product limit → Blocked from adding more
5. User cancels subscription → Can use until end of billing period
6. Payment fails 3 times → Auto-downgrade to FREE

---

## 📝 API Documentation

All endpoints should be documented using OpenAPI/Swagger:
- Request/response examples
- Error codes
- Authentication requirements
- Rate limits

---

## 🔒 Security Considerations

1. **Authentication:** All endpoints require Bearer token except public ones (feed ads)
2. **Authorization:** Users can only access their own store data
3. **Rate Limiting:** 
   - Ad tracking: Max 60 impressions/minute per IP
   - Analytics: Max 100 requests/hour per user
4. **Input Validation:** Sanitize all user inputs to prevent SQL injection
5. **Payment Security:** Never store raw card numbers, use tokens only
6. **Webhook Verification:** Validate payment webhooks with signatures

---

## 📈 Performance Considerations

1. **Caching:** 
   - Subscription plan limits: Cache for 1 hour
   - Analytics: Cache for 15 minutes
   - Exchange rates: Cache for 1 hour
2. **Indexing:**
   - Index `subscriptions.store_id`, `subscriptions.status`
   - Index `ads.status`, `ads.store_id`
   - Index `ad_impressions.ad_id`, `ad_clicks.ad_id`
3. **Pagination:** All list endpoints should support pagination
4. **Query Optimization:** Use database views for complex analytics

---

## 🚀 Deployment Checklist

- [ ] All endpoints implemented and tested
- [ ] Database migrations created and tested
- [ ] Background jobs scheduled
- [ ] Email templates created
- [ ] Webhook handlers configured
- [ ] Rate limiting configured
- [ ] Monitoring and alerting set up
- [ ] API documentation published
- [ ] Frontend team notified of completion

---


**Frontend Lead:** Yerins Abraham




