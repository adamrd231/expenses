//
//  BreakDownView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/21/24.
//

import SwiftUI

struct BreakDownView: View {
    @State var newBudget: Budget

    var body: some View {
        VStack(spacing: 10) {
            Text(newBudget.totalBudgetPercentage, format: .percent.precision(.fractionLength(0)))
                .font(.title)
            VStack {
                Text("30/30/20 recommended")
                // TODO: Replace this link with the actual link we want here
                // Option: We could unwrap the optional instead of force unwrapping, this way it would hide the button if link is not valid instead of creashing the app
                Link(destination: URL(string: "https://www.google.com/?client=safari")!) {
                    Text("Tap here to learn why")
                }
            }
            .font(.caption)
            BreakdownSliderView(value: $newBudget.needsBudgetPercentage, type: .needs)
            BreakdownSliderView(value: $newBudget.wantsBudgetPercentage, type: .wants)
            BreakdownSliderView(value: $newBudget.saveBudgetPercentage, type: .save)
            Spacer()
        }
    }
}

#Preview {
    BreakDownView(newBudget: Budget())
}

struct BreakdownSliderView: View {
    @Binding var value: Double
    let type: BudgetCategory
    var body: some View {
        VStack {
            HStack {
                switch type {
                case .needs: Text("Needs")
                case .wants: Text("Wants")
                case .save: Text("Save")
                case .income: Text("Income")
                }
                
                Text(value, format: .percent.precision(.fractionLength(0)))
            }
            Slider(value: $value, in: 0...1)
        }
        .padding()
    }
}
