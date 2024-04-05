import SwiftUI

struct CustomProgressBar: View {
    let title: String
    let startDate: Date
    let endDate: Date
    let currentSpend: Double
    let totalBudget: Double
    
    var progress: Double {
        currentSpend / totalBudget
    }
    
    var cornerRadius: Double = 25
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(startDate, style: .date)
                        .bold()
                    Spacer()
                    HStack {
                        Text(totalBudget * (1 - progress), format: .currency(code: "USD"))
                        Text("Left")
                    }
                    .foregroundStyle(.secondary)
                }
                .font(.caption)
               
                ZStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .frame(width: geometry.size.width)
                            .foregroundColor(Color.theme.background.opacity(0.8))

                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundColor(Color.theme.background)
                            .blur(radius: 1)
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .foregroundStyle(Color.theme.blue)
                    }
                    .frame(width: (geometry.size.width * (1 - progress)))
                }
                .frame(
                    height: geometry.size.height * 0.75
                )
            }
        }
        .shadow(color: Color.theme.background, radius: 6)
        .frame(height: 50)
    }
}



struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(
            title: "Income",
            startDate: Date(),
            endDate: Date().addingTimeInterval(1000),
            currentSpend: 10,
            totalBudget: 100
           )

    }
}
