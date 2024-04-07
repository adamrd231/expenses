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
    var body: some View {
        HStack(spacing: 10) {
            Text(category)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.secondaryText)
                .textCase(.uppercase)
            HStack(spacing: 5) {
                Text(percent, format: .percent)
                Text("Remaining")
            }
        }
    }
}

#Preview {
    BottomRowView(
        category: "Needs",
        percent: 0.1
    )
}
