//
//  HomeView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/20/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var budgetVM = BudgetsViewModel()
    @StateObject var transactionsVM = TransactionsViewModel()
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            OverviewView(
                budgetVM: budgetVM,
                transactionVM: transactionsVM
            )
            .tag(0)
                .tabItem { Label(
                    title: { Text("Overview") },
                    icon: { Image(systemName: "gauge") }
                    )
                }
                    
            TransactionsView(
                transactionsVM: transactionsVM,
                budgetsVM: budgetVM
            )
                .tag(1)
                .tabItem { Label(
                    title: { Text("Transactions") },
                    icon: { Image(systemName: "banknote") }
                    )
                }
                    
            SettingsView()
                .tag(2)
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
