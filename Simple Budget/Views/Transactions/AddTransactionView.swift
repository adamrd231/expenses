import SwiftUI

struct AddTransactionView: View {
    // Parameters
    let addTransaction: (Transaction) -> Void
    let categories: [BudgetCategory: [BudgetItemType]]

    // Variables for creating transactions
    @State var newTransaction: Transaction = Transaction(data: Date(), description: "")

    var filteredCategories: [BudgetItemType] {
        if let picker = newTransaction.category {
            let categories = categories[picker]
            return categories ?? []
        } else {
            return []
        }
    }
    
    @Environment(\.dismiss) var dismiss
    @State var shouldCloseAfterCreation: Bool = true
    
    func reset() {
        newTransaction = Transaction(data: Date(), description: "")
    }
    
    var body: some View {
            Form {
                Section(header: Text("New Transaction")) {
                    HStack {
                        Text("Date")
                        DatePicker("", selection: $newTransaction.date, displayedComponents: .date)
                    }
                    HStack {
                        Text("Amount")
                        if newTransaction.amount == nil {
                            Text("*")
                                .foregroundStyle(Color.theme.red)
                        }
                       
                        Spacer()
                        TextField("Ex: $500.00", value: $newTransaction.amount, format: .number)
                            .fixedSize()
                            .multilineTextAlignment(.trailing)
                    }
     
                    Picker("Type", selection: $newTransaction.category) {
                        ForEach(BudgetCategory.allCases, id: \.self) { value in
                            Text(value.description)
                                .tag(Optional(value))
                        }
                    }
                    
                    Picker("Category", selection: $newTransaction.type) {
                        Text("No selection")
                            .tag(Optional<BudgetItemType>(nil))
                        ForEach(filteredCategories, id: \.id) { category in
                            Text(category.name)
                                .tag(Optional(category))
                        }
                    }
                
                    TextField("Enter description here", text: $newTransaction.description)
                }
                
                Button {
                    addTransaction(newTransaction)
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text("Create")
                            .foregroundStyle(.white)
                            .opacity(newTransaction.amount == nil || newTransaction.category == nil ? 0.66 : 1)
                        Spacer()
                    }
                }
                .listRowBackground(Color.theme.blue)
                .disabled(newTransaction.amount == nil || newTransaction.category == nil)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        shouldCloseAfterCreation.toggle()
                    } label: {
                        HStack(spacing: 5) {
                            Image(systemName: shouldCloseAfterCreation ? "checkmark.circle" : "xmark.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Auto Close")
                                
                        }
                        .foregroundStyle(shouldCloseAfterCreation ? Color.theme.green : Color.theme.secondaryText)
                    }
                }
            }
        
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddTransactionView(
                addTransaction: { _ in },
                categories: [.income: [BudgetItemType(name: "First")]]
            )
        }
    }
}
