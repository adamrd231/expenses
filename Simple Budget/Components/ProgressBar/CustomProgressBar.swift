import SwiftUI

struct CustomProgressBar: View {
    let currentSpend: Double
    let totalBudget: Double
    let type: BudgetCategory
    
    var progress: Double {
        if type == .needs || type == .wants {
            1 - (currentSpend / totalBudget)
        } else {
            currentSpend / totalBudget
        }
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
                Text("Budget")
                    .foregroundStyle(Color.theme.secondaryText)
            }
            .font(.caption)
            
            ProgressBarView(progress: progress, leftSide: type == .income || type == .save)
            HStack(spacing: 5) {
                Text(currentSpend, format: .currency(code: "USD"))
                Text(type == .income || type == .save ? "Earned" : "Spent")
                Spacer()
                   
                HStack(spacing: 5) {
                    if type == .needs || type == .wants {
                        Text(totalBudget * progress, format: .currency(code: "USD"))
                    } else {
                        Text(totalBudget * (1 - progress), format: .currency(code: "USD"))
                    }
                    Text(currentSpend > totalBudget ? "Over" : "Left")
                }
                .foregroundStyle(currentSpend > totalBudget ? Color.theme.red : Color.theme.secondaryText)
                
            }
            .foregroundStyle(Color.theme.secondaryText)
            .font(.caption2)
        }
    }
}



struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(
            currentSpend: 10,
            totalBudget: 100,
            type: .income
           )

    }
}
