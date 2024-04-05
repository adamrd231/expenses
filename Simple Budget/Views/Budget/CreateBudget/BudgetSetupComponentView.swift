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
    @State private var sheetContentHeight = CGFloat(0)
    
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
                            Text("Total income:")
                        } else {
                            Text("Available")
                        }
                        
                        switch budgetType {
                        case .income: Text(vm.budgetModel.totalBudget, format: .currency(code: "USD"))
                        case .needs: Text(vm.budgetModel.needBudgetGoal - vm.budgetModel.needBudgetTotal, format: .currency(code: "USD"))
                        case .wants: Text(vm.budgetModel.wantsBudgeGoal - vm.budgetModel.wantsBudgetTotal, format: .currency(code: "USD"))
                        case .save: Text(vm.budgetModel.saveBudgetGoal - vm.budgetModel.saveBudgetTotal, format: .currency(code: "USD"))
                        }
                    }
                    .padding(10)
           
                    switch budgetType {
                    case .income: EmptyView()
                    case .needs:  CustomProgressBar(
                        progress: vm.budgetModel.needBudgetTotal / vm.budgetModel.needBudgetGoal
                    ).padding(10)
                    case .wants:  CustomProgressBar(
                        progress: vm.budgetModel.wantsBudgetTotal / vm.budgetModel.wantsBudgeGoal
                    ).padding(10)
                    case .save: CustomProgressBar(
                        progress: vm.budgetModel.saveBudgetTotal / vm.budgetModel.saveBudgetGoal
                    ).padding(10)
                    }
                       
                    switch budgetType {
                    case .income: 
                        BudgetItemsTableView(items: vm.budgetModel.incomeItems).padding(10)
                    case .needs: BudgetItemsTableView(items: vm.budgetModel.needItems).padding(10)
                    case .wants: BudgetItemsTableView(items: vm.budgetModel.wantItems).padding(10)
                    case .save: BudgetItemsTableView(items: vm.budgetModel.saveItems).padding(10)
                    }
                }
            }
            .sheet(isPresented: $isAddingNeedsItem, content: {
                AddBudgetItemView(
                    vm: vm,
                    currentIndex: currentIndex,
                    isAddingBudgetItem: $isAddingNeedsItem
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
