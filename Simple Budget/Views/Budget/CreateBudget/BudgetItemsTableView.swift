import SwiftUI

struct BudgetItemsTableView: View {
    @Binding var items: [BudgetItem]
    @State var isEditing: Bool = false

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("#")
                        .frame(minWidth: 10)
                    Text("-")
                        .frame(minWidth: 10)
                    Text("Name")
                    Spacer()
                    Text("Value")
                }
                .foregroundStyle(.gray)
                .font(.caption)
                
                ForEach(Array(zip(items, items.indices)), id: \.0) { item, index in
                    HStack {
                        Text(index + 1, format: .number)
                            .font(.caption)
                            .frame(minWidth: 10)
                        Text("-")
                            .font(.caption)
                            .frame(minWidth: 10)
                        Text(item.name.name)
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: { indexSet in
                    items.remove(atOffsets: indexSet)
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        BudgetItemsTableView(
            items: .constant([
                BudgetItem(name: BudgetName(name: "Apple"), amount: 1.20),
                BudgetItem(name: BudgetName(name: "Pickle"), amount: 3.50),
                BudgetItem(name: BudgetName(name: "Burger"), amount: 15)
            ])
        )
    }
   
}
