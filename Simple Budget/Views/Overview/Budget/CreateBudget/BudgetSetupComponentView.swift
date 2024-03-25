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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                switch currentIndex {
                case 2: Text("Income").font(.title)
                case 3: Text("Needs").font(.title)
                case 4: Text("Wants").font(.title)
                case 5: Text("Save").font(.title)
                default: Text("Summary").font(.title)
                }
               
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
                case .income: BudgetItemsTableView(items: $vm.budgetModel.incomeItems)
                case .needs: BudgetItemsTableView(items: $vm.budgetModel.needItems)
                case .wants: BudgetItemsTableView(items: $vm.budgetModel.wantItems)
                case .save: BudgetItemsTableView(items: $vm.budgetModel.saveItems)
                }
                
                Spacer()
                PlusButton(action: {
                    print("Toggle button")
                    isAddingNeedsItem.toggle()
                    print(isAddingNeedsItem)
                })
                
            }
            .sheet(isPresented: $isAddingNeedsItem, content: {
                AddBudgetItemView(
                    vm: vm,
                    currentIndex: currentIndex,
                    isAddingBudgetItem: $isAddingNeedsItem
                )
                .presentationDetents([.medium])
            })
            .padding(.horizontal)
        }
    }
}

#Preview {
    BudgetSetupComponentView(vm: BudgetsViewModel(), currentIndex: 3, budgetType: .needs)
}
