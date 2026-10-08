# HarmonyMusic · 鸿蒙音乐应用

基于 HarmonyOS（ArkTS / ArkUI）开发的音乐播放应用，包含推荐、发现、音乐、动态、我的五个底部 Tab，支持歌曲在线播放与本地播放控制。

## 功能特性

- **底部五 Tab 导航**：推荐 / 发现 / Music / 动态 / 我的
- **音乐播放**：播放、暂停、上一首、下一首，支持顺序播放控制
- **迷你播放条**：首页底部常驻当前歌曲信息与播放控制，点击进入播放页
- **网络音频加载**：通过 Http2Buffer 加载音频数据流播放
- **本地存储**：基于 Preferences 保存用户偏好与状态
- **事件通信**：基于 emitter 实现跨页面歌曲数据同步
- **其他页面**：广告启动页、倒计时页、个人中心、我的消息、黑马音乐页等

## 页面一览

| 页面 | 说明 |
| --- | --- |
| Index | 首页（五 Tab + 底部迷你播放条） |
| recommendPage | 推荐 |
| findPage | 发现 |
| musicPage | 音乐 |
| momentPage | 动态 |
| minePage | 我的 |
| playPage | 播放页 |
| AdPage | 广告 / 启动页 |
| countdownPage | 倒计时页 |
| myInfoPage / myMessagePage | 个人中心 / 我的消息 |

## 技术栈

- 语言 / 框架：ArkTS（ArkUI）
- 音频播放：AVPlayer
- 数据通信：@ohos.events.emitter（事件订阅）
- 本地存储：Preferences
- 页面路由：@ohos.router
- 系统：HarmonyOS（支持 phone / tablet）

## 目录结构

```
HarmonyMusic/
├── AppScope/                     # 应用级配置（bundle、版本、图标）
├── entry/                        # 应用入口模块
│   ├── src/main/ets/
│   │   ├── constants/            # 常量定义
│   │   ├── entryability/         # Ability 入口
│   │   ├── models/               # 数据模型（音乐、播放状态等）
│   │   ├── pages/                # 页面（首页、播放页、Tab 页面等）
│   │   ├── services/             # 服务（AVPlayerManager 播放管理）
│   │   └── utils/                # 工具（音频缓冲、存储、订阅等）
│   ├── src/main/resources/       # 资源（图标、字符串、颜色等）
│   └── src/ohosTest/             # 单元测试
├── hvigor/                       # 构建配置
├── build-profile.json5           # 工程构建配置
└── hvigorfile.ts                 # hvigor 构建脚本
```

## 环境要求

- DevEco Studio（HarmonyOS 工程）
- HarmonyOS SDK（API 版本与工程 compatibleSdkVersion 一致）
- ohpm 包管理器

## 快速开始

1. 克隆仓库：

```bash
git clone https://github.com/neko661/HarmonyMusic.git
```

2. 使用 DevEco Studio 打开工程根目录，等待依赖同步。
3. 连接 HarmonyOS 模拟器或真机，点击 Run 运行应用。

## License

学习 / 毕业设计项目，开源协议待定。
