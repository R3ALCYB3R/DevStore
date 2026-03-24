import SwiftUI

@main
struct DevHelperApp: App {
    @StateObject private var security = SecurityManager()

    var body: some Scene {
        WindowGroup {
            if security.isUnlocked {
                AccessMenuView()
                    .environmentObject(security)
            } else {
                StartButtonView()
                    .environmentObject(security)
            }
        }
    }
}
