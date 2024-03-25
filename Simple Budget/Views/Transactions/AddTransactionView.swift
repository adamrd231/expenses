//
//  AddTransactionView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/24/24.
//

import SwiftUI

struct AddTransactionView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    @ObservedObject var budgetsVM: BudgetsViewModel
    @State var date = Date()
    @State var amount = ""
    @State var name = ""
    @State var description = ""
    @State var typeSelection: TransactionCategory = TransactionCategory(name: "Blank")
    @State var pickerSelection: BudgetCategory = .income
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Text("Date")
                DatePicker("", selection: $date, displayedComponents: .date)
            }
            .onAppear {
                print("Budget categories \(budgetsVM.budgetCategoryTypes)")
            }
            HStack {
                Text("Amount")
                Spacer()
                TextField("Ex: $500.00", text: $amount)
                    .fixedSize()
            }
            HStack {
                Text("Type")
                Spacer()
                Picker("Category", selection: $pickerSelection) {
                    ForEach(BudgetCategory.allCases, id: \.self) { value in
                        Text(value.description.description)
                            .tag(value)
                    }
                }
            }
            HStack {
                Text("Category")
                Spacer()
                Picker("Category", selection: $typeSelection) {
                    ForEach(budgetsVM.budgetCategoryTypes, id: \.id) { category in
                        Text(category.name)
                            .tag(category)
                    }
                }
            }
            HStack {
                Text("Name")
                Spacer()
                TextField("Ex: Rent", text: $name)
            }

            TextField("Enter description here", text: $description)
            
            
            PlusButton(action: {
                let newTransaction = Transaction(
                    data: date,
                    amount: Double(amount) ?? 0,
                    category: pickerSelection,
                    type: typeSelection,
                    name: name,
                    description: description
                )
                transactionsVM.addNew(transaction: newTransaction)
                dismiss()
            })
        }
        .padding(.horizontal)
    }
}

#Preview {
    AddTransactionView(
        transactionsVM: TransactionsViewModel(),
        budgetsVM: BudgetsViewModel()
    )
}
