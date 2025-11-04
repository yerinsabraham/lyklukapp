import com.android.build.gradle.BaseExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    project.evaluationDependsOn(":app")

    // Force compileSdk / targetSdk for Android modules
    plugins.withId("com.android.library") {
        configure<BaseExtension> {
            compileSdkVersion(36)
            defaultConfig {
                targetSdkVersion(35)
            }
        }
    }
    plugins.withId("com.android.application") {
        configure<BaseExtension> {
            compileSdkVersion(36)
            defaultConfig {
                targetSdkVersion(35)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}