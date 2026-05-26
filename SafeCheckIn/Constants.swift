import Foundation

enum AppConstants {
    static let supportEmail = "jay212315@gmail.com"
    static let version = "1.0.0"

    // Replace with the GitHub Pages production URL after publishing.
    static let webBaseURL = URL(string: "https://davidzyj.github.io/safe-check-in/")!

    static var privacyURL: URL {
        localizedURL(englishPath: "privacy/", chinesePath: "zh/privacy/")
    }

    static var supportURL: URL {
        localizedURL(englishPath: "support/", chinesePath: "zh/support/")
    }

    private static func localizedURL(englishPath: String, chinesePath: String) -> URL {
        URL(string: AppLanguage.current == .chinese ? chinesePath : englishPath, relativeTo: webBaseURL)!.absoluteURL
    }
}
