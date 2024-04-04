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
            BreakdownSliderView(value: $newBudget.needsBudgetPercentage, type: .needs)
            BreakdownSliderView(value: $newBudget.wantsBudgetPercentage, type: .wants)
            BreakdownSliderView(value: $newBudget.saveBudgetPercentage, type: .save)
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

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

struct BreakdownSliderView: View {
    @Binding var value: Double
    let type: BudgetCategory
    var body: some View {
        VStack(alignment: .leading) {
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
