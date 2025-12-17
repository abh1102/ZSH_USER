# Keep Agora classes
-keep class io.agora.** { *; }
-dontwarn io.agora.**

# Keep ThrowableExtension for desugar runtime
-dontwarn com.google.devtools.build.android.desugar.runtime.ThrowableExtension

# Keep Hyphenate/Agora Chat push platform classes
-dontwarn com.hyphenate.**
-keep class com.hyphenate.** { *; }

# OPPO Push (Heytap)
-dontwarn com.heytap.msp.push.**
-keep class com.heytap.msp.push.** { *; }

# Meizu Push
-dontwarn com.meizu.cloud.pushsdk.**
-keep class com.meizu.cloud.pushsdk.** { *; }

# Vivo Push
-dontwarn com.vivo.push.**
-keep class com.vivo.push.** { *; }

# Xiaomi Push
-dontwarn com.xiaomi.mipush.sdk.**
-keep class com.xiaomi.mipush.sdk.** { *; }
