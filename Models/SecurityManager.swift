import SwiftUI

class SecurityManager: ObservableObject {
    @Published var isUnlocked = false
    @Published var accessMethod: AccessType = .none

    enum AccessType {
        case none, computer, pairingFile, hub
    }

    func lockApp() {
        isUnlocked = false
        accessMethod = .none
    }
}
