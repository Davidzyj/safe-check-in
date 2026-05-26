import SwiftUI

@main
struct SafeCheckInApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    if AppEnvironment.isScreenshotMode {
                        appState.loadSampleDataIfNeeded()
                    }
                }
        }
    }
}
