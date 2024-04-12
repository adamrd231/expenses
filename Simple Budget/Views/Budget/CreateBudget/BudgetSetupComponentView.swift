//
//  NeedsView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct BudgetSetupComponentView: View {
    let budgetType: BudgetCategory
    @Binding var items: [BudgetItem]
    let currentIndex: Int

    @State var isAddingNeedsItem: Bool = false
    @State private var sheetContentHeight = CGFloat(0)
    
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
                if budgetType != .income {
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
                }
                
                Section {
                    switch budgetType {
                    case .income: 
                        BudgetItemsTableView(items: vm.budgetModel.incomeItems).padding(10)
                    case .needs: BudgetItemsTableView(items: vm.budgetModel.needItems).padding(10)
                    case .wants: BudgetItemsTableView(items: vm.budgetModel.wantItems).padding(10)
                    case .save: BudgetItemsTableView(items: vm.budgetModel.saveItems).padding(10)
                    }
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
        }
    }
}

#Preview {
    BudgetSetupComponentView(vm: BudgetsViewModel(), currentIndex: 2, budgetType: .income)
}
