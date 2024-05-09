import SwiftUI

struct AddTransactionView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    let categories: [BudgetCategory: [BudgetItemType]]
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
    
    var isDisabled: Bool {
        if  amount != nil && pickerSelection != nil && typeSelection != nil {
            return false
        } else {
            return true
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
        NavigationStack {
            List {
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
                        TextField("Ex: $500.00", value: $amount, format: .number)
                            .fixedSize()
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Type")
                        if pickerSelection == nil {
                            Text("*")
                                .foregroundStyle(Color.theme.red)
                        }
                        Picker("", selection: $pickerSelection) {
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
                            ForEach(filteredCategories, id: \.id) { category in
                                Text(category.name)
                                    .tag(Optional(category))
                            }
                        }
                    }
                    TextField("Enter description here", text: $description)
                }
            }
            
            
            Button {
                if let unwrappedAmount = amount,
                let unwrappedPicker = pickerSelection,
                let unwrappedBudgetName = typeSelection {
                    var newTransaction = Transaction(
                        data: date,
                        amount: unwrappedAmount,
                        category: unwrappedPicker,
                        type: unwrappedBudgetName,
                        description: description
                    )
                    transactionsVM.transactions.append(newTransaction)
                    
                    if shouldCloseAfterCreation {
                        dismiss()
                    } else {
                        reset()
                    }
                }
                
               
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(isDisabled ? Color.theme.background : Color.theme.green)
                    Text("Create")
                        .foregroundStyle(isDisabled ? Color.theme.secondaryText : .white)
                        .padding()
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)
                .padding(.bottom)
                .disabled(isDisabled)
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
                categories: [.income: [BudgetItemType(name: "First")]]
            )
        }
    }
}
