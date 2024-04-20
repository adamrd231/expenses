import SwiftUI

struct HomeView: View {
    @StateObject var budgetVM = BudgetsViewModel()
    @StateObject var transactionsVM = TransactionsViewModel()
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            OverviewView(
                budgetVM: budgetVM,
                transactionVM: transactionsVM,
                selectedTab: $selectedTab
            )
            .tag(0)
            .tabItem { Label(
                title: { Text("Overview") },
                icon: { Image(systemName: "gauge") }
                )
            }
            
            BudgetsView(budgetVM: budgetVM)
                .tag(1)
                .tabItem { Label(
                    title: { Text("Budgets") },
                    icon: { Image(systemName: "note.text") }
                    )
                }
                    
            TransactionsView(
                transactionsVM: transactionsVM,
                budgetsVM: budgetVM
            )
            .tag(2)
            .tabItem { Label(
                title: { Text("Transactions") },
                icon: { Image(systemName: "banknote") }
                )
            }
                    
            SettingsView()
                .tag(3)
                .tabItem { Label(
                    title: { Text("Settings") },
                    icon: { Image(systemName: "gear") }
                    )
                }
        }
    }
}

#Preview {
    HomeView()
}
