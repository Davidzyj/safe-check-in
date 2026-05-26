import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()

    private let reminderIdentifier = "safeCheckIn.dailyReminder"

    private init() {}

    func updateSchedule(for settings: UserSettings) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminderIdentifier])
        guard settings.reminderEnabled else { return }

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            guard granted else { return }

            var dateComponents = DateComponents()
            dateComponents.hour = settings.reminderHour
            dateComponents.minute = settings.reminderMinute

            let content = UNMutableNotificationContent()
            content.title = L10n.reminderTitle
            content.body = L10n.reminderBody
            content.sound = .default

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(
                identifier: self.reminderIdentifier,
                content: content,
                trigger: trigger
            )

            UNUserNotificationCenter.current().add(request)
        }
    }
}

