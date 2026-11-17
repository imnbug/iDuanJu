#!/bin/bash
# Require the iOS 27.1 SDK from Xcode 27.1. Does not download an SDK, sign, or install.
# Official runner (actions/runner-images main, fetched 2026-11-17):
#   label: xcode-27  (arm64; README still badges it preview)
#   image: macOS 27.0.1, Xcode 27.1 (default, build 27A9275), SDK iphoneos27.1
# macos-26 does not have this SDK. Its newest listed iOS SDK is iphoneos26.5 (Xcode 26.6).
set -euo pipefail

want_xcode="Xcode 27.1"
want_sdk="27.1"
device_sdk="iphoneos27.1"
sim_sdk="iphonesimulator27.1"

fail() {
  cat >&2 <<EOF
error: $1

需要本机已安装的 Xcode 27.1（Apple 发布说明：含 iOS ${want_sdk} SDK，系统要求 macOS 26.6 或更新）。
手动检查：
  sudo xcode-select -s /Applications/Xcode_27.1.app
  xcodebuild -version          # 第一行必须是 ${want_xcode}
  xcrun --sdk ${device_sdk} --show-sdk-version
  xcrun --sdk ${sim_sdk} --show-sdk-version
两行 SDK 版本都必须是 ${want_sdk}。

GitHub Actions 使用官方标签 runs-on: xcode-27，并用 maxim-lobanov/setup-xcode 选择 27.1。
不要改到 macos-26 / macos-15：那些镜像没有 iOS ${want_sdk} SDK，本脚本不会改用它们的 SDK 继续编译。
不要把 deployment target 抬到 ${want_sdk}。最低系统仍是 iOS 18.0。
不需要、也不要配置签名证书。打包继续使用 CODE_SIGNING_ALLOWED=NO。
EOF
  exit 1
}

if ! command -v xcodebuild >/dev/null 2>&1 || ! command -v xcrun >/dev/null 2>&1; then
  fail "当前环境没有 xcodebuild / xcrun，不能用 iOS ${want_sdk} SDK 编译。"
fi

echo "xcode-select: $(xcode-select -p)"
xcodebuild -version
xcode_line=$(xcodebuild -version | head -n 1)
[[ "$xcode_line" == "$want_xcode" ]] || fail "选中的工具链是「${xcode_line}」，不是 ${want_xcode}。"

device_ver=$(xcrun --sdk "$device_sdk" --show-sdk-version 2>/dev/null || true)
sim_ver=$(xcrun --sdk "$sim_sdk" --show-sdk-version 2>/dev/null || true)
device_path=$(xcrun --sdk "$device_sdk" --show-sdk-path 2>/dev/null || true)
sim_path=$(xcrun --sdk "$sim_sdk" --show-sdk-path 2>/dev/null || true)
echo "device sdk: ${device_ver:-missing} ${device_path:-}"
echo "simulator sdk: ${sim_ver:-missing} ${sim_path:-}"
[[ "$device_ver" == "$want_sdk" && -n "$device_path" ]] || fail "找不到 ${device_sdk}，或版本不是 ${want_sdk}（实际：${device_ver:-无}）。"
[[ "$sim_ver" == "$want_sdk" && -n "$sim_path" ]] || fail "找不到 ${sim_sdk}，或版本不是 ${want_sdk}（实际：${sim_ver:-无}）。"
echo "iOS ${want_sdk} SDK check passed"
