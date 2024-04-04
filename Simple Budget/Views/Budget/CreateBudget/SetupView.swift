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
    var numberFormatter = NumberFormatter()
    init(vm: BudgetsViewModel) {
        self.vm = vm
        numberFormatter.numberStyle = .currency
    }
    
    var body: some View {
        VStack {
            Text("Range")
                .font(.largeTitle)
            List {
                HStack {
                    Text("Start Date")
                    DatePicker("", selection: $vm.budgetModel.start, displayedComponents: .date)
                }
                HStack {
                    Text("End Date")
                    DatePicker("", selection: $vm.budgetModel.end, displayedComponents: .date)
                }
                HStack {
                    Text("Start Balance")
                    Spacer()
                    TextField("", value: $vm.budgetModel.startBalance, formatter: numberFormatter)
                        .fixedSize()
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    SetupView(vm: BudgetsViewModel())
}
