allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("${project(":flutter_background_geolocation").projectDir}/libs") }
        maven { url = uri("https://developer.huawei.com/repo/") }
        maven { url = uri("${project(":background_fetch").projectDir}/libs") }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
