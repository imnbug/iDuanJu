#!/usr/bin/env python3
"""Pick an available iPhone simulator whose runtime is exactly iOS 27.1.

Reads `simctl list devices available -j` on stdin, or runs that command when
stdin is a terminal. `--self-test` checks the matcher without Xcode.
"""
import json
import subprocess
import sys

WANT = (27, 1)


def runtime_version(name):
    if "iOS-" not in name:
        return None
    parts = []
    for piece in name.split("iOS-", 1)[1].split("-"):
        if piece.isdigit():
            parts.append(int(piece))
        else:
            break
    return tuple(parts) or None


def pick(devices, want=WANT):
    found = []
    for runtime, devs in devices.items():
        if runtime_version(runtime) != want:
            continue
        for dev in devs:
            if dev.get("isAvailable", True) and str(dev.get("name", "")).startswith("iPhone"):
                found.append(dev)
    if not found:
        version = ".".join(str(part) for part in want)
        raise SystemExit(
            "error: 没有可用的 iOS %s iPhone 模拟器。"
            "请使用 Xcode 27.1 自带的 iphonesimulator27.1，不要用 27.0 或 27.2 代替。" % version
        )
    found.sort(key=lambda dev: dev.get("name", ""))
    return found[0]["udid"]


def self_test():
    devices = {
        "com.apple.CoreSimulator.SimRuntime.iOS-27-2": [
            {"name": "iPhone 18 Pro", "udid": "too-new", "isAvailable": True}
        ],
        "com.apple.CoreSimulator.SimRuntime.iOS-27-1": [
            {"name": "iPhone 17", "udid": "iphone-17", "isAvailable": True},
            {"name": "iPad Pro", "udid": "ipad", "isAvailable": True},
            {"name": "iPhone Duo", "udid": "duo-off", "isAvailable": False},
        ],
        "com.apple.CoreSimulator.SimRuntime.iOS-26-5": [
            {"name": "iPhone 17", "udid": "old", "isAvailable": True}
        ],
    }
    assert pick(devices) == "iphone-17"
    try:
        pick({"com.apple.CoreSimulator.SimRuntime.iOS-27-2": devices[
            "com.apple.CoreSimulator.SimRuntime.iOS-27-2"]})
    except SystemExit as error:
        assert "27.1" in str(error)
    else:
        raise SystemExit("error: 27.2 simulator was accepted")
    print("select-ios-simulator self-test passed")


def main():
    if "--self-test" in sys.argv:
        self_test()
        return
    if sys.stdin.isatty():
        raw = subprocess.check_output(["xcrun", "simctl", "list", "devices", "available", "-j"])
        data = json.loads(raw)
    else:
        data = json.load(sys.stdin)
    print(pick(data.get("devices", data)))


if __name__ == "__main__":
    main()
