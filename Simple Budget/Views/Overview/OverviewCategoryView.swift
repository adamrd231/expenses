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
            CustomProgressBar(
                title: type.description,
                startDate: Date(),
                endDate: Date().addingTimeInterval(1000),
                currentSpend: totalSpend,
                totalBudget: totalFromBudget
            )
        }
        .listRowSeparator(.hidden, edges: .all)
    }
}

#Preview {
    OverviewCategoryView(type: .wants, totalSpend: 500, totalFromBudget: 1000)
}
