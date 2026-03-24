import SwiftUI

struct StartButtonView: View {
    @EnvironmentObject var security: SecurityManager
    @State private var progress: Double = 0.0
    @State private var isPressing = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(isPressing ? "Initializing..." : "Hold to Unlock")
                .font(.headline)
            
            ZStack {
                Circle().stroke(Color.gray.opacity(0.2), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: progress / 10.0)
                    .stroke(Color.blue, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                
                Text("START").bold()
            }
            .frame(width: 150, height: 150)
            .onLongPressGesture(minimumDuration: 10, pressing: { pressing in
                isPressing = pressing
                if !pressing { progress = 0 }
            }, perform: {
                security.isUnlocked = true
            })
            .onReceive(timer) { _ in
                if isPressing && progress < 10 {
                    progress += 0.1
                }
            }
        }
    }
}
