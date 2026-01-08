# Gradle TLS/SSL Build Failure - Diagnostic Report

## Problem Summary

The Android build is failing with **TLS/SSL handshake errors** when Gradle tries to download dependencies from Maven repositories.

---

## Error Messages

```
Could not GET 'https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/...'
   > Received fatal alert: bad_record_mac

Could not GET 'https://plugins.gradle.org/...'
   > Received fatal alert: illegal_parameter
```

---

## What We've Confirmed

| Test | Result |
|------|--------|
| PowerShell HTTPS to Maven | ✅ Works (HTTP 200) |
| Flutter pub get | ✅ Works |
| Gradle HTTPS to Maven | ❌ Fails with TLS errors |
| Java version | Amazon Corretto 17.0.13 |

**Key Finding:** The network works fine. PowerShell can reach Maven Central. The issue is **JVM-specific** - something is interfering with Java's SSL/TLS connections.

---

## Root Causes (Most Likely)

### 1. 🛡️ **Antivirus Software** (Most Common)
Antivirus programs often intercept HTTPS traffic to scan it. This "SSL inspection" can corrupt the TLS handshake.

**Common culprits:**
- Windows Defender (with SmartScreen)
- Kaspersky
- Avast
- Norton
- Bitdefender
- McAfee
- ESET

**How to test:**
1. Temporarily disable your antivirus real-time protection
2. Run the Gradle build again
3. If it works, add exceptions for:
   - `C:\Program Files\Amazon Corretto\` (or your Java path)
   - `C:\mobile_app_v2\`
   - `%USERPROFILE%\.gradle\`

### 2. 🌐 **VPN Software**
VPNs can interfere with TLS connections, especially those that do SSL inspection.

**How to test:**
1. Disconnect from any VPN
2. Try the build again

**Common VPNs that cause issues:**
- Corporate VPNs (Cisco AnyConnect, GlobalProtect, Zscaler)
- NordVPN, ExpressVPN (if split tunneling is misconfigured)

### 3. 🔒 **Corporate Firewall/Proxy**
If you're on a corporate network, there may be a proxy intercepting HTTPS.

**How to check:**
```powershell
# Check for system proxy
netsh winhttp show proxy

# Check environment variables
echo $env:HTTP_PROXY
echo $env:HTTPS_PROXY
```

**If proxy is set, configure Gradle:**
Add to `gradle.properties`:
```properties
systemProp.http.proxyHost=your-proxy-host
systemProp.http.proxyPort=your-proxy-port
systemProp.https.proxyHost=your-proxy-host
systemProp.https.proxyPort=your-proxy-port
```

### 4. 🔧 **Java Keystore Issues**
The Java installation might have a corrupted or misconfigured SSL certificate store.

**How to test:**
```powershell
# Test Java SSL connection directly
cd "C:\Program Files\Amazon Corretto\jdk17.0.13_11\bin"
.\keytool -list -cacerts -storepass changeit | Select-String "DigiCert"
```

If no DigiCert certificates appear, the keystore may be corrupted.

### 5. 📡 **Network Adapter/Driver Issues**
Rarely, network drivers can corrupt packets during TLS handshakes.

**How to test:**
- Try on a different network (mobile hotspot)
- Try on a wired connection instead of WiFi

---

## Quick Diagnostic Commands

Run these to help identify the issue:

```powershell
# 1. Check for VPN adapters
Get-NetAdapter | Where-Object { $_.InterfaceDescription -like "*VPN*" -or $_.InterfaceDescription -like "*Virtual*" }

# 2. Check for proxy settings
netsh winhttp show proxy

# 3. Check Windows Defender status
Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled, AntivirusEnabled

# 4. List running security software
Get-Process | Where-Object { $_.ProcessName -match "avast|avg|kasper|norton|mcafee|bitdefender|eset|malware|defender" }

# 5. Test Java SSL directly
& "C:\Program Files\Amazon Corretto\jdk17.0.13_11\bin\java.exe" -version
```

---

## Solutions to Try

### Solution A: Disable Antivirus Temporarily
1. Right-click antivirus icon in system tray
2. Disable real-time protection for 10 minutes
3. Run: `cd c:\mobile_app_v2\android; .\gradlew assembleDebug --no-daemon`
4. If it works, add Java and project folders to antivirus exclusions

### Solution B: Disconnect VPN
1. Disconnect any VPN
2. Try the build again

### Solution C: Use Mobile Hotspot
1. Connect your PC to your phone's mobile hotspot
2. Try the build again
3. If it works, the issue is your main network/firewall

### Solution D: Reinstall Java
1. Uninstall Amazon Corretto 17
2. Download fresh from: https://docs.aws.amazon.com/corretto/latest/corretto-17-ug/downloads-list.html
3. Install and try again

### Solution E: Use Different Java Version
```powershell
# Download and install Adoptium Temurin 17
winget install EclipseAdoptium.Temurin.17.JDK
```
Then update `JAVA_HOME` environment variable.

---

## What to Report Back

After testing, let me know:

1. **What antivirus are you using?**
2. **Are you on a VPN or corporate network?**
3. **Did any of the solutions work?**
4. **Output of these commands:**
   ```powershell
   netsh winhttp show proxy
   Get-NetAdapter | Select-Object Name, InterfaceDescription, Status
   ```

---

## Files Modified During Troubleshooting

These files were modified trying to fix the issue - they can be reverted if needed:

- `android/gradle.properties` - Added TLS/SSL JVM arguments
- `android/settings.gradle.kts` - Tried different Kotlin versions
- `android/app/build.gradle.kts` - Added Kotlin version resolution

---

## Technical Details

The `bad_record_mac` error means:
> The SSL/TLS layer detected that a received message's MAC (Message Authentication Code) doesn't match the expected value. This happens when data is corrupted or tampered with during transmission.

The `illegal_parameter` error means:
> A TLS handshake parameter was invalid or unexpected, often due to protocol version mismatches when something intercepts and re-encrypts traffic.

Both errors point to **something intercepting/modifying HTTPS traffic** between the JVM and the internet.
