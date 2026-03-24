import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var security: SecurityManager
    @State private var selectedIcon = "Classic"
    
    let icons = ["Classic", "Stealth", "Cyber"]
    
    var body: some View {
        NavigationStack {
            List {
                // --- SECTION: APPEARANCE ---
                Section(header: Text("App Customization")) {
                    Picker("App Icon", selection: $selectedIcon) {
                        ForEach(icons, id: \.self) { icon in
                            Text(icon).tag(icon)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: selectedIcon) { newValue in
                        changeAppIcon(to: newValue)
                    }
                    
                    HStack {
                        Text("Theme Color")
                        Spacer()
                        Circle()
                            .fill(themeColor)
                            .frame(width: 20, height: 20)
                    }
                }
                
                // --- SECTION: DEVELOPER INFO ---
                Section(header: Text("Source Info")) {
                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("R3ALCYB3R")
                            .foregroundColor(.secondary)
                    }
                    
                    Link(destination: URL(string: "https://github.com/R3ALCYB3R/DevStore")!) {
                        HStack {
                            Text("GitHub Repository")
                            Spacer()
                            Image(systemName: "safari")
                        }
                    }
                }
                
                // --- SECTION: SECURITY ---
                Section {
                    Button(role: .destructive) {
                        security.lock()
                    } label: {
                        Label("Lock DevHelper", systemImage: "lock.fill")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    // --- LOGIC: THEME COLOR ---
    var themeColor: Color {
        switch selectedIcon {
        case "Stealth": return .primary
        case "Cyber": return .green
        default: return .blue
        }
    }
    
    // --- LOGIC: ICON SWAP ---
    func changeAppIcon(to iconName: String) {
        let name = iconName == "Classic" ? nil : "AppIcon-\(iconName)"
        UIApplication.shared.setAlternateIconName(name) { error in
            if let error = error {
                print("Icon swap failed: \(error.localizedDescription)")
            }
        }
    }
}
