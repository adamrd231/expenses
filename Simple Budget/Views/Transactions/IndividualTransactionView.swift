import SwiftUI

struct IndividualTransactionView: View {
    @State var transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Date").bold()
                Spacer()
                Text(transaction.date, format: .dateTime)
            }
            HStack {
                Text("Amount").bold()
                Spacer()
                Text(transaction.amount, format: .currency(code: "USD"))
            }
            HStack {
                Text("Category").bold()
                Spacer()
                Text(transaction.type.name)
            }
            HStack {
                Text("Type").bold()
                Spacer()
                Text(transaction.category.description)
            }
            VStack(alignment: .leading) {
                Text("Details").bold()
                Text(transaction.description)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle(transaction.name)
    }
}

struct IndividualTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IndividualTransactionView(transaction: dev.transaction)
        }
        .navigationTitle("Transaction")
    }
}
