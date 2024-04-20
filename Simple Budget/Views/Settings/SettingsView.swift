import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                VStack(alignment: .leading) {
                    Text("Fudget Budget")
                        .bold()
                    Text("Thanks for downloading my application, you can currently use fudget budget to setup budgets and track progress, no need to fudge the books.")
                }
                
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
