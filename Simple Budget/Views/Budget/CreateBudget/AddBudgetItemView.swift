//
//  AddBudgetItemView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct AddBudgetItemView: View {
    @Binding var items: [BudgetItem]
    let budgetType: BudgetCategory
    @Environment(\.dismiss) var dismiss
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
                let newItem = BudgetItem(name: name, amount: unwrappedCost)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddBudgetItemView(
        items: .constant([]),
        budgetType: .income
    )
}
