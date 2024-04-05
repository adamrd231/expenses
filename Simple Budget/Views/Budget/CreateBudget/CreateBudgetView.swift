import SwiftUI

struct CreateBudgetView: View {
    @ObservedObject var vm: BudgetsViewModel
    @State var currentIndex: Int? = 0
  
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 0) {
                    BreakDownView(vm: vm)
                        .id(0)
                        .tag(0)
                        .containerRelativeFrame(.horizontal)
                    
                    SetupView(vm: vm)
                        .id(1)
                        .tag(1)
                        .containerRelativeFrame(.horizontal)

                    BudgetSetupComponentView(vm: vm, currentIndex: 2, budgetType: .income)
                        .id(2)
                        .tag(2)
                        .containerRelativeFrame(.horizontal)
                    
                    BudgetSetupComponentView(vm: vm, currentIndex: 3, budgetType: .needs)
                        .id(3)
                        .tag(3)
                        .containerRelativeFrame(.horizontal)
                    
                    BudgetSetupComponentView(vm: vm, currentIndex: 4, budgetType: .wants)
                        .id(4)
                        .tag(4)
                        .containerRelativeFrame(.horizontal)
                    
                    BudgetSetupComponentView(vm: vm, currentIndex: 5, budgetType: .save)
                        .id(5)
                        .tag(5)
                        .containerRelativeFrame(.horizontal)
                    
                    GraphView(vm: vm,
                    graphData: [
                        Entry(title: "Budget", items: [Item(value: vm.budgetModel.totalBudget, color: .black)]),
                        Entry(title: "Needs", items: [Item(value: vm.budgetModel.totalBudget * vm.budgetModel.needsBudgetPercentage, color: .gray), Item(value: vm.budgetModel.needBudgetTotal, color: .pink)]),
                        Entry(title: "Wants", items: [Item(value: vm.budgetModel.totalBudget * vm.budgetModel.wantsBudgetPercentage, color: .gray), Item(value: vm.budgetModel.wantsBudgetTotal, color: .orange)]),
                        Entry(title: "Save", items: [Item(value: vm.budgetModel.totalBudget * vm.budgetModel.saveBudgetPercentage, color: .gray), Item(value: vm.budgetModel.saveBudgetTotal, color: .blue)])
                    ]
                    )
                        .id(6)
                        .tag(6)
                        .containerRelativeFrame(.horizontal)
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $currentIndex)
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .navigationTitle("Setup")
        .toolbarTitleDisplayMode(.inline)
        CustomPageControl(numberOfPages: 7, currentPage: $currentIndex)
    }
    
}



struct CreateBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateBudgetView(vm: dev.budgetVM)
                .navigationTitle("Something")
        }
    }
}
