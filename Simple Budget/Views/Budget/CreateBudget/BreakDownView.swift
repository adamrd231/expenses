//
//  BreakDownView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/21/24.
//

import SwiftUI

struct BreakDownView: View {
    @Binding var budget: Budget
    
    var body: some View {
        List {
            Section(header: Text("Planning"), footer: Text("Learn More")) {
                HStack {
                    Spacer()
                    VStack {
                        Text(budget.totalBudgetPercentage, format: .percent.precision(.fractionLength(0)))
                            .foregroundStyle(budget.totalBudgetPercentage > 1 ? .red : .primary)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Budget Total")
                    }
                    Spacer()
                }
                .padding(10)
                SliderView(value: $budget.needsBudgetPercentage, type: .needs)
                SliderView(value: $budget.wantsBudgetPercentage, type: .wants)
                SliderView(value: $budget.saveBudgetPercentage, type: .save)
                HStack {
                    Text("Reset budget values")
                    Spacer()
                    Button {
                        budget.needsBudgetPercentage = 0.5
                        budget.wantsBudgetPercentage = 0.3
                        budget.saveBudgetPercentage = 0.2
                    } label: {
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                    }
                }
                .padding(10)
            }
        }
    }
}

struct BreakDownView_Previews: PreviewProvider {
    static var previews: some View {
        BreakDownView(
            budget: .constant(dev.budget)
        )
    }
}

