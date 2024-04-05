//
//  BudgetItemsTableView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct BudgetItemsTableView: View {
    let items: [BudgetItem]
    @State var isEditing: Bool = false

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("#")
                    Text("-")
                    Text("Name")
                }
               
                Spacer()
                Text("Value")
            }
            .foregroundStyle(.gray)
            .font(.caption)
            
           
            ForEach(Array(zip(items, items.indices)), id: \.0) { item, index in
                if items.count == 0 {
                    Text("Empty")
                } else {
                    HStack {
                        Text(index + 1, format: .number)
                            .font(.caption)
                        Text("-")
                            .font(.caption)
                        Text(item.name)
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
            }
            .onDelete(perform: { indexSet in
                print("index \(indexSet)")
            })
        }
    }
}

#Preview {
    BudgetItemsTableView(items: [
            BudgetItem(type: .income, name: "Banana", amount: 1.20),
            BudgetItem(type: .income, name: "Pickle", amount: 3.50),
            BudgetItem(type: .income, name: "Burger", amount: 15)
        ]
    )
}
