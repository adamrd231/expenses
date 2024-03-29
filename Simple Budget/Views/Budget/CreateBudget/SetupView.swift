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

struct BorderedStringTextField: View {
    @Binding var string: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(.lightGray).opacity(0.2))

            TextField("", text: $string)
                .padding(5)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 125)
        .fixedSize()
   
    }
}

struct BorderedDoubleTextField: View {
    @Binding var value: Double
    let numberFormatter  = NumberFormatter()
    
    init(value: Binding<Double>) {
        self._value = value
        numberFormatter.numberStyle = .decimal
        
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(.lightGray).opacity(0.2))

            TextField("", value: $value, formatter: numberFormatter)
                .padding(5)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 125)
        .fixedSize()
   
    }
}

struct SetupView: View {
    @ObservedObject var vm: BudgetsViewModel
    
    var body: some View {
        List {
            VStack {
                HStack {
                    Text("Start Date")
                    DatePicker("", selection: $vm.budgetModel.start, displayedComponents: .date)
                }
                HStack {
                    Text("End Date")
                    DatePicker("", selection: $vm.budgetModel.end, displayedComponents: .date)
                }
                HStack {
                    Text("Currency")
                    Spacer()
                    BorderedStringTextField(string: $vm.budgetModel.currencySymbol)
           
                }
                HStack {
                    Text("Start Balance")
                    Spacer()
                    Text(vm.budgetModel.currencySymbol)
                    BorderedDoubleTextField(value: $vm.budgetModel.startBalance)


                }
            }
            .listStyle(.plain)

        }
    }
}

#Preview {
    SetupView(vm: BudgetsViewModel())
}
