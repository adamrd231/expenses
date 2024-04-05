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
    @State var cost: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Add item")
                .font(.title3)
                .bold()

                TextField("name", text: $name)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .multilineTextAlignment(.center)
   
                TextField("value", text: $cost)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
            
            Button("Add item") {
                guard let unwrappedCost = Double(cost) else { return }
                
                switch currentIndex {
                case 2:
                    let newItem = BudgetItem(type: .income, name: name, amount: unwrappedCost)
                    vm.budgetModel.incomeItems.append(newItem)
                case 3:
                    let newItem = BudgetItem(type: .needs, name: name, amount: unwrappedCost)
                    vm.budgetModel.needItems.append(newItem)
                case 4:
                    let newItem = BudgetItem(type: .wants, name: name, amount: unwrappedCost)
                    vm.budgetModel.wantItems.append(newItem)
                case 5:
                    let newItem = BudgetItem(type: .save, name: name, amount: unwrappedCost)
                    vm.budgetModel.saveItems.append(newItem)
                default: print("Error adding item")
                }
                isAddingBudgetItem = false
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddBudgetItemView(vm: BudgetsViewModel(), currentIndex: 0, isAddingBudgetItem: .constant(true))
}
