//
//  NeedsView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct BudgetSetupComponentView: View {
    @ObservedObject var vm: BudgetsViewModel
    let currentIndex: Int
    let budgetType: BudgetCategory
    @State var isAddingNeedsItem: Bool = false
    
    func getSectionTitle() -> Text {
        switch currentIndex {
        case 2: Text("Income")
        case 3: Text("Needs")
        case 4: Text("Wants")
        case 5: Text("Save")
        default: Text("Summary")
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: getSectionTitle()) {
                    HStack {
                        if budgetType == .income {
                            Text("Total")
                        } else {
                            Text("Available")
                        }
                        Text(vm.budgetModel.currencySymbol)
                        switch budgetType {
                        case .income: Text(vm.budgetModel.totalBudget, format: .number)
                        case .needs: Text(vm.budgetModel.needBudgetGoal - vm.budgetModel.needBudgetTotal, format: .number)
                        case .wants: Text(vm.budgetModel.wantsBudgeGoal - vm.budgetModel.wantsBudgetTotal, format: .number)
                        case .save: Text(vm.budgetModel.saveBudgetGoal - vm.budgetModel.saveBudgetTotal, format: .number)
                        }
                    }
           
                    switch budgetType {
                    case .income: EmptyView()
                    case .needs:  CustomProgressBar(
                        progress: vm.budgetModel.needBudgetTotal / vm.budgetModel.needBudgetGoal
                    )
                    case .wants:  CustomProgressBar(
                        progress: vm.budgetModel.wantsBudgetTotal / vm.budgetModel.wantsBudgeGoal
                    )
                    case .save: CustomProgressBar(
                        progress: vm.budgetModel.saveBudgetTotal / vm.budgetModel.saveBudgetGoal
                    )
                    }
                       
                    switch budgetType {
                    case .income: 
                        BudgetItemsTableView(items: vm.budgetModel.incomeItems)
                    case .needs: BudgetItemsTableView(items: vm.budgetModel.needItems)
                    case .wants: BudgetItemsTableView(items: vm.budgetModel.wantItems)
                    case .save: BudgetItemsTableView(items: vm.budgetModel.saveItems)
                    }
                }
            }
            .sheet(isPresented: $isAddingNeedsItem, content: {
                AddBudgetItemView(
                    vm: vm,
                    currentIndex: currentIndex,
                    isAddingBudgetItem: $isAddingNeedsItem
                )
                .presentationDetents([.medium])
            })
            PlusButton(action: {
                print("Toggle button")
                isAddingNeedsItem.toggle()
                print(isAddingNeedsItem)
            })
        }
    }
}

#Preview {
    BudgetSetupComponentView(vm: BudgetsViewModel(), currentIndex: 2, budgetType: .income)
}
