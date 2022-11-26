import SwiftUI

struct OnAppearMonitor: View {
    var label: String
    @State private var onAppearTimestamp: Date? = nil

    var body: some View {
        VStack {
            Text(label)
            ZStack {
                if let t = onAppearTimestamp {
                    Text("onAppear: \(t, style: .timer) ago")
                        .monospacedDigit()
                        .bold()
                } else {
                    Text("onAppear")
                        .hidden()
                }
            }
            .animation(.easeOut(duration: 1), value: onAppearTimestamp)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundStyle(.background)
        .background { Capsule() }
        .onAppear {
            let timestamp = Date.now
            print("\(timestamp) \(label): onAppear")
            onAppearTimestamp = timestamp
        }
        .onDisappear {
            print("\(Date.now) \(label): onDisappear")
        }
    }
}

struct OnAppearMonitor_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ForEach(1..<100) { i in
                OnAppearMonitor(label: "\(i)")
                    .foregroundStyle(.green)
            }
        }
    }
}
