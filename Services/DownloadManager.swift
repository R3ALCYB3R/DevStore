import Foundation
import SwiftUI

class DownloadManager: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var isDownloading = false
    @Published var downloadFinished = false
    
    func downloadIPA(from urlString: String, fileName: String) {
        guard let url = URL(string: urlString) else { return }
        
        isDownloading = true
        progress = 0.0
        
        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url) { localURL, response, error in
            if let error = error {
                print("Download failed: \(error.localizedDescription)")
                DispatchQueue.main.async { self.isDownloading = false }
                return
            }
            
            guard let localURL = localURL else { return }
            
            // Move the file to the app's documents folder
            let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = docsURL.appendingPathComponent("\(fileName).ipa")
            
            try? FileManager.default.removeItem(at: destinationURL)
            
            do {
                try FileManager.default.moveItem(at: localURL, to: destinationURL)
                DispatchQueue.main.async {
                    self.isDownloading = false
                    self.downloadFinished = true
                    print("IPA Saved to: \(destinationURL.path)")
                }
            } catch {
                print("File error: \(error.localizedDescription)")
            }
        }
        
        // Track progress
        downloadTask.resume()
    }
}
