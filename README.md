# Safe Check-In / 安心报平安

Safe Check-In is an offline-first iPhone app for older adults to send a simple daily safety check-in email to their family.

## Product

- App version: `1.0.0`
- iPhone only
- No app-owned backend and no direct network requests in the core app
- Local-only profile, family email, reminder settings, and check-in history
- Email is sent through the iOS system mail composer
- Supports Simplified Chinese and English
- Support email: `jay212315@gmail.com`

## Important iOS Behavior

The in-app language follows the user's region:

- China region: Simplified Chinese
- Other regions: English

`CFBundleDisplayName` is localized through iOS bundle localization, which is controlled by device language rather than app runtime region. Both English and Simplified Chinese display names are configured.

## Web Pages

The privacy policy and support pages live under `docs/` and are ready for GitHub Pages:

- English privacy: `/privacy/`
- English support: `/support/`
- Chinese privacy: `/zh/privacy/`
- Chinese support: `/zh/support/`

Update the production base URL in `SafeCheckIn/Constants.swift` after the GitHub repository and GitHub Pages URL are finalized.

## Development

Open `SafeCheckIn.xcodeproj` in Xcode 26 or newer, or build from the command line:

```sh
xcodebuild -project SafeCheckIn.xcodeproj -scheme SafeCheckIn -destination 'platform=iOS Simulator,name=iPhone 17,OS=26.2' build
```

Generate App Store screenshots from the real iOS Simulator:

```sh
./scripts/capture_screenshots.sh
```

## Documentation

Project status and handoff notes are tracked in:

- `docs/progress/PROJECT_PROGRESS.md`
- `docs/PRODUCT_SPEC.md`
- `docs/APP_STORE_NOTES.md`
