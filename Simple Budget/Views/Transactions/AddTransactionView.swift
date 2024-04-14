import SwiftUI

struct AddTransactionView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    @ObservedObject var budgetsVM: BudgetsViewModel
//    let categories: [BudgetCategory]
    @State var date = Date()
    @State var amount: Double? = nil
    @State var name = ""
    @State var description = ""
    @State var pickerSelection: BudgetCategory = .income
    @State var typeSelection: BudgetName = BudgetName(name: "Other")
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
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
                                    .tag(value) // Use the enum value as the tag
                            }
                        }
                    }
                    HStack {
                        Picker("Category", selection: $typeSelection) {
                            ForEach(budgetsVM.budgetNames, id: \.id) { category in
                                Text(category.name)
                                    .tag(category)
                            }
                            Text(BudgetName(name: "Other").name)
                                .tag("other")
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
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(
            transactionsVM: TransactionsViewModel(),
            budgetsVM: dev.budgetVM
        )
    }
}
