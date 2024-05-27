import SwiftUI

struct AddTransactionView: View {
    // Parameters
    let addTransaction: (Transaction) -> Void
    let categories: [BudgetCategory: [BudgetItemType]]

    // Variables for creating transactions
    @State var newTransaction: Transaction = Transaction(data: Date(), description: "")
    @State var date = Date()
    @State var amount: Double? = nil
    @State var description = ""
    @State var pickerSelection: BudgetCategory?
    @State var typeSelection: BudgetItemType?
    var filteredCategories: [BudgetItemType] {
        if let picker = pickerSelection {
            let categories = categories[picker]
            return categories ?? []
        } else {
            return []
        }
    }
    
    @Environment(\.dismiss) var dismiss
    @State var shouldCloseAfterCreation: Bool = true
    
    func reset() {
        date = Date()
        amount = nil
        description = ""
        pickerSelection = nil
        typeSelection = nil
    }
    
    var body: some View {
            Form {
                Section(header: Text("New Transaction")) {
                    HStack {
                        Text("Date")
                        DatePicker("", selection: $date, displayedComponents: .date)
                    }
                    HStack {
                        Text("Amount")
                        if amount == nil {
                            Text("*")
                                .foregroundStyle(Color.theme.red)
                        }
                       
                        Spacer()
                        TextField("Ex: $500.00", value: $newTransaction.amount, format: .number)
                            .fixedSize()
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Type")
                        if pickerSelection == nil {
                            Text("*")
                                .foregroundStyle(Color.theme.red)
                        }
                        Picker("Make selection", selection: $newTransaction.category) {
                            ForEach(BudgetCategory.allCases, id: \.self) { value in
                                Text(value.description)
                                    .tag(Optional(value))
                            }
                        }
                    }
                    HStack {
                        Text("Category")
                        if typeSelection == nil {
                            Text("*")
                                .foregroundStyle(Color.theme.red)
                        }
                        Picker("", selection: $typeSelection) {
                            Text("No selection")
                                .tag(Optional<BudgetItemType>(nil))
                            ForEach(filteredCategories, id: \.id) { category in
                                Text(category.name)
                                    .tag(Optional(category))
                            }
                        }
                    }
                    TextField("Enter description here", text: $description)
                }
                Button {
                    addTransaction(newTransaction)
                    dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        Text("Create")
                            .foregroundStyle(.white)
                    }
                }
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
