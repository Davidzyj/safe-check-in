import Foundation

enum AppEnvironment {
    static var isScreenshotMode: Bool {
        ProcessInfo.processInfo.environment["SAFE_CHECK_IN_SCREENSHOTS"] == "1"
    }

    static var initialScreenshotTab: Int {
        guard let value = ProcessInfo.processInfo.environment["SAFE_CHECK_IN_INITIAL_TAB"],
              let tab = Int(value) else {
            return 0
        }
        return min(max(tab, 0), 2)
    }
}

