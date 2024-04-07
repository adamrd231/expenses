//
//  BottomRowView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/7/24.
//

import SwiftUI

struct BottomRowView: View {
    let category: String
    let percent: Double
    let color: Color
    var body: some View {
        HStack(spacing: 12) {
            VStack(spacing: 3) {
                Text(category)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.secondaryText)
                    .textCase(.uppercase)
                Rectangle()
                    .frame(height: 5)
                    .foregroundStyle(color)
            }
            .fixedSize()
            
            HStack(spacing: 4) {
                Text(percent, format: .percent)
                Text("Remaining")
            }
            .fontDesign(.monospaced)
            .font(.callout)
        }
    }
}

#Preview {
    BottomRowView(
        category: "Needs",
        percent: 0.1,
        color: .blue
    )
}
