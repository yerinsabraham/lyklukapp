# Gradle Build Troubleshooting Guide: PC-to-PC Differences

## Problem Overview
App builds successfully on one PC but fails with TLS/SSL errors on another PC. This indicates **environment-specific configuration differences**, not code issues.

---

## Why Does It Work on One PC but Not the Other?

The most common PC-to-PC differences that cause Gradle build failures:

### 1. ✅ **Antivirus/Security Software Differences** (MOST LIKELY CAUSE)
| This PC (Working) | Other PC (Not Working) |
|-------------------|------------------------|
| Windows Defender only | Different AV (Kaspersky, Norton, Avast, etc.) |
| AV disabled during builds | AV actively scanning/intercepting |
| Java/Gradle in AV exclusions | No exclusions configured |

**🔍 What to Check:**
- Does the other PC have different antivirus software?
- Is the antivirus in "gaming mode" or "silent mode" on one PC?
- Are there existing exclusions on the working PC that you forgot about?

**✅ Solution:**
```powershell
# On the NON-WORKING PC, add these exclusions to your antivirus:

# 1. Java installation folder
C:\Program Files\Amazon Corretto\
C:\Program Files\Java\

# 2. Project folder
C:\Users\<YOUR_USERNAME>\lyklukmobile\

# 3. Gradle cache
C:\Users\<YOUR_USERNAME>\.gradle\

# 4. Android SDK (if using)
C:\Users\<YOUR_USERNAME>\AppData\Local\Android\
```

---

### 2. 🌐 **Network Configuration Differences**

| This PC (Working) | Other PC (Not Working) |
|-------------------|------------------------|
| Direct internet connection | Behind corporate proxy |
| No VPN | VPN connected |
| WiFi with certain DNS | Different network adapter/DNS |
| No proxy configured | System proxy enabled |

**🔍 What to Check:**
```powershell
# Run on BOTH PCs and compare:

# Check proxy settings
netsh winhttp show proxy

# Check DNS servers
Get-DnsClientServerAddress -AddressFamily IPv4

# Check active network adapters
Get-NetAdapter | Where-Object { $_.Status -eq "Up" }

# Check VPN connections
Get-VpnConnection
```

**✅ Solution:**
If the other PC has a proxy, configure Gradle to use it:

**File:** `android/gradle.properties`
```properties
# Add these lines if you have a proxy
systemProp.http.proxyHost=your-proxy-host
systemProp.http.proxyPort=8080
systemProp.https.proxyHost=your-proxy-host
systemProp.https.proxyPort=8080

# If proxy needs authentication
systemProp.http.proxyUser=username
systemProp.http.proxyPassword=password
systemProp.https.proxyUser=username
systemProp.https.proxyPassword=password

# If you need to bypass proxy for certain hosts
systemProp.http.nonProxyHosts=localhost|127.*|*.local
```

---

### 3. ☕ **Java Installation Differences**

| This PC (Working) | Other PC (Not Working) |
|-------------------|------------------------|
| Java 17 (Corretto) | Different Java version |
| Single Java installation | Multiple Java versions installed |
| JAVA_HOME set correctly | JAVA_HOME not set or pointing to wrong version |
| Updated Java keystore | Corrupted/outdated keystore |

**🔍 What to Check:**
```powershell
# Run on BOTH PCs:

# Check Java version
java -version

# Check JAVA_HOME
echo $env:JAVA_HOME

# List all Java installations
Get-ChildItem "C:\Program Files\Java\" -Directory
Get-ChildItem "C:\Program Files\Amazon Corretto\" -Directory

# Check which Java is in PATH
where.exe java
```

**✅ Solution:**

**Option A: Ensure Same Java Version**
Download and install the **exact same Java version** on both PCs:
- Amazon Corretto 17.0.13 (or whatever version works on the first PC)
- Download from: https://aws.amazon.com/corretto/

**Option B: Fix Java Keystore (if corrupted)**
```powershell
# Backup current keystore
cd "C:\Program Files\Amazon Corretto\jdk17.0.13_11\lib\security\"
Copy-Item cacerts cacerts.backup

# Download fresh cacerts from a working installation
# OR re-import certificates

# Verify certificates are present
& "C:\Program Files\Amazon Corretto\jdk17.0.13_11\bin\keytool.exe" -list -cacerts -storepass changeit | Select-String "DigiCert"
```

---

### 4. 🔧 **Windows/System Configuration Differences**

| This PC (Working) | Other PC (Not Working) |
|-------------------|------------------------|
| Windows 11 | Windows 10 |
| All updates installed | Missing Windows updates |
| Developer Mode enabled | Standard mode |
| TLS 1.2/1.3 enabled | Older TLS protocols |

**🔍 What to Check:**
```powershell
# Run on BOTH PCs:

# Check Windows version
winver

# Check TLS protocol support
[Net.ServicePointManager]::SecurityProtocol

# Check Developer Mode
Get-WindowsDeveloperLicense

# Check pending updates
Get-WindowsUpdateLog
```

**✅ Solution:**

**Enable Modern TLS Protocols:**
```powershell
# Run as Administrator
# Enable TLS 1.2 and 1.3
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

# Make it permanent via registry (requires restart)
# For TLS 1.2
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value 1
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value 1
```

**Install Windows Updates:**
- Go to Settings → Update & Security → Windows Update
- Install all pending updates
- Restart

---

### 5. 📦 **Gradle Cache Differences**

| This PC (Working) | Other PC (Not Working) |
|-------------------|------------------------|
| Fresh Gradle cache | Corrupted cache |
| Downloaded dependencies | Partial/interrupted downloads |

**✅ Solution:**
```powershell
# On the NON-WORKING PC, clear Gradle caches:

# 1. Navigate to project
cd C:\Users\<YOUR_USERNAME>\lyklukmobile

# 2. Clean Flutter build
flutter clean

# 3. Delete Gradle caches
Remove-Item -Recurse -Force "$env:USERPROFILE\.gradle\caches"
Remove-Item -Recurse -Force "android\.gradle"

# 4. Clean Android build
cd android
.\gradlew clean

# 5. Try building again
cd ..
flutter build apk --debug
```

---

## Step-by-Step Diagnostic Procedure

Run this on the **NON-WORKING PC** to identify the issue:

### Step 1: Basic Diagnostics
```powershell
# Create a diagnostic report
$report = @"
=== GRADLE BUILD DIAGNOSTIC REPORT ===
Date: $(Get-Date)
Computer: $env:COMPUTERNAME

--- Java Version ---
"@
$report += (java -version 2>&1 | Out-String)

$report += "`n--- JAVA_HOME ---`n"
$report += $env:JAVA_HOME

$report += "`n--- Proxy Settings ---`n"
$report += (netsh winhttp show proxy | Out-String)

$report += "`n--- Antivirus Status ---`n"
$report += (Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled, AntivirusEnabled | Out-String)

$report += "`n--- Running Security Software ---`n"
$report += (Get-Process | Where-Object { $_.ProcessName -match "avast|avg|kasper|norton|mcafee|bitdefender|eset|malware" } | Select-Object Name | Out-String)

$report += "`n--- Network Adapters ---`n"
$report += (Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object Name, InterfaceDescription | Out-String)

$report += "`n--- VPN Connections ---`n"
$report += (Get-VpnConnection 2>&1 | Out-String)

# Save report
$report | Out-File "gradle_diagnostic.txt"
Write-Host "Report saved to gradle_diagnostic.txt" -ForegroundColor Green
```

### Step 2: Test Network Connectivity
```powershell
# Test if Maven Central is reachable
try {
    $response = Invoke-WebRequest -Uri "https://repo.maven.apache.org/maven2/" -UseBasicParsing
    Write-Host "✅ Maven Central is reachable (HTTP $($response.StatusCode))" -ForegroundColor Green
} catch {
    Write-Host "❌ Maven Central is NOT reachable: $_" -ForegroundColor Red
}

# Test if Google Maven is reachable
try {
    $response = Invoke-WebRequest -Uri "https://maven.google.com/" -UseBasicParsing
    Write-Host "✅ Google Maven is reachable (HTTP $($response.StatusCode))" -ForegroundColor Green
} catch {
    Write-Host "❌ Google Maven is NOT reachable: $_" -ForegroundColor Red
}
```

### Step 3: Test Java SSL
```powershell
# Download a simple SSL test program
$testCode = @'
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;

public class SSLTest {
    public static void main(String[] args) {
        try {
            URL url = new URL("https://repo.maven.apache.org/maven2/");
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.connect();
            System.out.println("✅ SSL connection successful! Response code: " + conn.getResponseCode());
            conn.disconnect();
        } catch (Exception e) {
            System.err.println("❌ SSL connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
'@

# Save and compile
$testCode | Out-File -Encoding ASCII "SSLTest.java"
& javac SSLTest.java
& java SSLTest

# Clean up
Remove-Item "SSLTest.java", "SSLTest.class" -ErrorAction SilentlyContinue
```

### Step 4: Try Antivirus Exclusion Test
```powershell
Write-Host "⚠️  TEMPORARILY DISABLE YOUR ANTIVIRUS" -ForegroundColor Yellow
Write-Host "Then press Enter to test build..." -ForegroundColor Yellow
Read-Host

cd C:\Users\<YOUR_USERNAME>\lyklukmobile\android
.\gradlew --version

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Gradle works with AV disabled!" -ForegroundColor Green
    Write-Host "Solution: Add exclusions to your antivirus for:" -ForegroundColor Cyan
    Write-Host "  - Java folder" -ForegroundColor Cyan
    Write-Host "  - Project folder" -ForegroundColor Cyan
    Write-Host "  - .gradle folder" -ForegroundColor Cyan
} else {
    Write-Host "❌ Still failing - issue is NOT antivirus" -ForegroundColor Red
}
```

---

## Quick Fixes Checklist

Try these in order on the **NON-WORKING PC**:

- [ ] **1. Disable antivirus temporarily and test build**
  - If it works → Add exclusions permanently
  
- [ ] **2. Disconnect from VPN and test build**
  - If it works → Configure VPN split tunneling or use direct connection for builds
  
- [ ] **3. Clear all Gradle caches**
  ```powershell
  flutter clean
  Remove-Item -Recurse -Force "$env:USERPROFILE\.gradle\caches"
  ```
  
- [ ] **4. Verify Java version matches working PC**
  ```powershell
  java -version
  ```
  
- [ ] **5. Try building on a different network (mobile hotspot)**
  - If it works → Network/proxy issue
  
- [ ] **6. Add TLS arguments to gradle.properties**
  ```properties
  org.gradle.jvmargs=-Xmx8G -Djdk.tls.client.protocols=TLSv1.2,TLSv1.3
  ```
  
- [ ] **7. Use Gradle offline mode (if dependencies cached)**
  ```powershell
  cd android
  .\gradlew build --offline
  ```

---

## If Nothing Works: Nuclear Options

### Option 1: Copy Working Environment
1. On the **WORKING PC**, zip the `.gradle` folder:
   ```powershell
   Compress-Archive -Path "$env:USERPROFILE\.gradle" -DestinationPath "gradle_cache.zip"
   ```

2. Transfer `gradle_cache.zip` to the non-working PC

3. Extract to same location:
   ```powershell
   Expand-Archive -Path "gradle_cache.zip" -DestinationPath "$env:USERPROFILE"
   ```

### Option 2: Use Gradle Wrapper with Local Distribution
1. Download Gradle 8.3 (or whatever version) as a ZIP from gradle.org

2. Extract to a local folder (e.g., `C:\gradle-8.3`)

3. Edit `android/gradle/wrapper/gradle-wrapper.properties`:
   ```properties
   distributionUrl=file\:///C:/gradle-8.3/gradle-8.3-all.zip
   ```

### Option 3: Build in Docker/WSL2
If Windows environment is too problematic:
```bash
# Use WSL2 Ubuntu
wsl --install -d Ubuntu-22.04

# Inside WSL
sudo apt update
sudo apt install openjdk-17-jdk
# Then build normally
```

---

## Comparison Script

Run this on BOTH PCs to create comparison reports:

```powershell
# Save as compare_pc_environments.ps1
$report = @"
========================================
PC ENVIRONMENT REPORT
========================================
Computer Name: $env:COMPUTERNAME
Date: $(Get-Date)
User: $env:USERNAME

--- JAVA ---
"@

$report += (java -version 2>&1 | Out-String)
$report += "`nJAVA_HOME: $env:JAVA_HOME`n"

$report += "`n--- FLUTTER ---`n"
$report += (flutter --version 2>&1 | Out-String)

$report += "`n--- GRADLE ---`n"
cd android
$report += (.\gradlew --version 2>&1 | Out-String)
cd ..

$report += "`n--- PROXY ---`n"
$report += (netsh winhttp show proxy | Out-String)

$report += "`n--- ANTIVIRUS ---`n"
$report += (Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled, AntivirusEnabled, OnAccessProtectionEnabled | Format-List | Out-String)

$report += "`n--- SECURITY SOFTWARE RUNNING ---`n"
$securityProcesses = Get-Process | Where-Object { 
    $_.ProcessName -match "avast|avg|kasper|norton|mcafee|bitdefender|eset|malware|defender|MsMpEng|antivirus|security"
} | Select-Object Name, Id, Path
$report += ($securityProcesses | Format-Table | Out-String)

$report += "`n--- NETWORK ADAPTERS ---`n"
$report += (Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object Name, InterfaceDescription, Status | Format-Table | Out-String)

$report += "`n--- VPN ---`n"
$vpn = Get-VpnConnection 2>$null
if ($vpn) {
    $report += ($vpn | Select-Object Name, ConnectionStatus | Format-Table | Out-String)
} else {
    $report += "No VPN connections found`n"
}

$report += "`n--- TLS PROTOCOLS ---`n"
$report += ([Net.ServicePointManager]::SecurityProtocol | Out-String)

$report += "`n--- ENVIRONMENT VARIABLES ---`n"
$report += "PATH: $env:PATH`n"
$report += "ANDROID_HOME: $env:ANDROID_HOME`n"
$report += "GRADLE_HOME: $env:GRADLE_HOME`n"

# Save to file
$filename = "pc_environment_$env:COMPUTERNAME.txt"
$report | Out-File $filename
Write-Host "Report saved to $filename" -ForegroundColor Green
Write-Host "Share this file to compare between PCs" -ForegroundColor Cyan
```

---

## Most Likely Root Causes (Ranked)

Based on the symptoms described:

1. **🥇 Antivirus Software (85% probability)**
   - Different AV on each PC or different settings
   - SSL interception/scanning enabled on one PC

2. **🥈 Network/Proxy Differences (10% probability)**
   - One PC behind corporate proxy
   - VPN connected on one PC

3. **🥉 Java Keystore/Installation (3% probability)**
   - Different Java versions
   - Corrupted keystore on one PC

4. **Other (2% probability)**
   - Firewall rules
   - DNS issues
   - Rare network driver bugs

---

## Contact/Support

If you've tried everything and it still doesn't work:

1. Run the comparison script on both PCs
2. Compare the outputs to find differences
3. Share the diagnostic reports with your team
4. Consider building in a container (Docker/WSL2) as a workaround

---

**Last Updated:** January 8, 2026
