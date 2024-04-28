import SwiftUI

struct IndividualBudgetView: View {
    @State var budget: Budget
    var body: some View {
        List {
            
        }
    }
}


struct IndividualBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualBudgetView(budget: dev.budgetVM.budgetModel)
    }
}
