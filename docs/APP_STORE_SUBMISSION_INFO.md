# App Store Submission Info

This document collects the fields needed for submitting Safe Check-In / 安心报平安 to App Store Connect.

## Basic App Record

| Field | Value |
|---|---|
| Platform | iOS |
| Device support | iPhone only |
| Bundle ID | `com.davidzyj.safecheckin` |
| SKU | `safe-check-in-001` |
| Version | `1.0.0` |
| Build | `1` |
| Primary category | Lifestyle |
| Secondary category | Utilities |
| Pricing | Free, recommended for V1 |
| Age rating | 4+ recommended |
| Copyright | `© 2026 Davidzyj` |
| Support email | `jay212315@gmail.com` |

## URLs

| Field | Value |
|---|---|
| Privacy Policy URL | `https://davidzyj.github.io/safe-check-in/privacy/` |
| Support URL | `https://davidzyj.github.io/safe-check-in/support/` |
| Marketing URL | `https://davidzyj.github.io/safe-check-in/` |
| Chinese Privacy Policy URL | `https://davidzyj.github.io/safe-check-in/zh/privacy/` |
| Chinese Support URL | `https://davidzyj.github.io/safe-check-in/zh/support/` |

## English Metadata

### Name

`Safe Check-In`

### Subtitle

`One-tap safety email`

### Promotional Text

`A simple, private way to let family know you are safe.`

### Description

`Safe Check-In helps older adults send a daily safety email to family with one simple button.`

`Set a family email, choose a reminder time, and tap the large check-in button when you are ready. The app prepares an email in the iPhone system Mail screen, so you stay in control of what is sent.`

`Safe Check-In does not require an account, does not use its own server, and keeps settings and check-in history on your device.`

### Keywords

`check in,safety,family,senior,elderly,reminder,email,offline`

### What's New

`Initial release.`

## Simplified Chinese Metadata

### Name

`安心报平安`

### Subtitle

`一键给家人报平安`

### Promotional Text

`给长辈和家人的简单报平安工具。`

### Description

`安心报平安帮助长辈用一个大按钮给家人发送每日报平安邮件。`

`设置家人邮箱和提醒时间后，需要报平安时轻点按钮，App 会打开 iPhone 系统邮件界面并预填邮件内容，由用户自行确认发送。`

`安心报平安不需要注册账号，没有自有服务器，设置和报平安记录都保存在本机。`

### Keywords

`报平安,长辈,老人,家人,提醒,邮件,独居,离线`

### What's New

`首个版本。`

## Screenshots

Upload the 6.5-inch iPhone screenshots first.

| Language | Path |
|---|---|
| English | `AppStoreAssets/Screenshots/en/` |
| Simplified Chinese | `AppStoreAssets/Screenshots/zh-Hans/` |

Current screenshot files:

- `01-home.png`
- `02-history.png`
- `03-settings.png`

All current screenshots are `1242 x 2688`.

## App Icon

Use:

`AppStoreAssets/Icon/AppStoreIcon-1024.png`

Verified:

- `1024 x 1024`
- No alpha channel
- Not pure black

## App Privacy

Recommended App Store Connect privacy answer:

`Data Not Collected`

Reasoning:

- The app stores senior name, family email, reminder settings, custom message, and check-in history only on the user's device.
- The app does not run an app-owned backend.
- The app does not directly transmit data to developer-controlled servers.
- Check-in email is sent by the user through the iOS system Mail interface.
- The app does not track users.
- The app does not use third-party analytics or ads.

If App Store Connect asks about tracking:

`No, we do not use this app to track users.`

If App Store Connect asks whether data is collected:

`No, this app does not collect data from this app.`

## App Review Information

### Sign-in Required

`No`

### Contact Information

Use the Apple Developer account holder's real contact details.

Support email:

`jay212315@gmail.com`

### Review Notes

`Safe Check-In is an offline-first family safety check-in utility. The app does not create accounts and does not use an app-owned backend. When the user taps the check-in button, the app presents the iOS system mail composer with a prefilled family email, subject, and body. The user remains in control of sending the email. Settings and check-in history are stored locally on the device.`

## Avoid In App Store Copy

Do not claim:

- Automatic missed check-in alerts
- Automatic email sending without user confirmation
- Emergency rescue or medical monitoring
- Health diagnosis or medical safety guarantees

Use:

- One-tap safety email
- Family check-in
- Local-first
- Private
- No account required

## Final Pre-Submission Checklist

- Confirm Apple Developer Team in Xcode.
- Confirm `com.davidzyj.safecheckin` is available or update the bundle identifier.
- Archive the app in Xcode.
- Upload the build to App Store Connect.
- Add the English and Simplified Chinese metadata.
- Upload screenshots for each localization.
- Upload the 1024 app icon.
- Fill privacy as `Data Not Collected`.
- Add review notes.
- Submit for review.

