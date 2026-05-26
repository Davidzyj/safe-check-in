# Product Spec: Safe Check-In / 安心报平安

## Goal

Create a simple, offline-first iPhone app that helps older adults send a daily safety check-in email to their children or family members.

## Target Users

- Older adults living alone
- Adult children who want a low-friction daily reassurance signal
- Families who prefer privacy-friendly tools without accounts or tracking

## Version

`1.0.0`

## Positioning

English:

> A private one-tap safety check-in app for families.

Simplified Chinese:

> 给长辈和家人的一键报平安工具。

## V1 Scope

Included:

- Local setup for senior name, family email, reminder time, and optional message
- One large check-in button
- System email composer with prefilled recipient, subject, and body
- Local check-in history
- Local daily reminder
- Settings screen
- Privacy and support page links
- English and Simplified Chinese UI
- iPhone-only app target

Not included:

- App-owned backend
- Direct email sending by the app
- Account login
- Cloud sync
- Automatic family alerts when a check-in is missed
- Push notifications
- HealthKit or medical claims

## Core Constraint

The app itself should not perform network requests. Email sending is delegated to iOS Mail through `MFMailComposeViewController`. If Mail is unavailable, the app opens a `mailto:` URL as a fallback.

## Missed Check-In Limitation

A pure local app cannot reliably email family members when the user misses a check-in. That feature requires a server, email service, or a family-side companion flow and is reserved for a possible V2.

## Language Behavior

In-app language selection:

- Region code `CN`: Simplified Chinese
- All other regions: English

Bundle display name:

- English: `Safe Check-In`
- Simplified Chinese: `安心报平安`

iOS localizes `CFBundleDisplayName` by language, not by runtime region. This is documented here to guide future agents.

## Support Contact

`jay212315@gmail.com`

