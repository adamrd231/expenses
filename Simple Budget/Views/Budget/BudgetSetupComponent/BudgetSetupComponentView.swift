import SwiftUI

enum Field {
    case name
    case value
}

struct BudgetSetupComponentView: View {
    @Binding var items: [BudgetItem]
    let budgetType: BudgetCategory
    let totalBudgetGoal: Double
    let startDate: Date
    let endDate: Date

    @State var isAddingNeedsItem: Bool = false
    @State private var sheetContentHeight = CGFloat(0)
    @State var newItemName: String = ""
    @State var newItemValue: Double? = nil
    @FocusState private var nameIsFocused: Bool
    @FocusState private var valueIsFocused: Bool
    @FocusState private var focusedField: Field?

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Text(totalBudgetGoal, format: .currency(code: "USD"))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        switch budgetType {
                        case .income: Text("Monthly income")
                        case .needs: Text("Needs budget total")
                        case .wants: Text("Wants budget total")
                        case .save: Text("Save budget total")
                        }
                    }
                    Spacer()
                }
                .padding(.top)
                
                if budgetType != .income {
                    ProgressBarView(
                        currentSpend: items.map({$0.amount}).reduce(0, +), 
                        totalBudget: totalBudgetGoal
                    )
                    .padding(.horizontal)
                    .frame(maxHeight: 50)
                }
            }
            
            BudgetItemsTableView(items: $items)
                .listStyle(.plain)
            
            VStack {
                TextField("Name", text: $newItemName)
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(.roundedBorder)
                    .focused($focusedField, equals: .name)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .value
                    }

                TextField("Amount", value: $newItemValue, format: .number)
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .value)
         
                Button {
                    if let value = newItemValue {
                        let newItem = BudgetItem(name: BudgetItemType(name: newItemName), amount: value)
                        items.append(newItem)
                        // Persist new update to array
                        focusedField = nil
                        newItemName = ""
                        newItemValue = nil
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.theme.green)
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add item")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
                .disabled(newItemName == "" || newItemValue == nil)
            }
            .padding()
            .navigationTitle("Add \(budgetType.description)")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}

#Preview {
    NavigationStack {
        BudgetSetupComponentView(
            items: .constant(
                [
                    BudgetItem(name: BudgetItemType(name: "String"), amount: 100)
                ]),
            budgetType: .needs,
            totalBudgetGoal: 10_000,
            startDate: Date(),
            endDate: Date().addingTimeInterval(10_000)
        )
        .navigationTitle("Add items")
    }
    
}
