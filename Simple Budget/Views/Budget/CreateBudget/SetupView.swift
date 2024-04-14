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
