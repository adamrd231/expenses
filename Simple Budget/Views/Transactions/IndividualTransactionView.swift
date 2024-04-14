import SwiftUI

struct IndividualTransactionView: View {
    @State var transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(transaction.name)
        }
    }
}

struct IndividualTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualTransactionView(transaction: dev.transaction)
    }
}
