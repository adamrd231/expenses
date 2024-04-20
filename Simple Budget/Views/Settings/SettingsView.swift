import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text("Fudget Budget")
                            .bold()
                        Text("Thanks for downloading my application, you can currently use fudget budget to setup budgets and track progress, no need to fudge the books.")
                    }
                }
 
                Section {
                    VStack(alignment: .leading) {
                        Text("Link your bank account")
                            .bold()
                        Text("I am working on integrating your bank account so you can connect the app to Plaid and autmagically download your transactions, any feedback and questions can be sent to adam@rdconcepts.design.")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
