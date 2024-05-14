import SwiftUI

struct IndividualTransactionView: View {
    @State var transaction: TransactionEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Date").bold()
                Spacer()
                Text(transaction.date ?? Date(), format: .dateTime)
            }
            HStack {
                Text("Amount").bold()
                Spacer()
                Text(transaction.amount, format: .currency(code: "USD"))
            }
            HStack {
                Text("Category").bold()
                Spacer()
                Text(transaction.type ?? "")
            }
            HStack {
                Text("Type").bold()
                Spacer()
                Text(transaction.category ?? "")
            }
            VStack(alignment: .leading) {
                Text("Details").bold()
                Text(transaction.description)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle(transaction.category ?? "")
    }
}

struct IndividualTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IndividualTransactionView(transaction: TransactionEntity())
        }
        .navigationTitle("Transaction")
    }
}
