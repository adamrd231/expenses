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
            HStack {
                Spacer()
                VStack {
                    Text(budget.budgetItems.map({ $0.budgetPercentage }).reduce(0, +), format: .percent.precision(.fractionLength(0)))
                        .foregroundStyle(budget.budgetItems.map({ $0.budgetPercentage }).reduce(0, +) > 1 ? .red : .primary)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Budget Total")
                }
                Spacer()
            }
            .padding(10)
            ForEach($budget.budgetItems, id: \.self) { $budgetItem in
                SliderView(value: $budgetItem.budgetPercentage, type: budgetItem.budgetCategory)
            }
            DateRangeRow(title: "Start Date", date: $budget.start)
            DateRangeRow(title: "End Date", date: $budget.end)
        }
        .listStyle(.plain)
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
    }
}
