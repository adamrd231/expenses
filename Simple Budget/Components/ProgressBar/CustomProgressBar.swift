import SwiftUI

struct CustomProgressBar: View {
    let startDate: Date
    let endDate: Date
    let currentSpend: Double
    let totalBudget: Double
    let type: BudgetCategory
    
    var progress: Double {
        currentSpend / totalBudget
    }
    
    var cornerRadius: Double = 25
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 5) {
                Text(type.description)
                    .bold()
                Spacer()
                Text(totalBudget, format: .currency(code: "USD"))
                    .foregroundStyle(Color.theme.secondaryText)
                Text("Total")
                    .foregroundStyle(Color.theme.secondaryText)
            }
            .font(.caption)
            
            ProgressBarView(progress: progress)
            HStack(spacing: 5) {
                Text(currentSpend, format: .currency(code: "USD"))
                Text(type == .income || type == .save ? "Earned" : "Spent")
                Spacer()

                Text(totalBudget * (1 - progress), format: .currency(code: "USD"))
                Text("Left")
            }
            .foregroundStyle(Color.theme.secondaryText)
            .font(.caption2)
        }
    }
}



struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(
            startDate: Date(),
            endDate: Date().addingTimeInterval(1000),
            currentSpend: 10,
            totalBudget: 100,
            type: .income
           )

    }
}
