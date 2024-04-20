import SwiftUI

struct CustomProgressBar: View {
    let title: String
    let startDate: Date
    let endDate: Date
    let currentSpend: Double
    let totalBudget: Double
    let isShrinking: Bool
    
    var progress: Double {
        currentSpend / totalBudget
    }
    
    var cornerRadius: Double = 25
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(title)
                    .bold()
                Spacer()
                HStack {
                    Text(totalBudget * (1 - progress), format: .currency(code: "USD"))
                    Text("Left")
                }
                .foregroundStyle(Color.theme.secondaryText)
            }
            .font(.caption)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .frame(width: geometry.size.width)
                            .foregroundColor(Color.theme.background.opacity(0.85))
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(Color.theme.background, lineWidth: 5)
                            .blur(radius: 3)

                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundColor(Color.theme.green)
            
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.green, Color.theme.green],
                                    startPoint: .bottomTrailing,
                                    endPoint: .topLeading
                                )
                            )
                    }
                    .frame(width: isShrinking ? (geometry.size.width * (1 - progress)) : geometry.size.width * progress)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            HStack {
                Text(startDate, style: .date)
                    .bold()
                Spacer()
                Text(endDate, style: .date)
                    .bold()
            }
            .foregroundStyle(Color.theme.secondaryText)
            .font(.caption2)
        }
    }
}



struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(
            title: "Income",
            startDate: Date(),
            endDate: Date().addingTimeInterval(1000),
            currentSpend: 10,
            totalBudget: 100,
            isShrinking: true
           )

    }
}
