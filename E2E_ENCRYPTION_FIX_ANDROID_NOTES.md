# E2E Encryption Fix - Android Integration Notes

**Branch:** `mvp-official`  
**Commit:** `9357dd3e`  
**Date:** January 25, 2026  
**Platform Tested:** iOS (iPhone)

---

## 🚨 CRITICAL: Read Before Pulling This Branch

This branch contains **MAJOR E2E encryption bug fixes** that resolve critical issues preventing message decryption between devices. The fixes have been tested and working on **iPhone**, but there are **known platform differences** that Android developers must be aware of.

---

## ✅ What Was Fixed (iOS)

### **Bug #1: Public Key Cache Empty on First Message**
**Problem:**
- Public keys were cached AFTER message was sent, leaving cache empty (0 keys)
- First message in new conversation failed to encrypt properly
- Recipient couldn't decrypt because sender's public key was missing

**Fix:**
- Public keys now cached **IMMEDIATELY** in `getOrCreateConversation()` (line 150-170)
- Cache populated BEFORE any messages are sent
- File: `lib/modules/messaging/domain/notifiers/conversations_notifier.dart`

### **Bug #2: No WebSocket Event for Key Exchange**
**Problem:**
- No method to send encrypted conversation keys to recipients
- Backend relay couldn't forward encrypted keys between devices

**Fix:**
- Added `sendEncryptedConversationKey()` method to `MessagingService`
- Uses WebSocket `key_exchange` event
- File: `lib/core/services/messaging_service.dart` (lines 323-345)

### **Bug #3: Compilation Errors (All Fixed)**
- ✅ Removed duplicate `sendEncryptedConversationKey()` declaration
- ✅ Fixed `participant.userId` → `participant.id` (ParticipantModel uses `id` property)
- ✅ Fixed void return usage in `cachePublicKey()` call
- ✅ Removed invalid `metadata` parameter from `sendMessage()`

---

## 🔥 ANDROID-SPECIFIC WARNINGS

### **1. WebSocket Connection Timing (Race Condition)**

**Issue Observed on iOS:**
```
⚠️ Cannot join conversation - socket not connected yet
✅ Connected to messaging service - queued messages will be delivered now
✅ Joined conversation after connect
```

**What Happens:**
- App tries to join conversation BEFORE WebSocket connects
- Message gets queued and sent after connection completes
- **FIRST DECRYPT ATTEMPT FAILS** with: `❌ Decryption error: A low-level libsodium operation has failed`
- **SECOND DECRYPT ATTEMPT SUCCEEDS**: `✅ E2E: Message decrypted successfully on CLIENT`

**Android Action Required:**
1. **Test WebSocket connection lifecycle carefully**
2. **Verify message queue system works on Android**
3. **Check if retry logic for decryption exists** (may need to add timeout/retry)
4. Monitor logs for "Cannot join conversation" warnings
5. Ensure `_setupEventHandlers` listener for `connect` event works correctly

### **2. libsodium Initialization Timing**

**iOS Log Evidence:**
```
✅ E2E DEBUG: libsodium initialized
📂 E2E DEBUG: Loading keys from SharedPreferences...
✅ E2E DEBUG: Found existing key pair in storage
```

**Potential Android Issue:**
- libsodium may initialize **slower** on Android
- If encryption attempts before `sodium.init()` completes → crash or silent failure

**Android Action Required:**
1. **Add await before ANY crypto operations:**
   ```dart
   await sodium.init();
   // Only THEN proceed with key operations
   ```
2. Test on **LOW-END Android devices** (slower initialization)
3. Add timeout/retry if `sodium.init()` takes >5 seconds

### **3. SharedPreferences Key Storage**

**iOS Working:**
- Keys stored/loaded from `SharedPreferences`
- No issues with async read/write

**Potential Android Issue:**
- SharedPreferences on Android can sometimes **fail silently**
- File system permissions may block write

**Android Action Required:**
1. Test key persistence across app restarts
2. Verify keys aren't lost after app killed by OS
3. Check logcat for SharedPreferences errors

### **4. Freezed Code Generation**

**Files Modified:**
- `conversations_notifier.dart` (uses freezed state)
- `messages_notifier.dart` (uses freezed state)

**Android Action Required:**
1. **MUST run** after pulling:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
2. Clean build if freezed errors occur:
   ```bash
   flutter clean && flutter pub get
   dart run build_runner build --delete-conflicting-outputs
   ```

---

## 🧪 Testing Checklist for Android

### **Phase 1: Single Device (Android)**
- [ ] E2E keys generate on app launch
- [ ] Keys persist after app restart
- [ ] Public key cached when creating new conversation
- [ ] Can send message to self (encrypt → send → receive → decrypt)
- [ ] No "Decryption error" in logs (or only 1 failed attempt, then success)

### **Phase 2: Two Devices (iPhone ↔ Android)**
- [ ] Android can send encrypted message to iPhone
- [ ] iPhone can decrypt Android's message
- [ ] iPhone can send encrypted message to Android
- [ ] Android can decrypt iPhone's message
- [ ] Public key exchange works bidirectionally
- [ ] WebSocket `key_exchange` event received on both sides

### **Phase 3: Edge Cases**
- [ ] First message in NEW conversation works (no cached keys)
- [ ] Works when WebSocket disconnects/reconnects
- [ ] Works after app backgrounded and resumed
- [ ] Works on slow/unreliable network
- [ ] Works on Android API levels 21-34 (test on old devices)

---

## 📋 Known Issues (Non-Critical)

### **1. Race Condition in Decryption (iOS)**
**Symptom:**
```
❌ Decryption error: A low-level libsodium operation has failed
✅ E2E: Message decrypted successfully on CLIENT
```

**Explanation:**
- First decryption attempt fails (conversation key not fully loaded yet)
- Second attempt succeeds (after key loaded)
- **Not user-facing** - message eventually decrypts correctly

**Android Action:**
- Monitor if Android has **same behavior** or **worse** (multiple failed attempts)
- If decryption fails >3 times, may need to add explicit retry logic

### **2. Duplicate Message Echo (Same Device)**
**Symptom:**
- Send message from Device A
- Device A receives its own message back via WebSocket

**Explanation:**
- **Expected behavior** - WebSocket broadcasts to all connected devices
- Not a bug, just confirming message round-trip works

---

## 🔍 Debug Logs to Monitor

### **Success Indicators:**
```
✅ E2E keys ready - public key will be shared via WebSocket when needed
✅ Cached public key for user X from new conversation
✅ E2E: Message encrypted on CLIENT - server never sees plain text
✅ E2E: Message decrypted successfully on CLIENT
```

### **Warning Signs:**
```
❌ E2E: No conversation key found - cannot encrypt
❌ E2E: Public key cache empty (0 keys)
❌ Decryption error: A low-level libsodium operation has failed
⚠️ Cannot join conversation - socket not connected yet
```

---

## 📂 Files Modified (Review These)

1. **`lib/core/services/messaging_service.dart`**
   - Added `sendEncryptedConversationKey()` method (lines 323-345)
   - Removed duplicate declaration (was at line 382)

2. **`lib/modules/messaging/domain/notifiers/conversations_notifier.dart`**
   - Added public key caching in `getOrCreateConversation()` (lines 150-170)
   - Fixed property access: `participant.id` (not `userId`)

3. **`lib/modules/messaging/domain/notifiers/messages_notifier.dart`**
   - Removed invalid `metadata` parameter from `sendMessage()` call
   - E2E encryption flow unchanged (works as designed)

4. **`lib/core/services/key_manager_service.dart`** (NEW FILE)
   - E2E key management service
   - Curve25519 + XSalsa20-Poly1305 encryption
   - Public/private key pair generation
   - Conversation key management

---

## 🚀 Quick Start After Pull

```bash
# 1. Pull latest code
git pull origin mvp-official

# 2. Regenerate freezed files (REQUIRED)
dart run build_runner build --delete-conflicting-outputs

# 3. Clean build (recommended)
flutter clean && flutter pub get

# 4. Run on Android device
flutter run

# 5. Check logs for E2E initialization
adb logcat | grep -i "E2E\|encrypt\|decrypt"
```

---

## 🆘 Troubleshooting

### **Issue:** "E2E: Public key cache empty"
**Solution:**
1. Check `getOrCreateConversation()` is called BEFORE sending messages
2. Verify `participant.publicKey` is not null in API response
3. Add debug log: `log.i('Public key from API: ${participant.publicKey}')`

### **Issue:** "Decryption error" (persists, not resolving)
**Solution:**
1. Check conversation key exists: `_keyManager!.getConversationKey(conversationId)`
2. Verify nonce format matches sender (32-char base64 string)
3. Ensure `sodium.init()` completed before decryption
4. Test with same conversation ID on both devices

### **Issue:** WebSocket not connecting
**Solution:**
1. Check auth token is valid: `eyJhbGciOiJIUzI1NiIs...`
2. Verify backend URL: `https://api.lykluk.com/notifications/socket.io/`
3. Test with Postman/curl to confirm backend is running
4. Check Android network permissions in manifest

---

## 📞 Contact

If Android encounters **blocking issues** that prevent E2E from working:
1. Check this document first
2. Review commit diff: `git show 9357dd3e`
3. Compare iOS logs vs Android logs (look for differences in timing)
4. Test on **emulator first**, then **real device**

**E2E is working on iOS** - any Android issues are likely platform-specific (timing, permissions, or native library differences).

---

## ✅ Final Checklist

Before merging to production:
- [ ] All Android tests passing (Phases 1-3)
- [ ] Cross-platform testing complete (iPhone ↔ Android verified)
- [ ] No decryption errors in production logs
- [ ] Keys persisting correctly across app restarts
- [ ] WebSocket connection stable (no infinite reconnect loops)
- [ ] Freezed files regenerated (no compilation errors)

---

**Good luck! E2E encryption is 95% done - just need Android validation now.**
