plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.zanaduhealth.beta"
    compileSdkVersion(35)
    ndkVersion = "27.0.12077973"
    compileOptions {
        sourceCompatibility(JavaVersion.VERSION_17)
        targetCompatibility(JavaVersion.VERSION_17)
    }

    kotlin {
        jvmToolchain(17) // Updated to Java 17
    }

    defaultConfig {
        applicationId = "com.zanaduhealth.beta"
        minSdkVersion(23)
        targetSdkVersion(flutter.targetSdkVersion)
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}