import Foundation
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var settings: UserSettings {
        didSet {
            saveSettings()
            if !AppEnvironment.isScreenshotMode {
                NotificationManager.shared.updateSchedule(for: settings)
            }
        }
    }

    @Published private(set) var records: [CheckInRecord]

    private let settingsKey = "safeCheckIn.settings"
    private let recordsKey = "safeCheckIn.records"
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.settings = Self.loadSettings(defaults: defaults, key: settingsKey)
        self.records = Self.loadRecords(defaults: defaults, key: recordsKey)
    }

    var hasFamilyEmail: Bool {
        !settings.familyEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var latestRecord: CheckInRecord? {
        records.first
    }

    var checkedInToday: Bool {
        guard let latestRecord else { return false }
        return Calendar.current.isDateInToday(latestRecord.date)
    }

    func recordPreparedEmail() {
        let record = CheckInRecord(date: Date(), recipient: settings.familyEmail)
        records.insert(record, at: 0)
        if records.count > 60 {
            records = Array(records.prefix(60))
        }
        saveRecords()
    }

    func loadSampleDataIfNeeded() {
        if !AppEnvironment.isScreenshotMode {
            guard settings.seniorName.isEmpty, settings.familyEmail.isEmpty, records.isEmpty else { return }
        }
        settings.seniorName = L10n.sampleName
        settings.familyEmail = L10n.sampleEmail
        settings.customMessage = L10n.defaultMessage
        settings.reminderEnabled = false
        records = [
            CheckInRecord(date: Date().addingTimeInterval(-86_400), recipient: settings.familyEmail),
            CheckInRecord(date: Date().addingTimeInterval(-172_800), recipient: settings.familyEmail)
        ]
        saveRecords()
    }

    private func saveSettings() {
        guard let data = try? JSONEncoder().encode(settings) else { return }
        defaults.set(data, forKey: settingsKey)
    }

    private func saveRecords() {
        guard let data = try? JSONEncoder().encode(records) else { return }
        defaults.set(data, forKey: recordsKey)
    }

    private static func loadSettings(defaults: UserDefaults, key: String) -> UserSettings {
        guard let data = defaults.data(forKey: key),
              let settings = try? JSONDecoder().decode(UserSettings.self, from: data) else {
            return .empty
        }
        return settings
    }

    private static func loadRecords(defaults: UserDefaults, key: String) -> [CheckInRecord] {
        guard let data = defaults.data(forKey: key),
              let records = try? JSONDecoder().decode([CheckInRecord].self, from: data) else {
            return []
        }
        return records.sorted { $0.date > $1.date }
    }
}
