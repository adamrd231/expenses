//
//  OverviewCategoryView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/23/24.
//

import SwiftUI

struct OverviewCategoryView: View {
    let type: BudgetCategory
    let totalSpend: Double
    let totalFromBudget: Double
    let usingBorder: Bool?
    
    init(type: BudgetCategory, totalSpend: Double, totalFromBudget: Double, usingBorder: Bool? = true) {
        self.type = type
        self.totalSpend = totalSpend
        self.totalFromBudget = totalFromBudget
        self.usingBorder = usingBorder
    }
    var body: some View {
        ZStack {
            if let unwrapped = usingBorder {
                if unwrapped {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1)
                }
               
            }
           
            VStack(alignment: .leading) {
                switch type {
                case .income: Text("Income")
                case .needs: Text("Needs")
                case .save: Text("Save")
                case .wants: Text("Wants")
                }
                
                CustomProgressBar(progress: totalSpend / totalFromBudget)
                HStack(spacing: 5) {
                    Text(totalSpend, format: .number)
                    switch type {
                    case .income: Text("received")
                    case .needs: Text("spent")
                    case .save: Text("spent")
                    case .wants: Text("saved")
                    }
    
                    
                    Spacer()
                   
                    Text(totalFromBudget, format: .number)
                    switch type {
                    case .income: Text("more expected")
                    case .needs: Text("total")
                    case .save: Text("total")
                    case .wants: Text("total")
                    }
                }
                .font(.caption)
            }
            .padding()
        }
        .listRowSeparator(.hidden, edges: .all)
    }
}

#Preview {
    OverviewCategoryView(type: .wants, totalSpend: 500, totalFromBudget: 1000)
}
