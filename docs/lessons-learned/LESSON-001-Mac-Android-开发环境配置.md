# 教训：Mac 上 Android 开发环境配置的坑

**日期：** 2026-04-26

---

## 教训 1：Gradle 下载慢甚至失败

**场景：** 在 Mac 上首次构建 Flutter Android 项目，Gradle 下载极慢或失败。

**原因：**
- Gradle 官方仓库在国外（services.gradle.org）
- Mac 网络访问国外资源不稳定

**正确做法：**
1. 配置国内镜像（腾讯云/阿里云）

编辑 `android/gradle/wrapper/gradle-wrapper.properties`：
```properties
# 腾讯云镜像（已验证可用）
distributionUrl=https\://mirrors.cloud.tencent.com/gradle/gradle-8.12-all.zip
```

编辑 `android/build.gradle.kts` 和 `android/settings.gradle.kts`：
```kotlin
allprojects {
    repositories {
        maven { url = uri("https://maven.aliyun.com/repository/google") }
        maven { url = uri("https://maven.aliyun.com/repository/public") }
        maven { url = uri("https://maven.aliyun.com/repository/gradle-plugin") }
        google()
        mavenCentral()
    }
}
```

2. 验证镜像可用性
```bash
curl -I https://mirrors.cloud.tencent.com/gradle/gradle-8.12-all.zip
```

**触发条件：**
- Mac 首次构建 Android 项目
- 网络无法直接访问 Google/Gradle

---

## 教训 2：NDK 下载极慢或超时

**场景：** Android 项目需要 NDK，下载卡住不动。

**原因：**
- NDK 从 Google 下载，体积大（700MB-1GB）
- 国内网络访问 Google 仓库极慢

**正确做法：**
1. 手动下载 NDK DMG 安装包
   - 腾讯云/阿里云可能没有 NDK 镜像
   - 可以从 Google 官网用浏览器下载（有进度显示）

2. 手动安装 NDK
```bash
# 挂载 DMG
open ~/Downloads/android-ndk-r27d-darwin.dmg

# 查看卷名
ls /Volumes/

# 创建目标目录
mkdir -p ~/Library/Android/sdk/ndk/27.3.13750724/

# 复制 NDK 文件（DMG 里的 .app 包内）
cp -r "/Volumes/Android NDK r27d/AndroidNDK13750724.app/Contents/NDK/"* \
  ~/Library/Android/sdk/ndk/27.3.13750724/

# 弹出 DMG
hdiutil detach "/Volumes/Android NDK r27d"
```

3. 配置项目使用指定 NDK 版本
编辑 `android/app/build.gradle.kts`：
```kotlin
android {
    ndkVersion = "27.3.13750724"  // 指定已安装的版本
}
```

**触发条件：**
- 项目使用 flutter_local_notifications 等需要 NDK 的插件
- Mac 网络访问 Google 极慢

---

## 教训 3：Android SDK 命令行工具需要 Java 环境

**场景：** 尝试用 sdkmanager 配置镜像，但报错 "Unable to locate a Java Runtime"。

**原因：**
- Android SDK 的 cmdline-tools 需要 Java
- Mac 默认不带 Java

**正确做法：**
- 绕过 sdkmanager，直接手动配置
- 或者安装 Android Studio（内置 Java）

---

## 教训 4：Mac 模拟器性能比 Linux 慢

**场景：** 同样的 Flutter 项目，在 Linux 上构建快，Mac 上慢很多。

**原因：**
- Mac (M1/M2/M3) 是 ARM 架构
- Android 模拟器默认 ARM64，需要 Rosetta 转译
- 转译导致性能下降

**优化方案：**
使用 x86_64 架构的模拟器（如果不需要 ARM 原生测试）：
```bash
# 创建 x86_64 模拟器
flutter emulator --create -n x86_64_avd -t android
flutter run -d x86_64_avd
```

---

## 教训 5：flutter clean 不会删除 Gradle 和 NDK 缓存

**场景：** 担心 flutter clean 会删除已下载的 Gradle/NDK。

**真相：**
- `flutter clean` 只删除项目内的 `build/` 和 `.dart_tool/`
- Gradle 缓存在 `~/.gradle/`
- NDK 缓存在 `~/Library/Android/sdk/ndk/`
- 不会影响

---

## 教训 6：Android SDK 镜像不一定可用

**场景：** 尝试使用阿里云/腾讯云镜像，但返回 404。

**教训：**
- 镜像站点的路径不一定和官方一致
- 使用前先验证：`curl -I <镜像URL>`
- 腾讯云的 Gradle 镜像可用，但 Android SDK 仓库可能 404

---

## 后续建议

1. **首次在新 Mac 上配置 Android 开发环境时：**
   - 先配置 Gradle 镜像
   - 手动下载并安装 NDK（提前准备好）
   - 确认 Android SDK 镜像可用性

2. **国内镜像站点：**
   - Gradle: `https://mirrors.cloud.tencent.com/gradle/`
   - Maven (阿里云): `https://maven.aliyun.com/repository/google` 等

3. **NDK 下载地址：**
   - 暂无可靠的国内 NDK 镜像
   - 建议用浏览器从 Google 官网下载，或找离线包

---

## 相关文件

- `android/gradle/wrapper/gradle-wrapper.properties` - Gradle 镜像配置
- `android/build.gradle.kts` - 项目级仓库镜像
- `android/settings.gradle.kts` - 设置级仓库镜像
- `android/app/build.gradle.kts` - NDK 版本指定
