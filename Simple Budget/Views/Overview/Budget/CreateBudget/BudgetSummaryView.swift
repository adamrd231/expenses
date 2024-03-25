//
//  BudgetSummaryView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/24/24.
//

import SwiftUI

struct BudgetSummaryView: View {
    @ObservedObject var vm: BudgetsViewModel
    let currentIndex: Int
    var body: some View {
        VStack {
            Button("Create budget") {
                vm.addBudgetItemToBudgetArray()
            }
        }
    }
}

#Preview {
    BudgetSummaryView(vm: BudgetsViewModel(), currentIndex: 6)
}
