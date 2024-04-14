import SwiftUI

struct AddTransactionView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    @ObservedObject var budgetsVM: BudgetsViewModel
//    let categories: [BudgetCategory]
    @State var date = Date()
    @State var amount = ""
    @State var name = ""
    @State var description = ""
    @State var typeSelection: BudgetName? = nil
    
    @State var pickerSelection: BudgetCategory? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
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
                Picker("Type", selection: $pickerSelection) {
                    ForEach(BudgetCategory.allCases, id: \.self) { value in
                        Text(value.description.description)
                            .tag(value)
                    }
                }
            }
            HStack {
                Picker("Category", selection: $typeSelection) {
                    ForEach(budgetsVM.budgetNames, id: \.id) { category in
                        Text(category.name)
                            .tag(category.id)
                    }
                    Text(BudgetName(name: "Other").name)
                        .tag("other")
                }
            }
            HStack {
                Text("Name")
                Spacer()
                TextField("Ex: Rent", text: $name)
                    .fixedSize()
            }

            TextField("Enter description here", text: $description)
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

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(
            transactionsVM: TransactionsViewModel(),
            budgetsVM: dev.budgetVM
        )
    }
}
