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
    @State var newItemName: String = ""
    @State var newItemValue: Double? = nil
    @FocusState private var nameIsFocused: Bool

    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Text(totalBudgetGoal, format: .currency(code: "USD"))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        switch budgetType {
                        case .income: Text("Monthly income")
                        case .needs: Text("Needs budget total")
                        case .wants: Text("Wants budget total")
                        case .save: Text("Save budget total")
                        }
                    }
                    Spacer()
                }
                .padding(.top)
                
                if budgetType != .income {
                    CustomProgressBar(
                        title: budgetType.description,
                        startDate: startDate,
                        endDate: endDate,
                        currentSpend: items.map({$0.amount}).reduce(0, +),
                        totalBudget: totalBudgetGoal
                    )
                    .padding(.horizontal)
                }
            }
            
            BudgetItemsTableView(items: $items)
                .listStyle(.plain)
            
            VStack {
                TextField("Name", text: $newItemName)
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(.roundedBorder)
                    .focused($nameIsFocused)

                TextField("Amount", value: $newItemValue, format: .number)
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .focused($nameIsFocused)
                Button {
                    if let value = newItemValue {
                        let newItem = BudgetItem(name: newItemName, amount: value)
                        items.append(newItem)
                        nameIsFocused = false
                        newItemName = ""
                        newItemValue = nil
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add item")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
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
