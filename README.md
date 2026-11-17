# i短剧 (iDuanJu)

> **本项目完全免费、开源，禁止任何形式的付费分发 / 售卖。**
> 本项目以 **GPL-3.0** 协议发布：任何使用、修改、衍生本项目代码的作品，都必须同样以 GPL-3.0 开源并公开完整源代码。
> 如果你是花钱买到本 App 或本代码的，你被骗了，请举报卖家。

i短剧 是一个原生 SwiftUI 编写的 iOS 多源短剧 / 视频 / 漫画 / Telegram 频道聚合播放器，另有原生 Kotlin 编写的
[Android 版](#android-版)。App 本身**不托管任何内容**，所有数据都由你的设备直接向各个公开站点请求。

**下载（仅保留以下两个新版）**：

- [Android 1.5.13 发布页](https://github.com/my-name-is-alan/iDuanJu/releases/tag/v1.5.13-rank-cf-ui-android) · [直接下载 APK](https://github.com/my-name-is-alan/iDuanJu/releases/download/v1.5.13-rank-cf-ui-android/iDuanJu-1.5.13-rank-cf-ui-android.apk)
- [iOS 1.5 build 13 发布页](https://github.com/my-name-is-alan/iDuanJu/releases/tag/v1.5b13-rank-cf-ui) · [直接下载未签名 IPA](https://github.com/my-name-is-alan/iDuanJu/releases/download/v1.5b13-rank-cf-ui/STV-1.5b13-unsigned.ipa)

新版为 UI 重设计版，并包含此前的小说、红果取流与筛选修复。Android 与 1.5.8 使用同一分发签名，可下载 APK 覆盖安装；iOS IPA 需自行重签侧载。请下载 Assets 中的 APK / IPA，SHA-256 见同页附件。

### 2026-11-17 排行榜、验证与播放器修正版

- 新版说明：[1.5 b13 / Android 1.5.13](docs/releases/rank-cf-ui-1.5b13.md)。
- 真实书源列表探测：iOS 63/105、Android 68/105；并非所有站点都可用，详见说明。

## 2026-11-17 UI 重设计版（iOS 1.5 build 12 / Android 1.5.12）

更新内容见 [发布说明](docs/releases/ui-redesign-1.5b12.md)，验收范围与已知缺口见 [交付记录](docs/ui-redesign-1.5b11.md)。

### 2026-11-17 小说增强版

- 按真实合集 1335 修复发现分组、JS 生成请求、部分脚本与正文兼容，榜单改为顶部分组＋左侧栏目＋封面排名列表。
- 详情和阅读页加入缓存 / 下载、预取章数设置、同书换源与章节进度接续；已缓存文字可离线读取，失败后可继续下载。
- 番茄《十日终焉》、书旗《凡人修仙传》的榜单、搜索、目录、前三章正文及离线缓存已实际验证，并修复 Android 设备上的 ICU 正则与 JSON 桥接差异。小说榜单、搜索、书源配置和缓存页统一使用应用蓝色主题及浅深色背景。完整范围见 [本轮验收记录](docs/novel-followup-20261117.md)；图片正文和部分 403 来源仍不支持。

使用：小说 → 书源 → 导入自己的 Legado 合集 → 在榜单顶部选源、左侧选栏目。详情或阅读页进入“下载 / 缓存”，可缓存后 50 / 200 章或全本、调整提前缓存章数；“换源”会查找同名同作者书籍并接续章节。下载时保持应用前台，已缓存文字可离线阅读。本轮用 [合集 1335](https://www.yckceo.com/yuedu/shuyuans/json/id/1335.json) 做测试，不把第三方书源内置到安装包。

以下是原生模拟器中的合成数据布局验收图，真实书源测试结果单独记录：

<img src="docs/screenshots/novel-rank.png" width="280" alt="小说分组榜单布局">
<img src="docs/screenshots/novel-download.png" width="280" alt="缓存下载和阅读预取设置">

### 2026-11-16 更新

- 红果取流与筛选同步至 gateway `0613b49`：当前 Medusa 播放签名、同身份端点回退与有界换设备；筛选请求独立使用 551，按真人剧 / 漫剧 / AI 剧加载对应面板。上述修复已包含在顶部两个新版中。

- 修复 Actions：Android 使用 Maven Central 镜像、Gradle 缓存和有界重试；iOS 保留完整编译日志并作为 artifact 上传。
- 苹果 CMS：首页按分类独立分页、刷新完整分类列表、显示上游错误与空分类提示。部分接口的“电影”等父分类本身无资源，请选择“动作片”等子分类。
- 小说：iOS 新增“发现好书”，读取已导入书源的 `exploreUrl` / `ruleExplore`；支持文本、JSON 和 JS 生成的栏目。
- Android 新增剧星榜、演员名搜索入口、小说 TXT 阅读、书源导入、搜索、发现栏目、目录、章节阅读与续读；新增预加载开关与 100–2000 MB 缓存设置。
- Android 修复 CENC 样本描述、IV、全明文子样本、`saiz/saio` 和分片解析；使用已知明文回归测试。修复去广告开关持久化与缓存文件写入检查。

**Android 安装提醒**：1.5.8 起发布包使用固定分发签名。此前版本使用调试签名，如果系统提示签名不一致，需要先保存书源、插件和采集站配置，再卸载旧版后安装。卸载会清除应用本地数据；此后同一分发签名的版本可覆盖更新。

## 功能

- **内置源**：红果短剧（本地签名、匿名设备）、黄果（AI 短剧 / 视频）、Telegram 频道（网页预览 + 可选 TDLib 登录）
- **长视频站点**（18+，默认关闭）：MissAV、Jable、SupJav、Hanime1、Pornhub、XVideos、Eporner 等
- **漫画**：MangaDex、包子漫画，以及 JS 插件（manga18fx / komikindo / 18comic，18+，默认关闭）
- **小说**：iOS 支持 TXT / EPUB、阅读书源、搜索、发现、阅读进度与朗读；Android 支持 TXT 和部分 Legado 书源。双端支持分组榜单、预取、章节下载、离线阅读与同书换源，兼容范围见下文。
- **JS 插件系统**：基于 QuickJS 的沙箱，每个插件独立运行、只能访问自己声明且你同意过的域名，cookie / 存储互相隔离，
  不能 `eval`、访问不到本机和内网。支持从网址 / 文件 / 粘贴添加，以及订阅列表。规范见 [`docs/plugins/SPEC_ZH.md`](docs/plugins/SPEC_ZH.md)
- **苹果 CMS v10 采集站**通用适配（m3u8 / mp4 直链）
- **播放内核**：默认 [AetherEngine](https://github.com/superuser404notfound/AetherEngine)（FFmpeg 解封装 + 系统硬解，支持 MKV/FLV/AVI、真实音轨 / 字幕列表、HDR / 杜比视界），
  遇到 CENC / FairPlay 或加载失败时自动回退系统 AVPlayer；可在设置里手动切换
- **去广告**：自动剔除 HLS 片源中插播的广告片段（adjump、异域名短片段、AES 片源里的明文短片段等），默认开启，可在设置里关闭
- **播放器**：自绘控制层、竖屏默认 / 旋转或手动横屏、亮度音量手势、倍速、画质 / 线路切换、选集、弹幕、跳过片头、
  预缓冲、本地 HLS 代理、CENC 解密、Telegram 视频边下边播（TDLib Range 流式）
- **滑动切集**：横竖屏均可在画面中间 60% 区域上滑下一集、下滑上一集；左侧 20% 调亮度、右侧 20% 调音量，
  最左侧保留返回手势。锁屏、拖动进度、长按倍速、画中画或打开播放器面板时暂停滑动切集。
- **Cloudflare 验证**：隐藏 WebView 自动过验证（每个插件独立）

## 截图

> 模拟器截图，内容均为红果公开短剧及演示插件。

| 首页 | 频道切换 | 搜索 | 详情 |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/01-home.jpg" width="200"> | <img src="docs/screenshots/02-channels.jpg" width="200"> | <img src="docs/screenshots/03-search.jpg" width="200"> | <img src="docs/screenshots/04-detail.jpg" width="200"> |
| **竖屏播放** | **选集** | **弹幕** | **插件管理** |
| <img src="docs/screenshots/05-player.jpg" width="200"> | <img src="docs/screenshots/06-episodes.jpg" width="200"> | <img src="docs/screenshots/07-danmaku.jpg" width="200"> | <img src="docs/screenshots/08-plugins.jpg" width="200"> |
| **插件详情与权限** | | | |
| <img src="docs/screenshots/09-plugin-detail.jpg" width="200"> | | | |

**横屏播放**

<img src="docs/screenshots/10-landscape.jpg" width="820">

**AetherEngine 播放内核（1.5 build 2）**

| 音轨 | 画质 / 播放源 | 倍速（最高 2×） | 去广告 / 播放内核设置 | 开源许可 |
|:---:|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/11-audio-tracks.jpg" width="160"> | <img src="docs/screenshots/12-quality-source.jpg" width="160"> | <img src="docs/screenshots/13-speed.jpg" width="160"> | <img src="docs/screenshots/14-settings-adstrip-engine.jpg" width="160"> | <img src="docs/screenshots/15-licenses.jpg" width="160"> |

## 编译

要求：macOS 26.6 或更新、**Xcode 27.1**（含 iOS 27.1 SDK）、[XcodeGen](https://github.com/yonaskolb/XcodeGen)。最低部署目标仍是 **iOS 18.0**，不要改成 27.1。打包前 `scripts/require-ios-sdk.sh` 会检查 `xcodebuild -version` 是否为 Xcode 27.1，以及 `iphoneos27.1` / `iphonesimulator27.1` 是否都是 27.1；缺 SDK 就失败，不会改用别的 SDK。GitHub Actions 的打包、播放器验证和小说界面验证使用官方 `xcode-27` runner（镜像说明里的默认 Xcode 是 27.1）。`macos-26` 镜像最高只到 iOS 26.5 SDK，不能用来做这次构建。不需要签名证书。

```bash
sudo xcode-select -s /Applications/Xcode_27.1.app
brew install xcodegen
git clone https://github.com/my-name-is-alan/iDuanJu.git && cd iDuanJu
scripts/require-ios-sdk.sh
xcodegen generate          # 生成 STV.xcodeproj（工程文件不入库）
open STV.xcodeproj         # 或命令行：
xcodebuild -project STV.xcodeproj -scheme STV -sdk iphonesimulator27.1 \
  -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO build
```

依赖会由 Swift Package Manager 自动拉取：TDLibKit（含预编译 TDLib，首次拉取较大）、AetherEngine 7.62.0（含预编译 FFmpeg 等框架）；
QuickJS-ng 已 vendored 在 `Packages/QuickJS`。

## 播放内核（AetherEngine）

- 默认使用 **AetherEngine 7.62.0**（LGPL-3.0，附 App Store / DRM 例外条款），以 SwiftPM 静态链接、未修改。
- 它带的 **FFmpeg（LGPL-2.1，未启用 GPL / version3 组件）** 及 libzvbi、dav1d、zimg 以**动态框架**形式放在
  `STV.app/Frameworks/AetherLib*.framework`，没有并入主程序，可以替换 / 重新链接。各组件许可全文见
  `STV/Resources/Licenses/` 和 App 内「开源许可」，详见 [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md)。
- AetherEngine 目前**最高只支持 2× 倍速**，倍速列表和长按加速都封顶 2×。
- CENC 加密片源、FairPlay 或 AetherEngine 加载失败时会**自动回退系统播放器（AVPlayer）**；
  也可以在「我的 → 片源管理 → 播放设置 → 播放内核」手动选择「AetherEngine / 系统播放器」。
- **去广告**：同一页的「去广告」开关（默认开启）会在本地 HLS 代理里剔除插播广告片段；不会整段丢弃正片的分段标记。
  如遇个别片源误删或卡顿，可以关掉试试。

### 打包未签名 IPA（侧载）

```bash
scripts/package.sh            # 输出到 ./dist/STV-<版本>-unsigned.ipa
```

未签名 IPA 用 AltStore / Sideloadly / TrollStore 等工具用你自己的 Apple ID 重签后安装。

## Android 版

位于 [`android/`](android/)：原生 **Kotlin + Jetpack Compose + Media3（ExoPlayer）**，插件运行时为 QuickJS，
目标与 iOS 功能对齐。**minSdk 26（Android 8.0）/ targetSdk 35**。当前版本 **1.5.10**（预发布）。

```bash
# 要求 JDK 21 + Android SDK（platform 35）
cd android
./gradlew assembleRelease   # 输出 app/build/outputs/apk/release/app-release.apk
./gradlew :core:test        # 离线单元测试
```

Releases 中的 APK 使用固定分发签名（未上架任何商店），首次安装需允许“安装未知来源应用”。
本地未配置签名变量时仍使用调试证书；不能保证覆盖安装 Release 包。

已对齐 iOS：

- 红果：榜单 / 详情（题材、演员、关联季）/ 取流 / CENC 解密 / 播放；弹幕；选集面板（季、区间、更新至）
- 播放器：手势、倍速、画质、技术标签、季标、按设备解码能力选流；HLS 去广告（默认开启，可关）
- 苹果 CMS v10 采集站；idj1 JS 插件（视频 + 漫画、`idjimg://` 图片、域名白名单、订阅列表、内置推荐插件）
- Telegram 公开频道（t.me 网页预览）+ 屏蔽规则（关键词 / 正则 / 域名、广告识别、隐藏或折叠）
- 黄果、漫画（MangaDex、包子、插件）；首页频道栏与「频道」面板、多源搜索、继续观看 / 收藏 / 历史
- 「我的」：成人片源开关（18+ 确认，默认关闭）、去广告、重置设备 / 会话、清缓存
- 剧星榜：排名、头像、热度、代表作与分页，点击演员进入名字搜索
- 小说：首页 / 我的 → 小说；文件或粘贴 JSON / URL 导入书源；CSS/Jsoup、JSONPath、部分 XPath / JS 规则；分组榜单、TXT 阅读、章节预取、下载缓存、同书换源与续读（兼容结果见验收记录）
- 播放设置：下一集预加载开关、播放缓存上限

仍有差异：小说规则尚未覆盖 Legado 的全部 Java / WebView 能力；Android 尚无 EPUB 文件导入、朗读、演员主页与性别筛选、内置长视频站适配、TDLib 登录与下载管理、漫画离线下载、插件执行超时中断与签名校验、Cloudflare 验证、CENC 边下边解、Face ID 片源锁。小说推荐来自用户导入的书源，不内置推书君、优书网等第三方服务。

### Actions 与发布

在 GitHub **Actions → package → Run workflow** 运行双端构建。Android 先运行 `:core:test`，再生成 APK；iOS 默认生成未签名 IPA。勾选 `verify_simulator` 会额外生成本机架构的模拟器 app zip，并运行小说、CMS、CENC 定向测试（TDLib 编译较慢）。构建失败时查看 `ios-build-logs` 和 `android-test-reports` artifacts。

双端发布可运行 **Actions → publish existing packages**，传入已合入 `main` 的成功 package run ID、发布后缀和说明文件。发布任务检查来源、APK 签名及版本、IPA 完整性、包名、平台和版本后上传，并生成 `SHA256SUMS.txt`；默认不覆盖已有 Release。

Android 固定签名使用仓库 Secrets `ANDROID_KEYSTORE_BASE64`、`ANDROID_KEYSTORE_PASSWORD`，别名 `iduanju`；私钥不在仓库中。维护者应保留离线备份，避免更换签名导致覆盖安装失效。

离线测试：`cd android && ./gradlew :core:test`。联网测试需显式 `-Plive=1`；离线通过不代表所有上游站点始终可用。

**红果取流**：两端使用独立匿名注册身份和当前播放器 Medusa 签名，健康身份会复用；单集空包时先用同一身份尝试两个批量端点，全部空包才更换身份，最多 3 次并带冷却。筛选接口独立使用 551 签名。仓库不附带设备 ID 或 SDK token；也可以在“我的”填入自己的设备覆盖。上方新版已包含这些修复。

## Telegram（TDLib）登录

公开频道走 t.me 网页预览，不需要登录。私有 / 受限频道、频道内搜索需要 TDLib 登录：

1. 到 <https://my.telegram.org> → API development tools 申请你自己的 `api_id` / `api_hash`
2. App 内「我的 → 片源管理 → Telegram 登录」填入，再用手机号 + 验证码登录

本仓库**不内置任何 api_id / api_hash**，凭据只保存在你设备的钥匙串里。

## 红果设备

红果使用每台设备本地生成的匿名设备，仓库内不附带任何设备 ID。如果上游拒绝新生成的设备，可以在
UserDefaults 键 `stv.hg.purePlayerDevice` 写入你自己的 `"<device_id>,<iid>"`。

## 成人内容

成人站点 / 频道 / 漫画插件**默认全部关闭**，需要在「我的 → 片源管理」中手动开启（可选开启 Face ID 锁，冷启动后重新隐藏）。仅限已满 18 周岁且所在地法律允许的用户使用。

## 免责声明

- 本项目仅供个人学习、研究 iOS / Swift / 网络协议使用，**不提供、不存储、不分发**任何视频、图片或漫画内容。
- 所有内容版权归原站点和权利人所有。使用时请遵守各站点的服务条款及你所在地的法律法规，由此产生的一切后果由使用者自行承担。
- 项目中对第三方接口的适配仅用于互通性研究，与相关平台无任何关联。如有权利人认为侵权，请提 issue 联系处理。

## 许可证

[GPL-3.0](LICENSE)。第三方组件及其许可见 [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md)。

**禁止付费分发**：本项目是免费软件，作者不授权任何人以收费方式出售、分发本 App 或其代码。任何衍生作品都必须以 GPL-3.0 公开源代码。

---

## English

**iDuanJu** is a native SwiftUI iOS aggregator/player for short dramas, videos, manga and Telegram channels, with a
sandboxed QuickJS plugin system (per-plugin domain allow-list, isolated cookies/storage, no `eval`). It hosts no content.

- Build: Xcode 27.1 and the iOS 27.1 SDK (`scripts/require-ios-sdk.sh`), deployment target iOS 18.0. `xcodegen generate`, then build the `STV` scheme. GitHub Actions uses the `xcode-27` runner.
- Player core: AetherEngine 7.62.0 (LGPL-3.0 with App Store exception, unmodified) with FFmpeg (LGPL-2.1) shipped as replaceable
  dynamic frameworks; automatic AVPlayer fallback; speed capped at 2× by the engine; optional HLS ad-strip (on by default). Sideload the unsigned IPA from `scripts/package.sh`.
- **Android** (`android/`): native Kotlin + Jetpack Compose + Media3, minSdk 26 / targetSdk 35. Build with JDK 21:
  `cd android && ./gradlew assembleRelease`. Download the distribution-signed [Android 1.5.10 APK](https://github.com/my-name-is-alan/iDuanJu/releases/tag/v1.5.10-novel-android)
  or the [iOS 1.5 build 10 unsigned IPA](https://github.com/my-name-is-alan/iDuanJu/releases/tag/v1.5b10-novel). Not yet ported: TDLib login/downloads, manga offline
  download, plugin timeout/signature checks, CF verification, streaming CENC and Face ID lock.
- **Android 1.5.10 / iOS 1.5 build 10**: unified novel themes, Fanqie compatibility, and real-source tests of rankings, search, chapter lists, the first three chapters and offline caches for Fanqie and Shuqi samples. Android still lacks full Legado Java/WebView compatibility, EPUB import and speech.
- **Signing**: Android releases from 1.5.8 use a persistent distribution key. Older debug-signed builds may require uninstalling first (which clears local data); back up your source configuration before migrating.
- Telegram login uses **your own** `api_id` / `api_hash` from my.telegram.org; none are bundled.
- Adult (18+) sources are off by default and require explicit unlock.
- For personal study only; respect each site's Terms of Service and your local laws.
- **License: GPL-3.0.** This project is free. **Selling or paid distribution is prohibited**; any derivative work must stay open source under GPL-3.0.
