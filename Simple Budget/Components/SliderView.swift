//
//  SliderView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/4/24.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    let type: BudgetCategory
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                switch type {
                case .needs: Text("Needs")
                case .wants: Text("Wants")
                case .save: Text("Save")
                case .income: Text("Income")
                }
                Text(value,  format: .percent.precision(.fractionLength(0)))
            }
            .bold()
            Slider(value: $value, in: 0...1)
        }
        .padding(10)

    }
}


struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(value: .constant(0.1), type: .income)
    }
}
