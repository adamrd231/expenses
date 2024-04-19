import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Linked Bank Accounts - Plaid (Coming soon)")
                
                // TODO: Update links with proper URLs
                Link("Rate the App", destination: URL(string: "wwww.google.com")!)
                Link("Share the App", destination: URL(string: "wwww.google.com")!)
            }
            .listStyle(.plain)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
