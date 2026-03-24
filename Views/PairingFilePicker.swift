import SwiftUI
import UniformTypeIdentifiers

// Custom type for .mobiledevicepairing files
extension UTType {
    static var pairingFile: UTType {
        UTType(filenameExtension: "mobiledevicepairing") ?? .data
    }
}

struct PairingFilePicker: View {
    @EnvironmentObject var security: SecurityManager
    @State private var showPicker = false
    @State private var statusMessage = "Waiting for file..."

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.badge.lock.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)

            Text("Option 2: Pairing File")
                .font(.title2).bold()

            Text(statusMessage)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button(action: { showPicker = true }) {
                Label("Select .mobiledevicepairing", systemImage: "folder.fill")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
        // --- THE FILE PICKER LOGIC ---
        .fileImporter(
            isPresented: $showPicker,
            allowedContentTypes: [.pairingFile],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                if let url = urls.first {
                    verifyPairing(url: url)
                }
            case .failure(let error):
                statusMessage = "Error: \(error.localizedDescription)"
            }
        }
    }

    // --- LOGIC: VERIFY THE FILE ---
    func verifyPairing(url: URL) {
        statusMessage = "Verifying handshake..."
        
        // Start accessing the security-scoped resource
        guard url.startAccessingSecurityScopedResource() else { return }
        defer { url.stopAccessingSecurityScopedResource() }

        do {
            let fileData = try Data(contentsOf: url)
            // We check if the file is valid (SideStore/AltStore format)
            if fileData.count > 100 { 
                statusMessage = "Handshake Successful!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    security.isUnlocked = true // Unlock the whole store!
                }
            } else {
                statusMessage = "Invalid Pairing File."
            }
        } catch {
            statusMessage = "Could not read file."
        }
    }
}
