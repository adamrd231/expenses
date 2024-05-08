import SwiftUI

struct AddTransactionView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    let categories: [BudgetCategory: [BudgetName]]
    @State var date = Date()
    @State var amount: Double? = nil
    @State var name = ""
    @State var description = ""
    @State var pickerSelection: BudgetCategory = .income
    @State var typeSelection: BudgetName = BudgetName(name: "Other")
    var filteredCategories: [BudgetName] {
        let categories = categories[pickerSelection]
        return categories ?? []
    }
    
    @Environment(\.dismiss) var dismiss
    @State var shouldCloseAfterCreation: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("New Transaction")) {
                    HStack {
                        Text("Date")
                        DatePicker("", selection: $date, displayedComponents: .date)
                    }
                    HStack {
                        Text("Amount")
                        Spacer()
                        TextField("Ex: $500.00", value: $amount, format: .number)
                            .fixedSize()
                    }
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Ex: Rent", text: $name)
                            .fixedSize()
                    }
                    TextField("Enter description here", text: $description)
                    
                    HStack {
                        Picker("Type", selection: $pickerSelection) {
                            ForEach(BudgetCategory.allCases, id: \.self) { value in
                                Text(value.description)
                                    .tag(value)
                            }
                        }
                    }
                    HStack {
                        Picker("Category", selection: $typeSelection) {
                            ForEach(filteredCategories, id: \.id) { category in
                                Text(category.name)
                                    .tag(category)
                            }
                        }
                    }
                }
            }
            
            
            Button {
                // TODO: Add new transaction here
                if let unwrappedAmount = amount {
                    var newTransaction = Transaction(
                        data: date,
                        amount: unwrappedAmount,
                        category: pickerSelection,
                        type: typeSelection,
                        name: name,
                        description: description
                    )
                    transactionsVM.transactions.append(newTransaction)
                    if shouldCloseAfterCreation {
                        dismiss()
                    }
                }
                
               
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.theme.blue)
                    Text("Create")
                        .foregroundStyle(.white)
                        .padding()
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding()
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
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddTransactionView(
                transactionsVM: TransactionsViewModel(),
                categories: [.income: [BudgetName(name: "First")]]
            )
        }
    }
}
