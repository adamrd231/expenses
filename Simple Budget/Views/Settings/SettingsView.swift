import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("About the App") {
                    VStack(alignment: .leading) {
                        Text("Money Moves")
                            .bold()
                        Text("Thanks for downloading my app! I designed Money Moves to help users quickly and easily setup a budget, and be able to keep themselves accountable. This is the first version of the app, and plan on adding new features in the future, I would love any feedback or ideas at adam@rdconcepts.design.")
                    }
                }
                
                Section("Future Versions") {
                    Text("Automatically download transactions from bank account")
                    Text("Share / manage budgets with others")
                    Text("Track and manage subscriptions")              }
            }
            .listStyle(.plain)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
