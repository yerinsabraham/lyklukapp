# LykLuk Custom Video Platform Architecture

## Building Your Own BytePlus Alternative: Complete Technical & Business Guide

**Author:** Development Team  
**Date:** January 18, 2026  
**Version:** 1.0  
**Purpose:** Replace BytePlus EffectOne SDK + MediaLive with custom in-house solution

---

## Executive Summary

### The Challenge
BytePlus currently costs approximately **$20,000/month** for:
- **EffectOne SDK**: Video recording, filters, effects, stickers, beauty, music, editing
- **MediaLive**: Live streaming infrastructure, encoding, CDN delivery

### The Opportunity
Build a custom solution with:
- **One-time development cost**: $8,000 - $15,000
- **Monthly operational costs**: $500 - $3,000 (scales with usage)
- **Break-even**: 1-2 months after launch
- **Long-term savings**: $200,000+ per year

### Feasibility Assessment: ✅ **VERY FEASIBLE**

**Why this is achievable:**
1. You're not building TikTok's algorithm - you're replacing camera/recording features
2. Modern APIs (Mux, AWS IVS, Agora) handle the hard parts (encoding, CDN, protocols)
3. Open-source libraries exist for camera effects (GPUImage, DeepAR cheaper alternatives)
4. Flutter has mature camera packages
5. You already have the app structure - just replacing the BytePlus components

---

## Part 1: Understanding What BytePlus Provides

### 1.1 BytePlus EffectOne SDK Features (Upload Flow)

| Feature | Complexity | Can We Build? | Recommended Approach |
|---------|-----------|---------------|---------------------|
| Camera Recording | Low | ✅ Yes | Flutter camera package |
| Basic Filters (50+) | Medium | ✅ Yes | GPUImage/LUT-based filters |
| Beauty Effects (face smoothing) | High | ⚠️ Partial | DeepAR or simpler ML solution |
| Face Detection/Tracking | High | ⚠️ Partial | Google ML Kit (free) |
| AR Stickers/Masks | Very High | ❌ Skip v1 | DeepAR ($) or skip |
| Video Trimming | Low | ✅ Yes | FFmpeg or native APIs |
| Music/Audio Overlay | Medium | ✅ Yes | FFmpeg + music library |
| Speed Control | Low | ✅ Yes | FFmpeg |
| Text Overlays | Low | ✅ Yes | Custom Flutter widget |
| Transitions | Medium | ✅ Yes | FFmpeg |
| Video Export | Medium | ✅ Yes | FFmpeg |
| Draft Box | Low | ✅ Yes | Local storage |

### 1.2 BytePlus MediaLive Features (Live Streaming)

| Feature | Complexity | Can We Build? | Recommended Approach |
|---------|-----------|---------------|---------------------|
| RTMP Ingest | None | ✅ Use API | Mux/AWS IVS handles this |
| Encoding (H.264/HEVC) | None | ✅ Use API | Cloud service handles this |
| Adaptive Bitrate (ABR) | None | ✅ Use API | Automatic with Mux/IVS |
| Global CDN | None | ✅ Use API | Included with service |
| Low-Latency (~2-5s) | None | ✅ Use API | WebRTC or LL-HLS |
| Real-time (~<500ms) | None | ✅ Use API | AWS IVS Real-Time/Agora |
| Chat | Low | ✅ Yes | Already have WebSocket |
| Recording/VOD | None | ✅ Use API | Automatic with Mux/IVS |

---

## Part 2: Recommended Architecture

### 2.1 High-Level System Design

```
┌─────────────────────────────────────────────────────────────────────┐
│                        LYKLUK CUSTOM PLATFORM                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │                    FLUTTER APP (Client)                       │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐   │  │
│  │  │   Camera    │  │   Video     │  │   Live Stream       │   │  │
│  │  │   Module    │  │   Editor    │  │   Module            │   │  │
│  │  │             │  │             │  │                     │   │  │
│  │  │ - camera    │  │ - FFmpeg    │  │ - RTMP push         │   │  │
│  │  │ - GPUImage  │  │ - Trimming  │  │ - Camera preview    │   │  │
│  │  │ - ML Kit    │  │ - Filters   │  │ - Beauty effects    │   │  │
│  │  │ - Filters   │  │ - Music     │  │ - Chat overlay      │   │  │
│  │  └─────────────┘  └─────────────┘  └─────────────────────┘   │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                               │                                      │
│                               ▼                                      │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │                     BACKEND (Your Server)                     │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐   │  │
│  │  │   Upload    │  │   Stream    │  │   Video             │   │  │
│  │  │   API       │  │   Manager   │  │   Processing        │   │  │
│  │  └──────┬──────┘  └──────┬──────┘  └──────────┬──────────┘   │  │
│  └─────────┼────────────────┼────────────────────┼──────────────┘  │
│            │                │                    │                  │
│            ▼                ▼                    ▼                  │
│  ┌──────────────────────────────────────────────────────────────┐  │
│  │                  THIRD-PARTY SERVICES                         │  │
│  │                                                                │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐   │  │
│  │  │   Mux       │  │   AWS IVS   │  │   Cloud Storage     │   │  │
│  │  │   Video     │  │   Live      │  │   (GCS/S3)          │   │  │
│  │  │             │  │             │  │                     │   │  │
│  │  │ - Encoding  │  │ - RTMP      │  │ - Video files       │   │  │
│  │  │ - CDN       │  │ - WebRTC    │  │ - Thumbnails        │   │  │
│  │  │ - Analytics │  │ - Chat      │  │ - Assets            │   │  │
│  │  └─────────────┘  └─────────────┘  └─────────────────────┘   │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 2.2 Component Breakdown

#### Module 1: Custom Camera Recording (Replaces BytePlus EffectOne Recorder)

**Technology Stack:**
- **Flutter Camera**: `camera: ^0.10.x` - Native camera access
- **GPUImage3 (iOS)** / **GPUImage (Android)**: GPU-accelerated filters
- **Google ML Kit**: Free face detection for basic beauty effects
- **LUT Filters**: Pre-built color lookup tables for Instagram-like filters

**Features for v1:**
- ✅ Front/back camera switching
- ✅ Video recording (up to 3 minutes for subscription limits)
- ✅ 20+ color filters (LUT-based)
- ✅ Basic beauty mode (smoothing via blur + ML Kit face detection)
- ✅ Flash/torch control
- ✅ Zoom control
- ✅ Timer (3s, 10s countdown)
- ✅ Grid overlay
- ⏳ AR stickers (v2 - requires DeepAR or similar)

**Implementation Approach:**

```dart
// lib/modules/camera/custom_camera_module.dart
class CustomCameraController {
  late CameraController _cameraController;
  late GPUImageFilter _currentFilter;
  
  // Initialize camera with filter pipeline
  Future<void> initialize() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: true,
    );
    await _cameraController.initialize();
    
    // Setup GPU filter pipeline
    _filterPipeline = FilterPipeline([
      ColorLookupFilter(lut: 'vintage.png'),
      BeautyFilter(intensity: 0.5),
    ]);
  }
  
  // Apply real-time filter
  void applyFilter(String filterName) {
    _currentFilter = FilterFactory.create(filterName);
    _filterPipeline.setFilter(_currentFilter);
  }
  
  // Record video with filters baked in
  Future<File> recordVideo() async {
    final outputPath = await _getOutputPath();
    await _cameraController.startVideoRecording();
    // Filters applied in real-time via GPU pipeline
    // ...
    await _cameraController.stopVideoRecording();
    return File(outputPath);
  }
}
```

**Native Integration (iOS - Swift):**

```swift
// ios/Runner/CustomCameraModule.swift
import GPUImage
import AVFoundation

class CustomCameraModule: NSObject {
    private var camera: Camera?
    private var filterPipeline: OperationGroup?
    private var movieOutput: MovieOutput?
    
    func setupCamera(with filter: BasicOperation) {
        camera = try? Camera(sessionPreset: .hd1280x720)
        
        // Create filter pipeline
        let saturation = SaturationAdjustment()
        saturation.saturation = 1.2
        
        let contrast = ContrastAdjustment()
        contrast.contrast = 1.1
        
        // Chain: Camera -> Filters -> Preview/Output
        camera --> saturation --> contrast --> renderView
        camera --> saturation --> contrast --> movieOutput
        
        camera?.startCapture()
    }
    
    func applyBeautyFilter(intensity: Float) {
        let blur = GaussianBlur()
        blur.blurRadiusInPixels = 3.0 * intensity
        // Apply only to skin regions using face detection mask
    }
}
```

#### Module 2: Video Editor (Replaces BytePlus EffectOne Editor)

**Technology Stack:**
- **FFmpeg (via ffmpeg_kit_flutter)**: Video processing, trimming, merging
- **Custom Flutter UI**: Timeline, preview, controls
- **audio_service**: Music overlay and audio management

**Features for v1:**
- ✅ Video trimming (start/end points)
- ✅ Video splitting and merging
- ✅ Speed control (0.5x, 1x, 2x, 3x)
- ✅ Music overlay from library
- ✅ Volume control (original vs music)
- ✅ Text overlays with fonts/colors
- ✅ Post-recording filter application
- ✅ Cover image selection
- ✅ Export in multiple resolutions
- ⏳ Transitions between clips (v2)
- ⏳ Picture-in-picture (v2)

**FFmpeg Commands for Common Operations:**

```bash
# Trim video
ffmpeg -i input.mp4 -ss 00:00:05 -t 00:00:10 -c copy output.mp4

# Add music overlay
ffmpeg -i video.mp4 -i music.mp3 -c:v copy -c:a aac -shortest output.mp4

# Apply filter (LUT)
ffmpeg -i input.mp4 -vf "lut3d=filter.cube" output.mp4

# Change speed (2x)
ffmpeg -i input.mp4 -filter:v "setpts=0.5*PTS" -filter:a "atempo=2.0" output.mp4

# Add text overlay
ffmpeg -i input.mp4 -vf "drawtext=text='Hello':fontsize=24:fontcolor=white:x=10:y=10" output.mp4

# Merge multiple videos
ffmpeg -f concat -safe 0 -i files.txt -c copy output.mp4

# Export with specific resolution and bitrate
ffmpeg -i input.mp4 -vf "scale=1080:1920" -b:v 5M -c:a copy output.mp4
```

**Flutter Implementation:**

```dart
// lib/modules/editor/video_editor_service.dart
class VideoEditorService {
  // Trim video
  Future<String> trimVideo({
    required String inputPath,
    required Duration start,
    required Duration end,
  }) async {
    final outputPath = await _getOutputPath('trimmed_video.mp4');
    
    await FFmpegKit.execute(
      '-i $inputPath '
      '-ss ${_formatDuration(start)} '
      '-t ${_formatDuration(end - start)} '
      '-c copy $outputPath'
    );
    
    return outputPath;
  }
  
  // Add music
  Future<String> addMusic({
    required String videoPath,
    required String musicPath,
    double videoVolume = 0.3,
    double musicVolume = 0.7,
  }) async {
    final outputPath = await _getOutputPath('with_music.mp4');
    
    await FFmpegKit.execute(
      '-i $videoPath -i $musicPath '
      '-filter_complex "[0:a]volume=$videoVolume[v];[1:a]volume=$musicVolume[m];[v][m]amix=inputs=2[a]" '
      '-map 0:v -map "[a]" -c:v copy -c:a aac -shortest $outputPath'
    );
    
    return outputPath;
  }
  
  // Apply filter
  Future<String> applyFilter({
    required String inputPath,
    required String lutPath,
  }) async {
    final outputPath = await _getOutputPath('filtered_video.mp4');
    
    await FFmpegKit.execute(
      '-i $inputPath '
      '-vf "lut3d=$lutPath" '
      '-c:a copy $outputPath'
    );
    
    return outputPath;
  }
  
  // Change speed
  Future<String> changeSpeed({
    required String inputPath,
    required double speed,
  }) async {
    final outputPath = await _getOutputPath('speed_changed.mp4');
    final videoPts = 1.0 / speed;
    final audioTempo = speed;
    
    await FFmpegKit.execute(
      '-i $inputPath '
      '-filter:v "setpts=${videoPts}*PTS" '
      '-filter:a "atempo=$audioTempo" '
      '$outputPath'
    );
    
    return outputPath;
  }
}
```

#### Module 3: Live Streaming (Replaces BytePlus MediaLive)

**Recommended Service: AWS IVS (Amazon Interactive Video Service)**

**Why AWS IVS:**
- ✅ **Pay-per-use pricing** (no monthly minimums)
- ✅ **Flutter SDK available** (via community packages)
- ✅ **Low-latency streaming** (~2-5 seconds)
- ✅ **Real-time streaming option** (WebRTC, <500ms)
- ✅ **Built-in chat** (free with video input hours)
- ✅ **Automatic recording to S3**
- ✅ **Global CDN included**
- ✅ **No encoding expertise needed**

**Pricing (AWS IVS):**
- Video Input: $0.20/hour (basic channel) to $2.00/hour (advanced)
- Video Output: $0.036-$0.144/hour per viewer (Full HD)
- Real-time: $0.072/participant/hour
- Chat: 2,700 free messages per video hour

**Estimated Monthly Costs (scaling example):**
- 100 streamers × 2 hours/day × 30 days = 6,000 input hours
- Input cost @ basic: 6,000 × $0.20 = $1,200/month
- Output (10,000 viewer hours @ HD): 10,000 × $0.072 = $720/month
- **Total: ~$2,000/month** (vs $20,000 for BytePlus)

**Alternative: Mux Live**
- Slightly simpler API
- Better analytics
- Starting at $0.020/minute for live video
- Great for on-demand video too

**Flutter Implementation with AWS IVS:**

```dart
// lib/modules/livestream/ivs_stream_service.dart
class IVSStreamService {
  // Create a new live stream channel
  Future<StreamChannel> createChannel(String userId) async {
    final response = await _backend.post('/streams/create', {
      'userId': userId,
      'type': 'BASIC', // or 'STANDARD' for multi-quality
      'latencyMode': 'LOW', // 2-5 seconds
    });
    
    return StreamChannel(
      channelArn: response['channelArn'],
      ingestEndpoint: response['ingestEndpoint'],
      streamKey: response['streamKey'],
      playbackUrl: response['playbackUrl'],
    );
  }
  
  // Start RTMP broadcast from mobile
  Future<void> startBroadcast(StreamChannel channel) async {
    // Use flutter_rtmp_broadcaster or similar package
    await _rtmpBroadcaster.initialize(
      rtmpUrl: 'rtmps://${channel.ingestEndpoint}/app',
      streamKey: channel.streamKey,
      resolution: Resolution.hd720,
      bitrate: 2500000, // 2.5 Mbps
      fps: 30,
    );
    
    await _rtmpBroadcaster.startBroadcast();
  }
  
  // Watch a live stream
  Widget buildPlayer(String playbackUrl) {
    return IVSPlayer(
      playbackUrl: playbackUrl,
      autoPlay: true,
      lowLatency: true,
    );
  }
}
```

**Backend Integration (Node.js example):**

```javascript
// functions/src/streams/ivsService.ts
import { IvsClient, CreateChannelCommand } from "@aws-sdk/client-ivs";

const ivsClient = new IvsClient({ region: 'us-east-1' });

export async function createStreamChannel(userId: string) {
  const command = new CreateChannelCommand({
    name: `lykluk-${userId}-${Date.now()}`,
    type: 'BASIC',
    latencyMode: 'LOW',
    tags: {
      userId: userId,
      app: 'lykluk'
    }
  });
  
  const response = await ivsClient.send(command);
  
  return {
    channelArn: response.channel?.arn,
    ingestEndpoint: response.channel?.ingestEndpoint,
    streamKey: response.streamKey?.value,
    playbackUrl: response.channel?.playbackUrl,
  };
}
```

---

## Part 3: Implementation Phases

### Phase 1: Core Recording (Weeks 1-2)

**Goal:** Replace BytePlus camera with custom camera + basic filters

**Tasks:**
1. Set up Flutter camera with preview
2. Implement 10 LUT-based color filters
3. Add basic UI (record button, filter carousel, flip camera)
4. Implement video recording to local file
5. Basic beauty filter (Gaussian blur on face region)
6. Timer countdown
7. Flash control

**Deliverables:**
- Custom camera screen functional
- Videos record with filters applied
- Can switch between front/back camera

### Phase 2: Video Editor (Weeks 3-4)

**Goal:** Replace BytePlus editor with FFmpeg-based editor

**Tasks:**
1. Video trimming interface with timeline
2. FFmpeg integration for processing
3. Music library integration
4. Speed control implementation
5. Text overlay functionality
6. Cover image selection
7. Export with quality options

**Deliverables:**
- Full video editing pipeline
- Can trim, add music, change speed
- Export ready for upload

### Phase 3: Live Streaming (Weeks 5-6)

**Goal:** Replace BytePlus MediaLive with AWS IVS/Mux

**Tasks:**
1. Backend: Stream channel creation API
2. RTMP broadcasting from mobile
3. Live player integration
4. Chat integration (use existing WebSocket)
5. Stream health monitoring
6. Recording to cloud storage

**Deliverables:**
- Can go live from app
- Viewers can watch with low latency
- Chat works during stream

### Phase 4: Polish & Advanced Features (Weeks 7-8)

**Goal:** Parity with BytePlus features + improvements

**Tasks:**
1. Add more filters (20+)
2. Improve beauty algorithm
3. Add transitions in editor
4. Draft saving functionality
5. Performance optimization
6. Error handling & edge cases
7. Analytics integration

**Deliverables:**
- Production-ready custom platform
- Feature parity with BytePlus
- Performance benchmarks met

---

## Part 4: Cost Analysis

### 4.1 Development Costs (One-Time)

| Item | Hours | Rate | Cost |
|------|-------|------|------|
| Camera Module (iOS + Android) | 80 | $50/hr | $4,000 |
| Video Editor (FFmpeg integration) | 60 | $50/hr | $3,000 |
| Live Streaming Integration | 40 | $50/hr | $2,000 |
| UI/UX (Flutter screens) | 40 | $50/hr | $2,000 |
| Backend APIs | 30 | $50/hr | $1,500 |
| Testing & Bug Fixes | 40 | $50/hr | $2,000 |
| **Total Development** | **290** | - | **$14,500** |

### 4.2 Monthly Operational Costs (Estimates)

**Scenario A: Early Stage (1,000 users, 50 active streamers)**
| Service | Usage | Monthly Cost |
|---------|-------|--------------|
| AWS IVS Input | 300 hours | $60 |
| AWS IVS Output | 5,000 viewer-hours | $360 |
| IVS Chat | Included | $0 |
| Cloud Storage (GCS) | 500 GB | $10 |
| Backend (existing) | - | $0 |
| **Total** | - | **$430/month** |

**Scenario B: Growth (10,000 users, 500 active streamers)**
| Service | Usage | Monthly Cost |
|---------|-------|--------------|
| AWS IVS Input | 3,000 hours | $600 |
| AWS IVS Output | 50,000 viewer-hours | $3,600 |
| IVS Chat | Included | $0 |
| Cloud Storage (GCS) | 5 TB | $100 |
| **Total** | - | **$4,300/month** |

**Scenario C: Scale (100,000 users, 2,000 active streamers)**
| Service | Usage | Monthly Cost |
|---------|-------|--------------|
| AWS IVS Input | 12,000 hours | $2,400 |
| AWS IVS Output | 500,000 viewer-hours | $36,000 |
| IVS Chat | Included | $0 |
| Cloud Storage (GCS) | 20 TB | $400 |
| **Total** | - | **$38,800/month** |

### 4.3 Cost Comparison Summary

| Metric | BytePlus | Custom Solution |
|--------|----------|-----------------|
| **Upfront Cost** | $0 | $14,500 |
| **Monthly (Early)** | $20,000 | $430 |
| **Monthly (Growth)** | $20,000+ | $4,300 |
| **Monthly (Scale)** | $50,000+ | $38,800 |
| **Annual (Early Stage)** | $240,000 | $5,160 + $14,500 = $19,660 |
| **Annual Savings** | - | **$220,340 (92%)** |

---

## Part 5: Technical Requirements

### 5.1 Flutter Packages Required

```yaml
# pubspec.yaml additions
dependencies:
  # Camera
  camera: ^0.10.5+5
  camera_platform_interface: ^2.6.0
  
  # Video Processing
  ffmpeg_kit_flutter: ^6.0.3
  video_player: ^2.8.2
  
  # Live Streaming (AWS IVS)
  amazon_ivs_player: ^1.0.0  # or custom plugin
  
  # Face Detection
  google_mlkit_face_detection: ^0.9.0
  
  # File Management
  path_provider: ^2.1.1
  
  # Music
  just_audio: ^0.9.36
  audio_service: ^0.18.12
```

### 5.2 Native Dependencies

**iOS (Podfile):**
```ruby
pod 'GPUImage3', :git => 'https://github.com/BradLarson/GPUImage3.git'
pod 'AmazonIVSPlayer', '~> 1.21.0'
pod 'AmazonIVSBroadcast', '~> 1.12.0'
```

**Android (build.gradle):**
```groovy
implementation 'jp.co.cyberagent.android:gpuimage:2.1.0'
implementation 'com.amazonaws:ivs-broadcast:1.12.0'
implementation 'com.amazonaws:ivs-player:1.21.0'
```

### 5.3 Backend Requirements

**New Endpoints Needed:**
```
POST /api/streams/create      - Create IVS channel
GET  /api/streams/{id}        - Get stream details
POST /api/streams/{id}/end    - End stream
GET  /api/streams/active      - List active streams
POST /api/videos/process      - Queue video for processing
GET  /api/filters             - Get available filters list
POST /api/music/search        - Search music library
```

### 5.4 Asset Requirements

**Filters (LUT files):**
- 20-30 .cube or .png LUT files
- Available from sites like filtergrade.com or create custom
- Cost: ~$50-200 for a pack or free alternatives

**Music Library:**
- License royalty-free music (Epidemic Sound, Artlist)
- Or integrate with existing music service
- Cost: $15-50/month for licensing

---

## Part 6: Risk Assessment

### 6.1 Technical Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| GPUImage performance issues | Medium | High | Fallback to native AVFoundation/Camera2 |
| FFmpeg processing slow | Low | Medium | Use hardware encoding, queue processing |
| RTMP reliability | Low | High | AWS IVS handles infrastructure |
| Face detection accuracy | Medium | Medium | Combine ML Kit + simple algorithms |
| Video sync issues | Medium | High | Thorough testing, use proven libraries |

### 6.2 Business Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Feature parity gap | Medium | Medium | Prioritize most-used features |
| User experience regression | Medium | High | A/B test before full rollout |
| Development timeline overrun | Medium | Medium | Buffer time, prioritize MVP |
| AWS costs higher than expected | Low | Medium | Implement usage limits, monitor closely |

### 6.3 Mitigation Strategy

**Hybrid Approach:**
- Keep BytePlus as backup during transition
- Roll out custom solution to 10% of users first
- Monitor metrics (completion rate, user feedback)
- Full migration after 1 month of stable operation

---

## Part 7: Team Recommendations

### 7.1 Roles for Singapore Technical Team

Based on the CEO mentioning experienced developers in Singapore, here's how to divide work:

| Role | Responsibility | Skills Needed |
|------|----------------|---------------|
| **You (Lead)** | Architecture, Flutter integration, project management | Flutter, iOS, Android |
| **Team Member 1** | Native camera modules (iOS Swift) | Swift, Metal, GPUImage |
| **Team Member 2** | Native camera modules (Android Kotlin) | Kotlin, Camera2, OpenGL |
| **Team Member 3** | Backend & Cloud (AWS IVS) | Node.js, AWS, Video APIs |

### 7.2 Communication Structure

```
WhatsApp Group: "LykLuk Video Platform"
├── Daily standup message (what you're working on)
├── Technical questions thread
├── PR review requests
└── Weekly video call (30 min)
```

---

## Part 8: Step-by-Step Foundation Guide

### Week 1: Setup & Camera Basics

**Day 1-2: Project Setup**
```bash
# Create new Flutter package for camera
flutter create --template=package lykluk_camera

# Add to main project
# In pubspec.yaml:
dependencies:
  lykluk_camera:
    path: ../packages/lykluk_camera
```

**Day 3-4: Basic Camera Implementation**
1. Implement camera preview
2. Add record button
3. Test on iOS and Android
4. Implement camera flip

**Day 5-7: Filter Foundation**
1. Integrate GPUImage (iOS) / GPUImage-Android
2. Create 3 test filters
3. Apply filters to camera preview
4. Verify recording captures filtered video

### Week 2: Camera Polish & More Filters

**Day 1-3: Add 10+ Filters**
1. Source or create LUT files
2. Implement filter carousel UI
3. Real-time filter switching

**Day 4-5: Beauty Mode**
1. Integrate ML Kit face detection
2. Apply Gaussian blur to face region
3. Add intensity slider

**Day 6-7: Recording Features**
1. Timer countdown
2. Flash control
3. Duration limit (subscription tiers)

### Week 3-4: Video Editor

**Day 1-3: FFmpeg Setup**
```dart
// Test FFmpeg installation
await FFmpegKit.execute('-version');
```

**Day 4-7: Trimming**
1. Build timeline UI
2. Implement start/end selection
3. FFmpeg trim command
4. Preview trimmed result

**Week 4:**
1. Speed control
2. Music overlay
3. Text overlays
4. Export pipeline

### Week 5-6: Live Streaming

**Day 1-2: AWS IVS Setup**
1. Create AWS account (if needed)
2. Set up IAM permissions
3. Create test channel via console

**Day 3-5: Backend Integration**
1. Implement channel creation API
2. Store channel info in database
3. Handle stream lifecycle

**Day 6-7: Mobile Broadcast**
1. RTMP broadcaster setup
2. Camera preview with broadcast
3. Test end-to-end

### Week 6: Player & Chat

1. Integrate IVS player
2. Connect existing WebSocket chat
3. Handle stream events
4. Recording configuration

### Week 7-8: Polish & Testing

1. Performance optimization
2. Edge case handling
3. UI polish
4. User testing
5. Gradual rollout

---

## Part 9: Conclusion & Recommendations

### Summary

| Aspect | Assessment |
|--------|------------|
| **Feasibility** | ✅ Highly feasible |
| **Timeline** | 6-8 weeks with dedicated effort |
| **Cost Savings** | $200,000+/year after first year |
| **Technical Risk** | Medium (mitigated with good architecture) |
| **Business Risk** | Low (can run parallel with BytePlus) |

### Recommended Approach

1. **Start with the camera module** - it's the most visible change
2. **Use AWS IVS for streaming** - proven, cost-effective, good SDK
3. **Keep BytePlus as backup** - don't remove until custom is stable
4. **Leverage the Singapore team** - divide native work between specialists
5. **Iterate on features** - ship MVP, add advanced features over time

### Success Metrics

- Camera recording works on 95%+ of devices
- Video export completes in < 30 seconds
- Live stream latency < 5 seconds
- No increase in user-reported bugs
- Monthly cost < $5,000 at current scale

---

## Appendix A: Quick Commands Reference

### FFmpeg Common Operations

```bash
# Get video info
ffprobe -v quiet -print_format json -show_format -show_streams input.mp4

# Convert to HLS
ffmpeg -i input.mp4 -codec: copy -start_number 0 -hls_time 10 -hls_list_size 0 -f hls output.m3u8

# Add watermark
ffmpeg -i input.mp4 -i logo.png -filter_complex "overlay=10:10" output.mp4

# Generate thumbnail
ffmpeg -i input.mp4 -ss 00:00:01 -vframes 1 thumbnail.jpg

# Compress video
ffmpeg -i input.mp4 -vcodec libx264 -crf 28 output.mp4
```

### AWS IVS CLI Commands

```bash
# Create channel
aws ivs create-channel --name "lykluk-test" --type BASIC --latency-mode LOW

# List channels
aws ivs list-channels

# Get stream key
aws ivs create-stream-key --channel-arn <ARN>

# Get stream info
aws ivs get-stream --channel-arn <ARN>
```

---

## Appendix B: Alternative Services Comparison

| Service | Upload/VOD | Live Streaming | Pricing Model | Flutter SDK |
|---------|------------|----------------|---------------|-------------|
| **Mux** | ✅ Excellent | ✅ Good | Per-minute | ✅ Yes |
| **AWS IVS** | ⚠️ Via S3 | ✅ Excellent | Per-hour | ✅ Community |
| **Cloudflare Stream** | ✅ Good | ✅ Good | Per-minute | ❌ REST only |
| **Agora** | ❌ No | ✅ Excellent | Per-minute | ✅ Yes |
| **api.video** | ✅ Good | ✅ Good | Per-minute | ❌ REST only |

**Recommendation:** AWS IVS for live + Mux for VOD processing

---

## Appendix C: Resources & Documentation

### Official Documentation
- [Flutter Camera](https://pub.dev/packages/camera)
- [FFmpeg Kit](https://github.com/arthenica/ffmpeg-kit)
- [GPUImage3](https://github.com/BradLarson/GPUImage3)
- [AWS IVS](https://docs.aws.amazon.com/ivs/)
- [Mux Video](https://docs.mux.com/)
- [Google ML Kit](https://developers.google.com/ml-kit)

### Tutorials & Examples
- [Flutter Video Recording Tutorial](https://flutter.dev/docs/cookbook/plugins/picture-using-camera)
- [GPUImage iOS Tutorial](https://www.raywenderlich.com/video-processing-with-gpuimage)
- [AWS IVS Getting Started](https://docs.aws.amazon.com/ivs/latest/userguide/getting-started.html)

---

*Document Version 1.0 - January 18, 2026*
