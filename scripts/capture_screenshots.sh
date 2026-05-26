#!/usr/bin/env bash
set -euo pipefail

DEVICE_ID="${DEVICE_ID:-4EC49CBE-3194-47DF-BE68-3AF2334B1A9E}"
BUNDLE_ID="com.davidzyj.safecheckin"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
APP_PATH="$HOME/Library/Developer/Xcode/DerivedData/SafeCheckIn-dwlfjbgkjmqlencjsrxmcxhyznxc/Build/Products/Debug-iphonesimulator/SafeCheckIn.app"

cd "$PROJECT_DIR"

xcodebuild -project SafeCheckIn.xcodeproj -scheme SafeCheckIn -destination "id=$DEVICE_ID" build > build-screenshots.log
xcrun simctl boot "$DEVICE_ID" >/dev/null 2>&1 || true
xcrun simctl ui "$DEVICE_ID" appearance light >/dev/null || true
xcrun simctl ui "$DEVICE_ID" content_size large >/dev/null || true
xcrun simctl terminate "$DEVICE_ID" "$BUNDLE_ID" >/dev/null 2>&1 || true
xcrun simctl openurl "$DEVICE_ID" "com.apple.springboard://" >/dev/null 2>&1 || true
xcrun simctl install "$DEVICE_ID" "$APP_PATH"

capture() {
  local lang="$1"
  local tab="$2"
  local name="$3"
  local dir="$PROJECT_DIR/AppStoreAssets/Screenshots/$lang"

  mkdir -p "$dir"
  xcrun simctl terminate "$DEVICE_ID" "$BUNDLE_ID" >/dev/null 2>&1 || true
  xcrun simctl openurl "$DEVICE_ID" "com.apple.springboard://" >/dev/null 2>&1 || true
  sleep 0.5
  SIMCTL_CHILD_SAFE_CHECK_IN_SCREENSHOTS=1 \
  SIMCTL_CHILD_SAFE_CHECK_IN_LANGUAGE="$lang" \
  SIMCTL_CHILD_SAFE_CHECK_IN_INITIAL_TAB="$tab" \
  xcrun simctl launch \
    --terminate-running-process \
    "$DEVICE_ID" "$BUNDLE_ID" >/dev/null
  sleep 4.5
  xcrun simctl io "$DEVICE_ID" screenshot "$dir/$name.png" >/dev/null
}

capture en 0 01-home
capture en 1 02-history
capture en 2 03-settings
capture zh-Hans 0 01-home
capture zh-Hans 1 02-history
capture zh-Hans 2 03-settings

for file in AppStoreAssets/Screenshots/en/*.png AppStoreAssets/Screenshots/zh-Hans/*.png; do
  printf "%s " "$file"
  sips -g pixelWidth -g pixelHeight "$file" 2>/dev/null | awk '/pixelWidth|pixelHeight/ { printf "%s ", $2 } END { print "" }'
done
