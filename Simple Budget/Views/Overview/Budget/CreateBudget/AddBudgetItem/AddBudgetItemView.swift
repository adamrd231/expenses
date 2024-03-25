//
//  AddBudgetItemView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct AddBudgetItemView: View {
    @ObservedObject var vm: BudgetsViewModel
    let currentIndex: Int
    @Binding var isAddingBudgetItem: Bool

    @State var name: String = ""
    @State var dueDate: String = ""
    @State var cost: String = ""
    
    var body: some View {
        VStack {
            Text("Add item")
                .font(.title3)
                .bold()
            HStack {
                TextField("name", text: $name)
                    
                    .modifier(BorderModifier())
                if currentIndex == 3 || currentIndex == 4 {
                    TextField("due", text: $dueDate)
                        .modifier(BorderModifier())
                }
                TextField("cost", text: $cost)
                    .modifier(BorderModifier())
            }
            Button("Add item") {
                guard let unwrappedCost = Double(cost) else { return }
                
                switch currentIndex {
                case 2:
                    let newItem = BudgetItem(type: .income, name: name, due: Int(dueDate) ?? nil, amount: unwrappedCost)
                    vm.budgetModel.incomeItems.append(newItem)
                case 3:
                    let newItem = BudgetItem(type: .needs, name: name, due: Int(dueDate) ?? nil, amount: unwrappedCost)
                    vm.budgetModel.needItems.append(newItem)
                case 4:
                    let newItem = BudgetItem(type: .wants, name: name, due: Int(dueDate) ?? nil, amount: unwrappedCost)
                    vm.budgetModel.wantItems.append(newItem)
                case 5:
                    let newItem = BudgetItem(type: .save, name: name, due: Int(dueDate) ?? nil, amount: unwrappedCost)
                    vm.budgetModel.saveItems.append(newItem)
                default: print("Error adding item")
                }
                isAddingBudgetItem = false
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    AddBudgetItemView(vm: BudgetsViewModel(), currentIndex: 0, isAddingBudgetItem: .constant(true))
}
