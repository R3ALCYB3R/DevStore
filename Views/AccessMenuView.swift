import SwiftUI
import UniformTypeIdentifiers

struct AccessMenuView: View {
    @EnvironmentObject var security: SecurityManager
    @State private var showFilePicker = false

    var body: some View {
        NavigationStack {
            List {
                Section("Select Access Method") {
                    // Choice 1: Computer
                    NavigationLink("💻 1. Computer") {
                        Text("Please connect to Windows/Mac Activator via USB...")
                    }

                    // Choice 2: Pairing File
                    Button("📄 2. Pairing File") {
                        showFilePicker = true
                    }

                    // Choice 3: DevHelper Hub
                    NavigationLink("🚀 3. DevHelper Hub") {
                        DevHelperHubView()
                    }
                }
            }
            .navigationTitle("DevStore Access")
            .fileImporter(
                isPresented: $showFilePicker,
                allowedContentTypes: [UTType(filenameExtension: "mobiledevicepairing")!],
                allowsMultipleSelection: false
            ) { result in
                // Logic to process the pairing file goes here
            }
            .toolbar {
                Button("Lock") { security.lockApp() }
            }
        }
    }
}
