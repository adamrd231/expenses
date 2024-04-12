//
//  SetupView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/21/24.
//

import SwiftUI

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

struct SetupView: View {
    @Binding var budget: Budget
    
    var body: some View {
        List {
            Section(header: Text("Goals")) {
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
                
            }
            Section(header: Text("Date range")) {
                DateRangeRow(title: "Start", date: $budget.start)
                DateRangeRow(title: "End", date: $budget.end)
            }
            
        }
    }
}

#Preview {
    SetupView(budget: .constant(Budget()))
}

struct DateRangeRow: View {
    let title: String
    @Binding var date: Date
    var body: some View {
        HStack {
            Text(title)
            DatePicker("", selection: $date, displayedComponents: .date)
        }
        .padding(5)
    }
}
