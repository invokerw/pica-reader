import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// The default template signs release builds with ~/.android/debug.keystore,
// which AGP cannot create on this machine (AccessDeniedException on
// debug.keystore.lock). A project-local keystore keeps the signing identity
// stable across rebuilds and stays inside the workspace.
val signingProperties = Properties().apply {
    val file = rootProject.file("key.properties")
    if (file.exists()) file.inputStream().use { load(it) }
}
val localKeystore = signingProperties.getProperty("storeFile")?.let { rootProject.file(it) }

android {
    namespace = "local.pica.pica_reader"
    compileSdk = flutter.compileSdkVersion
    // Flutter 3.47 registers a synthetic externalNativeBuild CMake project in
    // every app project, so this build needs a real NDK even though the app has
    // no native code of its own. 28.2.13676358 (r28c) is installed locally in
    // .tools/android-sdk/ndk and is what flutter.ndkVersion resolves to.
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "local.pica.pica_reader"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            if (localKeystore != null && localKeystore.exists()) {
                signingConfigs.create("local") {
                    storeFile = localKeystore
                    storePassword = signingProperties.getProperty("storePassword")
                    keyAlias = signingProperties.getProperty("keyAlias")
                    keyPassword = signingProperties.getProperty("keyPassword")
                }
                signingConfig = signingConfigs.getByName("local")
            } else {
                // Fallback so a fresh clone still builds something installable.
                signingConfig = signingConfigs.getByName("debug")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
