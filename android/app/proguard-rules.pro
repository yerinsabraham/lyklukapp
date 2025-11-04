#############################################
# Flutter Plugins - General
#############################################

# Keep generated plugin registrant
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

#############################################
# Video Thumbnail Plugin
#############################################
-keep class xyz.justsoft.video_thumbnail.** { *; }

#############################################
# API Video Player (apivideo_player)
#############################################
-keep class video.api.player.** { *; }

#############################################
# Firebase (Firebase already has consumer rules,
# these are just to be safe for reflection)
#############################################
-keep class com.google.firebase.** { *; }

#############################################
# Google Play Services (safe minimal rule)
#############################################
-keep class com.google.android.gms.** { *; }

#############################################
# Gson / JSON serialization
#############################################
-keep class com.google.gson.** { *; }
-keepattributes *Annotation*