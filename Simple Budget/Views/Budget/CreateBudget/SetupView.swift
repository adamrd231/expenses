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
    @ObservedObject var vm: BudgetsViewModel
    @Binding var budget: Budget
    
    var body: some View {
        List {
            Section(header: Text("Date range")) {
                DateRangeRow(title: "Start", date: $vm.budgetModel.start)
                DateRangeRow(title: "End", date: $vm.budgetModel.end)
                Text(budget.needsBudgetPercentage, format: .percent)
            }
        }
    }
}

#Preview {
    SetupView(vm: BudgetsViewModel(), budget: .constant(Budget()))
}

struct DateRangeRow: View {
    let title: String
    @Binding var date: Date
    var body: some View {
        HStack {
            Text(title)
            DatePicker("", selection: $date, displayedComponents: .date)
        }
        .padding(10)
    }
}
