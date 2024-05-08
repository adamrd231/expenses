import SwiftUI

struct TransactionTableviewView: View {
    let index: Int
    let transaction: Transaction
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.theme.lightBackground)
                .shadow(color: Color.theme.background, radius: 10)
            HStack {
                Text(index, format: .number).font(.caption)
                VStack(alignment: .leading) {
                    HStack {
                        Text(transaction.category.description)
                            .bold()
                        HStack(spacing: 0) {
                            Text("(")
                            Text(transaction.type.name)
                            Text(")")
                        }
                        .font(.caption)
                       .fontWeight(.light)
                    }
                   
                    Text(transaction.date, style: .date)
                    .font(.caption)
                    .foregroundStyle(Color.theme.secondaryText)
                    
                }
                Spacer()
            
                Text(transaction.amount, format: .currency(code: "USD"))
                    .foregroundStyle(transaction.category == .income ? Color.theme.green : Color.theme.red)
            }
            .padding(5)
            .padding(.horizontal)
        }
        .font(.callout)
    }
}

#Preview {
    NavigationLink {
        Text("Placeholder")
    } label: {
        TransactionTableviewView(index: 1, transaction: Transaction(data: Date(), amount: 100, category: .needs, type: BudgetName(name: "Reeds landing lawn"), description: "The description for things"))
    }
}
