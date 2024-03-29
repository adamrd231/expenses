
//
//  ContentView.swift
//  GrafDemo
//
//  Created by APPLE on 14/03/24.
//

import SwiftUI
import Charts

struct Entry: Identifiable{
    let id = UUID()
    let title: String
    let items: [Item]
}

struct Item: Identifiable{
    let id = UUID()
    let value: Double
    let color: Color
}


struct GraphView: View {
    @ObservedObject var vm: BudgetsViewModel
    @Environment(\.dismiss) var dismiss
    let graphData:[Entry]
    
    var body: some View {
        VStack {
            Text("Summary")
                .font(.title.bold())
                
            ScrollView{
                GeometryReader { proxy in
                    VStack(spacing: 30) {
                        Text("Goal vs. Planned")
                        ForEach(graphData) { data in
                            HStack(spacing: 0){
                                Text(data.title)
                                    .bold()
                                    .frame(width: 70, alignment: .leading)
                                
                                let totalBudget = graphData[0].items.first?.value ?? 0
                                // Here we set the label width to 100, with 10 units of leading and trailing padding, resulting in a total width of 120.
                                
                                let totalBarWidth = proxy.size.width - 120
                                VStack(alignment: .leading){
                                   
                                    ForEach(0..<data.items.count, id: \.self) { index in
                                        let item = data.items[index]
                                        let barWidth = (totalBarWidth * item.value) / totalBudget
                                        let per = item.value / totalBudget
                                        
                                        BarView(item: item, barWidth: barWidth, totalBudget: totalBudget, per: per, firstIndex: data.title == "Budget")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.vertical)
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .frame(width: 4)
                            .padding(.leading, 66)
                    }
                }
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Button {
                vm.addBudgetItemToBudgetArray()
                dismiss()
                
            } label: {
                Text("Save Budget")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(
            vm: BudgetsViewModel(),
            graphData: [
                Entry(title: "Budget", items: [
                    Item(value: 4000, color: .black)
                ])
            ]
        )
    }
}

extension GraphView{
    
    private func BarView(item: Item, barWidth: Double, totalBudget: Double, per: Double, firstIndex: Bool) -> some View {
        HStack{
            Rectangle()
                .fill(item.color)
                .frame(width: barWidth, height: 50)
                .background(
                    Rectangle()
                        .stroke(lineWidth: 3)
                )
                .overlay(alignment: .center) {
                    if firstIndex {
                        Text(totalBudget, format: .number.precision(.fractionLength(2)))
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
            if firstIndex == false {
                HStack(spacing: 5) {
                    Text("$")
                    Text(item.value, format: .number.precision(.fractionLength(2)))
                    HStack(spacing: 1) {
                        Text("(")
                        Text(per, format: .percent.precision(.fractionLength(0)))
                        Text(")")
                    }
                    .opacity(0.66)
                   
                }
                .font(.callout)
                .fontWeight(.semibold)
            }
            
        }
    }
}
