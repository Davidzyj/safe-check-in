import MessageUI
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.openURL) private var openURL

    @State private var selectedTab = ScreenshotConfig.initialTab
    @State private var activeDraft: MailDraft?
    @State private var showMailUnavailable = false
    @State private var fallbackDraft: MailDraft?

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView(
                    selectedTab: $selectedTab,
                    onCheckIn: prepareCheckInEmail
                )
            }
            .tabItem {
                Label(L10n.tabHome, systemImage: "house.fill")
            }
            .tag(0)

            NavigationStack {
                HistoryView()
            }
            .tabItem {
                Label(L10n.tabHistory, systemImage: "clock.fill")
            }
            .tag(1)

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label(L10n.tabSettings, systemImage: "gearshape.fill")
            }
            .tag(2)
        }
        .tint(.brandGreen)
        .sheet(item: $activeDraft) { draft in
            MailComposer(draft: draft) { result in
                if result == .sent {
                    appState.recordPreparedEmail()
                }
                activeDraft = nil
            }
        }
        .alert(L10n.mailUnavailableTitle, isPresented: $showMailUnavailable, presenting: fallbackDraft) { draft in
            Button(L10n.openMailLink) {
                if let url = draft.mailtoURL {
                    openURL(url)
                    appState.recordPreparedEmail()
                }
            }
            Button(L10n.cancel, role: .cancel) {}
        } message: { _ in
            Text(L10n.mailUnavailableMessage)
        }
        .onAppear {
            guard !AppEnvironment.isScreenshotMode else { return }
            NotificationManager.shared.updateSchedule(for: appState.settings)
        }
    }

    private func prepareCheckInEmail() {
        guard appState.hasFamilyEmail else {
            selectedTab = 2
            return
        }

        let draft = MailDraft(
            recipient: appState.settings.familyEmail.trimmingCharacters(in: .whitespacesAndNewlines),
            subject: L10n.emailSubject,
            body: L10n.emailBody(
                name: appState.settings.seniorName,
                message: appState.settings.effectiveMessage,
                date: Date()
            )
        )

        if MFMailComposeViewController.canSendMail() {
            activeDraft = draft
        } else {
            fallbackDraft = draft
            showMailUnavailable = true
        }
    }
}

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    @Binding var selectedTab: Int
    let onCheckIn: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.backgroundTop, .backgroundBottom],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    checkInCard
                    latestCard
                }
                .padding(22)
            }
        }
        .navigationTitle(L10n.appName)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(L10n.homeGreeting)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(Color.ink)
                .fixedSize(horizontal: false, vertical: true)

            Text(L10n.homeSubtitle)
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundStyle(Color.secondaryInk)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 8)
    }

    private var checkInCard: some View {
        VStack(spacing: 18) {
            Button {
                onCheckIn()
            } label: {
                VStack(spacing: 18) {
                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 74, weight: .bold))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.white, Color.brandGreen)

                    Text(appState.hasFamilyEmail ? L10n.checkInButton : L10n.setupNeeded)
                        .font(.system(size: 31, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .minimumScaleFactor(0.78)
                        .lineLimit(3)
                }
                .frame(maxWidth: .infinity)
                .minHeight(245)
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.brandGreen)
                        .shadow(color: Color.brandGreen.opacity(0.28), radius: 18, x: 0, y: 12)
                )
            }
            .buttonStyle(.plain)
            .accessibilityLabel(appState.hasFamilyEmail ? L10n.checkInButton : L10n.setupNeeded)

            if !appState.hasFamilyEmail {
                VStack(spacing: 14) {
                    Text(L10n.setupNeededMessage)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(Color.secondaryInk)
                        .multilineTextAlignment(.center)

                    Button {
                        selectedTab = 2
                    } label: {
                        Label(L10n.openSettings, systemImage: "gearshape.fill")
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(Color.warmGold)
                }
                .padding(18)
                .background(Color.white.opacity(0.82), in: RoundedRectangle(cornerRadius: 8))
            }
        }
    }

    private var latestCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(L10n.lastCheckIn, systemImage: "checkmark.seal.fill")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(Color.brandGreen)

            if let latestRecord = appState.latestRecord {
                Text(DateFormatter.localizedMedium.string(from: latestRecord.date))
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.ink)
                Text(appState.checkedInToday ? L10n.todaySent : L10n.preparedStatus)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.secondaryInk)
            } else {
                Text(L10n.noCheckInYet)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.ink)
                Text(L10n.notSentNote)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.secondaryInk)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color.white.opacity(0.88), in: RoundedRectangle(cornerRadius: 8))
    }
}

struct HistoryView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            Color.backgroundBottom.ignoresSafeArea()

            if appState.records.isEmpty {
                ContentUnavailableView {
                    Label(L10n.historyTitle, systemImage: "clock.badge.checkmark")
                } description: {
                    Text(L10n.historyEmpty)
                }
                .padding()
            } else {
                List(appState.records) { record in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(DateFormatter.localizedMedium.string(from: record.date))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        Text(record.recipient)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle(L10n.historyTitle)
    }
}

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.openURL) private var openURL

    var body: some View {
        Form {
            Section {
                TextField(L10n.seniorName, text: $appState.settings.seniorName)
                    .textContentType(.name)
                    .font(.system(size: 18, weight: .medium))

                TextField(L10n.familyEmail, text: $appState.settings.familyEmail)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .font(.system(size: 18, weight: .medium))

                TextField(L10n.defaultMessage, text: $appState.settings.customMessage, axis: .vertical)
                    .lineLimit(3...5)
                    .font(.system(size: 18, weight: .medium))
            } header: {
                Text(L10n.settingsTitle)
            }

            Section {
                Toggle(isOn: $appState.settings.reminderEnabled) {
                    Label(L10n.reminderEnabled, systemImage: "bell.fill")
                }

                DatePicker(
                    L10n.reminderTime,
                    selection: Binding(
                        get: { appState.settings.reminderDate },
                        set: { appState.settings.reminderDate = $0 }
                    ),
                    displayedComponents: .hourAndMinute
                )
                .disabled(!appState.settings.reminderEnabled)

                Text(L10n.reminderPermission)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Section {
                Button {
                    openURL(AppConstants.privacyURL)
                } label: {
                    Label(L10n.privacyPolicy, systemImage: "hand.raised.fill")
                }

                Button {
                    openURL(AppConstants.supportURL)
                } label: {
                    Label(L10n.support, systemImage: "questionmark.circle.fill")
                }

                LabeledContent(L10n.supportEmail, value: AppConstants.supportEmail)
                LabeledContent(L10n.version, value: AppConstants.version)
            }
        }
        .navigationTitle(L10n.tabSettings)
    }
}

private extension Color {
    static let brandGreen = Color(red: 0.09, green: 0.55, blue: 0.50)
    static let warmGold = Color(red: 0.83, green: 0.55, blue: 0.16)
    static let ink = Color(red: 0.08, green: 0.14, blue: 0.16)
    static let secondaryInk = Color(red: 0.31, green: 0.40, blue: 0.42)
    static let backgroundTop = Color(red: 0.89, green: 0.97, blue: 0.94)
    static let backgroundBottom = Color(red: 0.98, green: 0.97, blue: 0.91)
}

private extension View {
    func minHeight(_ height: CGFloat) -> some View {
        frame(minHeight: height)
    }
}

private enum ScreenshotConfig {
    static var initialTab: Int {
        AppEnvironment.initialScreenshotTab
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
