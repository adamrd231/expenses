//
//  BudgetsView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/21/24.
//

import SwiftUI



struct BudgetsView: View {
    @ObservedObject var budgetVM: BudgetsViewModel
    @State var isCreatingBudget: Bool = false
    
    var body: some View {
        NavigationStack {
//            Text("Budgets")
//                .font(.largeTitle)
//                .padding(.top)
            List {
                ForEach(budgetVM.budgets, id: \.id) { budget in
                    HStack {
                        Text(budget.start, style: .date)
                        Text("-")
                        Text(budget.end, style: .date)
                    }
                }
                .onDelete(perform: { indexSet in
                    budgetVM.budgets.remove(atOffsets: indexSet)
                })
            }
            .listStyle(.plain)
            Button {
                isCreatingBudget.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 66, height: 66)
                    .padding()
            }
            .navigationTitle("Budgets")
        }
        .fullScreenCover(isPresented: $isCreatingBudget, content: {
            CreateBudgetView(vm: budgetVM, isCreatingBudget: $isCreatingBudget)
        })
        
        
    }
}

#Preview {
    BudgetsView(budgetVM: BudgetsViewModel())
}
