import Foundation

struct UserSettings: Codable, Equatable {
    var seniorName: String
    var familyEmail: String
    var customMessage: String
    var reminderEnabled: Bool
    var reminderHour: Int
    var reminderMinute: Int

    static let empty = UserSettings(
        seniorName: "",
        familyEmail: "",
        customMessage: "",
        reminderEnabled: true,
        reminderHour: 9,
        reminderMinute: 0
    )

    var reminderDate: Date {
        get {
            Calendar.current.date(
                bySettingHour: reminderHour,
                minute: reminderMinute,
                second: 0,
                of: Date()
            ) ?? Date()
        }
        set {
            let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
            reminderHour = components.hour ?? 9
            reminderMinute = components.minute ?? 0
        }
    }

    var effectiveMessage: String {
        let trimmed = customMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? L10n.defaultMessage : trimmed
    }
}

struct CheckInRecord: Codable, Identifiable, Equatable {
    let id: UUID
    let date: Date
    let recipient: String

    init(id: UUID = UUID(), date: Date, recipient: String) {
        self.id = id
        self.date = date
        self.recipient = recipient
    }
}

