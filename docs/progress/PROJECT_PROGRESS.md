# Project Progress

## 2026-05-26

### Decisions

- Product chosen: elderly daily safety check-in app.
- App names:
  - English: `Safe Check-In`
  - Simplified Chinese: `安心报平安`
- Version fixed at `1.0.0`.
- Support email: `jay212315@gmail.com`.
- V1 remains local-first with no app-owned backend.
- Check-in email is delegated to iOS system mail.
- Missed check-in automatic family alerts are out of V1 because they require server-side delivery.

### Implementation Plan

- Create a native SwiftUI iPhone app.
- Persist settings and history locally.
- Use local notifications for daily reminders.
- Add privacy/support web pages under `docs/` for GitHub Pages.
- Configure English and Simplified Chinese localizations.
- Create App Store icon assets and 6.5-inch screenshots.

### Current Status

- Native SwiftUI app implemented.
- Local settings and check-in history implemented with `UserDefaults`.
- Daily reminder scheduling implemented with local notifications.
- Email flow implemented with iOS system mail composer and `mailto:` fallback.
- English and Simplified Chinese UI behavior implemented.
- `CFBundleDisplayName` localized for English and Simplified Chinese.
- GitHub Pages-ready privacy and support pages added under `docs/`.
- 1024 x 1024 App Store icon generated without alpha channel.
- 6.5-inch English and Simplified Chinese screenshots captured from the real iOS Simulator.
- Git repository initialized and pushed to `https://github.com/Davidzyj/safe-check-in`.
- GitHub Pages enabled from `main` branch `/docs`.
- Public web URL: `https://davidzyj.github.io/safe-check-in/`.

### Verification

- `xcodebuild -project SafeCheckIn.xcodeproj -scheme SafeCheckIn -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.2' build` succeeded.
- `scripts/capture_screenshots.sh` generated:
  - `AppStoreAssets/Screenshots/en/01-home.png`
  - `AppStoreAssets/Screenshots/en/02-history.png`
  - `AppStoreAssets/Screenshots/en/03-settings.png`
  - `AppStoreAssets/Screenshots/zh-Hans/01-home.png`
  - `AppStoreAssets/Screenshots/zh-Hans/02-history.png`
  - `AppStoreAssets/Screenshots/zh-Hans/03-settings.png`
- Screenshot dimensions verified: `1242 x 2688`.
- App Store icon verified: `1024 x 1024`, `hasAlpha: no`.

### Remaining Before App Store Submission

- Confirm Apple Developer Team ID and bundle identifier ownership.
- Archive and upload through Xcode after signing is configured.
- Confirm final App Store category, subtitle, keywords, and age rating.
- Wait for GitHub Pages build to finish if the public URL is not immediately live.
- Paste final privacy/support URLs into App Store Connect.
