import Foundation

enum AppLanguage {
    case chinese
    case english

    static var current: AppLanguage {
        if let override = ProcessInfo.processInfo.environment["SAFE_CHECK_IN_LANGUAGE"] {
            return override.lowercased().hasPrefix("zh") ? .chinese : .english
        }
        return Locale.current.region?.identifier.uppercased() == "CN" ? AppLanguage.chinese : AppLanguage.english
    }

    var locale: Locale {
        switch self {
        case .chinese:
            return Locale(identifier: "zh_Hans_CN")
        case .english:
            return Locale(identifier: "en_US")
        }
    }
}

enum L10n {
    static var language: AppLanguage { AppLanguage.current }

    static var appName: String { text("安心报平安", "Safe Check-In") }
    static var tabHome: String { text("首页", "Home") }
    static var tabHistory: String { text("记录", "History") }
    static var tabSettings: String { text("设置", "Settings") }
    static var homeGreeting: String { text("今天也报个平安", "Check in for today") }
    static var homeSubtitle: String { text("轻点按钮，给家人发送一封已经写好的邮件。", "Tap once to prepare a safety email for your family.") }
    static var checkInButton: String { text("我很好\n发送报平安邮件", "I am safe\nSend check-in email") }
    static var lastCheckIn: String { text("最近一次报平安", "Last check-in") }
    static var noCheckInYet: String { text("还没有报平安记录", "No check-ins yet") }
    static var todaySent: String { text("今天已准备邮件", "Email prepared today") }
    static var setupNeeded: String { text("先填写家人邮箱", "Add a family email first") }
    static var setupNeededMessage: String { text("在设置里填写家人邮箱后，就可以一键准备报平安邮件。", "Add a family email in Settings before preparing a check-in email.") }
    static var openSettings: String { text("去设置", "Open Settings") }
    static var mailUnavailableTitle: String { text("无法打开邮件", "Mail unavailable") }
    static var mailUnavailableMessage: String { text("请先在 iPhone 上设置邮件账户，或使用下方备用邮件链接。", "Please set up a Mail account on this iPhone, or use the fallback email link below.") }
    static var openMailLink: String { text("打开备用邮件链接", "Open fallback mail link") }
    static var cancel: String { text("取消", "Cancel") }
    static var done: String { text("完成", "Done") }
    static var historyTitle: String { text("报平安记录", "Check-in History") }
    static var historyEmpty: String { text("发送第一封报平安邮件后，这里会显示记录。", "After the first check-in email is prepared, records will appear here.") }
    static var settingsTitle: String { text("家人和提醒", "Family & Reminder") }
    static var seniorName: String { text("长辈姓名", "Your name") }
    static var familyEmail: String { text("家人邮箱", "Family email") }
    static var customMessage: String { text("附加留言", "Optional message") }
    static var reminderEnabled: String { text("每日提醒", "Daily reminder") }
    static var reminderTime: String { text("提醒时间", "Reminder time") }
    static var reminderPermission: String { text("允许通知后，App 会每天提醒你报平安。", "Allow notifications so the app can remind you to check in each day.") }
    static var privacyPolicy: String { text("隐私政策", "Privacy Policy") }
    static var support: String { text("支持", "Support") }
    static var supportEmail: String { text("联系邮箱", "Support email") }
    static var version: String { text("版本", "Version") }
    static var defaultMessage: String { text("我今天一切都好，请放心。", "I am doing well today. Please don't worry.") }
    static var emailSubject: String { text("今天我很好", "I am safe today") }
    static var reminderTitle: String { text("该报平安了", "Time to check in") }
    static var reminderBody: String { text("给家人发一封报平安邮件。", "Send a quick safety email to your family.") }
    static var preparedStatus: String { text("邮件已经准备好", "Email prepared") }
    static var notSentNote: String { text("请在系统邮件界面点发送。", "Tap Send in the system Mail screen.") }
    static var sampleName: String { text("王阿姨", "Mary") }
    static var sampleEmail: String { text("family@example.com", "family@example.com") }
    static var appStoreHomeTitle: String { text("一键报平安", "One-tap safety") }
    static var appStoreHomeSubtitle: String { text("不用注册，不用学习复杂操作。", "No account. No complicated steps.") }

    static func emailBody(name: String, message: String, date: Date) -> String {
        let dateText = DateFormatter.localizedMedium.string(from: date)
        if language == .chinese {
            let displayName = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "我" : name
            return """
            家人好，

            \(displayName)今天已经报平安。

            \(message)

            时间：\(dateText)

            这封邮件由安心报平安 App 生成，并由我通过 iPhone 系统邮件发送。
            """
        }

        let displayName = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "I" : name
        return """
        Hi family,

        \(displayName) checked in today.

        \(message)

        Time: \(dateText)

        This email was prepared by Safe Check-In and sent by me through the iPhone Mail app.
        """
    }

    static func text(_ chinese: String, _ english: String) -> String {
        language == .chinese ? chinese : english
    }
}

extension DateFormatter {
    static let localizedMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = AppLanguage.current.locale
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = AppLanguage.current.locale
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
}
