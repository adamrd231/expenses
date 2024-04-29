import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    @State var width: CGFloat = 0
    let type: BudgetCategory
    var body: some View {
        HStack(spacing: 10) {
            Text(value,  format: .percent.precision(.fractionLength(0)))
                    .offset(x: value)
            Slider(value: $value, in: 0...1)
                .tint(Color.theme.green)
           
        }
    }
}


struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(value: .constant(0.1), type: .income)
    }
}
