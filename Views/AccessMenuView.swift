import SwiftUI

struct AccessMenuView: View {
    @EnvironmentObject var security: SecurityManager
    
    var body: some View {
        NavigationStack {
            List {
                // --- SECTION 1: HARDWARE ---
                Section(header: Text("Physical Activation")) {
                    NavigationLink(destination: ComputerActivationView()) {
                        Label {
                            VStack(alignment: .leading) {
                                Text("1. Computer (USB)")
                                    .font(.headline)
                                Text("Connect to Windows/Mac Activator")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        } icon: {
                            Image(systemName: "desktopcomputer")
                                .foregroundColor(.blue)
                        }
                    }
                }

                // --- SECTION 2: MOBILE/FILE ---
                Section(header: Text("Mobile Activation")) {
                    NavigationLink(destination: PairingFilePicker()) {
                        Label {
                            VStack(alignment: .leading) {
                                Text("2. Pairing File")
                                    .font(.headline)
                                Text("Use .mobiledevicepairing file")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        } icon: {
                            Image(systemName: "doc.badge.lock.fill")
                                .foregroundColor(.orange)
                        }
                    }
                }

                // --- SECTION 3: THE STORE ---
                Section(header: Text("Developer Hub")) {
                    NavigationLink(destination: MainTabView()) {
                        Label {
                            VStack(alignment: .leading) {
                                Text("3. DevHelper Hub")
                                    .font(.headline)
                                Text("Enter the App Store Ecosystem")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        } icon: {
                            Image(systemName: "terminal.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
                
                // --- FOOTER ---
                Section {
                    Button(role: .destructive) {
                        security.lock()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Lock System")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Access Portal")
            .listStyle(.insetGrouped)
        }
    }
}

// Simple placeholder for the Computer View since we are doing PC last
struct ComputerActivationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cable.connector")
                .font(.system(size: 50))
            Text("Waiting for USB Connection...")
                .font(.headline)
            Text("Launch the Activator app on your Windows 11 PC to continue.")
                .multilineTextAlignment(.center)
                .padding()
            ProgressView()
        }
        .navigationTitle("Computer Link")
    }
}
