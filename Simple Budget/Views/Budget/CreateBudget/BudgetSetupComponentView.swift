//
//  NeedsView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct BudgetSetupComponentView: View {
    @Binding var items: [BudgetItem]
    let budgetType: BudgetCategory
    let totalBudgetGoal: Double
    let startDate: Date
    let endDate: Date

    @State var isAddingNeedsItem: Bool = false
    @State private var sheetContentHeight = CGFloat(0)
    
    var body: some View {
        NavigationStack {
            List {
                Section("Total") {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Text(items.map({$0.amount}).reduce(0, +), format: .number)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            switch budgetType {
                            case .income:
                                Text("Monthly income")
                            case .needs:
                                Text("Needs budget total")
                            case .wants:
                                Text("Wants budget total")
                            case .save:
                                Text("Save budget total")
                            }
                        }
                        Spacer()
                    }
                }
                
                CustomProgressBar(
                    title: budgetType.description,
                    startDate: startDate,
                    endDate: endDate,
                    currentSpend: items.map({$0.amount}).reduce(0, +),
                    totalBudget: totalBudgetGoal
                )
                
                Section {
                    BudgetItemsTableView(items: items).padding(10)
                    
                    HStack {
                        Button {
                            isAddingNeedsItem.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                        Text("Add item")
                            .font(.callout)
                            .fontWeight(.light)
                    }
                   
                }
            }
            .sheet(isPresented: $isAddingNeedsItem, content: {
                AddBudgetItemView(
                    items: $items,
                    budgetType: budgetType
                )
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .task {
                                sheetContentHeight = proxy.size.height
                            }
                    }
                }
                .presentationDetents([.height(sheetContentHeight)])
            })
        }
    }
}

#Preview {
    BudgetSetupComponentView(
        items: .constant(
            [
                BudgetItem(name: "App Store", amount: 100)
            ]),
        budgetType: .income,
        totalBudgetGoal: 10_000,
        startDate: Date(),
        endDate: Date().addingTimeInterval(10_000)
    )
}
