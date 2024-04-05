//
//  BudgetItemsTableView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct BudgetItemsTableView: View {
    @Binding var items: [BudgetItem]
    @State var isEditing: Bool = false

    var body: some View {
        VStack {
            List {
                ForEach($items, id: \.id) { $item in
                    HStack {
                        Text(item.name)
         
                        if let dueDate = item.due {
                            Text(dueDate, format: .number)
           
                                .frame(maxWidth: 66)
                        } else {
                            EmptyView()
                        }
            
                        Text(item.amount, format: .number)
          
                        if isEditing {
                            Button {
                                if let index = items.firstIndex(where: { $0.id == item.id }) {
                                    items.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "delete.left")
                            }
                        }
        
                    }
                }
                .onDelete(perform: { indexSet in
                    print("index \(indexSet)")
                })
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    BudgetItemsTableView(items: .constant([]))
}
