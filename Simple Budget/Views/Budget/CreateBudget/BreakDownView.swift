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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Budget Total")
                Spacer()
                Text(newBudget.totalBudgetPercentage, format: .percent.precision(.fractionLength(0)))
                   
            }
            .font(.title3)
           
            VStack(alignment: .leading) {
                Text("30/30/20 recommended")
                // TODO: Replace this link with the actual link we want here
                // Option: We could unwrap the optional instead of force unwrapping, this way it would hide the button if link is not valid instead of creashing the app
                Link(destination: URL(string: "https://www.google.com/?client=safari")!) {
                    Text("Tap here to learn why")
                }
            }
            .font(.caption)
            SliderView(value: $newBudget.needsBudgetPercentage, type: .needs)
            SliderView(value: $newBudget.wantsBudgetPercentage, type: .wants)
            SliderView(value: $newBudget.saveBudgetPercentage, type: .save)
            Spacer()
        }
        .padding()
    }
}

struct BreakDownView_Previews: PreviewProvider {
    static var previews: some View {
        BreakDownView(newBudget: dev.budgetVM.budgetModel)
    }
}

