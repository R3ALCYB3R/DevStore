import SwiftUI

// --- DATA MODELS ---
struct StoreSource: Codable {
    let name: String
    let apps: [AppEntry]
}

struct AppEntry: Codable, Identifiable {
    var id: String { bundleIdentifier }
    let name: String
    let bundleIdentifier: String
    let developerName: String
    let version: String
    let downloadURL: String
    let localizedDescription: String
    let iconURL: String
}

// --- THE STOREFRONT VIEW ---
struct BrowseView: View {
    @State private var storeData: StoreSource?
    @State private var isLoading = true
    
    let sourceURL = URL(string: "https://r3alcyb3r.github.io/DevStore/apps.json")!

    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("Fetching DevStore...")
                } else if let store = storeData {
                    List(store.apps) { app in
                        HStack(spacing: 15) {
                            // 1. App Icon (Fetched from GitHub)
                            AsyncImage(url: URL(string: app.iconURL)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.2)
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(12)

                            // 2. App Info
                            VStack(alignment: .leading, spacing: 4) {
                                Text(app.name).font(.headline)
                                Text(app.developerName).font(.caption).foregroundColor(.secondary)
                                Text("v\(app.version)").font(.caption2).monospaced()
                            }

                            Spacer()

                            // 3. Install Button
                            Button(action: { downloadApp(url: app.downloadURL) }) {
                                Text("GET")
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(20)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                } else {
                    Text("Failed to load DevStore. Check connection.")
                }
            }
            .navigationTitle("Browse")
            .task {
                await fetchStore()
            }
        }
    }

    // --- LOGIC: FETCH DATA ---
    func fetchStore() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: sourceURL)
            let decoded = try JSONDecoder().decode(StoreSource.self, from: data)
            DispatchQueue.main.async {
                self.storeData = decoded
                self.isLoading = false
            }
        } catch {
            print("Error loading store: \(error)")
            isLoading = false
        }
    }

    // --- LOGIC: DOWNLOAD ---
    func downloadApp(url: String) {
        if let link = URL(string: url) {
            UIApplication.shared.open(link)
        }
    }
}
