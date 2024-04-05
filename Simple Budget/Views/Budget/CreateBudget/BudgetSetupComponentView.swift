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
    
    func getTotalBudget() -> Text {
        var text: Double = 0
        switch budgetType {
        case .income: text = vm.budgetModel.totalBudget
        case .needs: text = vm.budgetModel.needBudgetGoal - vm.budgetModel.needBudgetTotal
        case .wants: text = vm.budgetModel.wantsBudgeGoal - vm.budgetModel.wantsBudgetTotal
        case .save: text = vm.budgetModel.saveBudgetGoal - vm.budgetModel.saveBudgetTotal
        }
        return Text(text, format: .currency(code: "USD"))
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Total") {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            getTotalBudget()
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
                Section("Overview") {
                    switch budgetType {
                    case .income: EmptyView()
                    case .needs:  
                        CustomProgressBar(
                            title: "Needs",
                            startDate: vm.budgetModel.start,
                            endDate: vm.budgetModel.end,
                            currentSpend: vm.budgetModel.needBudgetTotal,
                            totalBudget: vm.budgetModel.needBudgetGoal
                        )
                    case .wants:
                        CustomProgressBar(
                            title: "Wants",
                            startDate: vm.budgetModel.start,
                            endDate: vm.budgetModel.end,
                            currentSpend: vm.budgetModel.incomeItems.map({ $0.amount}).reduce(0, +),
                            totalBudget: vm.budgetModel.wantsBudgetTotal
                        )
                    case .save:
                        CustomProgressBar(
                            title: "Save",
                            startDate: vm.budgetModel.start,
                            endDate: vm.budgetModel.end,
                            currentSpend: vm.budgetModel.incomeItems.map({ $0.amount}).reduce(0, +),
                            totalBudget: vm.budgetModel.saveBudgetTotal
                        )
                    }
                }
                Section(header: getSectionTitle()) {
                       
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
