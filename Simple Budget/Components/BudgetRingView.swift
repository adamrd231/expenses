//
//  BudgetRingView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/5/24.
//

import SwiftUI

struct BudgetRingView: View {
    let progress: Double
    let lineWidth: Double
    let ringColor: Color
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .strokeBorder(Color.theme.background, lineWidth: lineWidth)
            
            ZStack(alignment: .top) {
                Circle()
                    .trim(from: 0, to: 1 - progress.truncatingRemainder(dividingBy: 1))
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(
                                colors: progress <= 1 ? [ringColor, ringColor] : [.red, .orange]
                            ),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .padding(lineWidth / 2)
                    .rotationEffect(.degrees(-90))
                Circle()
                    .frame(width: lineWidth, height: lineWidth)
                    .foregroundColor(progress <= 1 ? ringColor : .red)
            }
            
       
        }
    }
}

#Preview {
    BudgetRingView(
        progress: 1.24,
        lineWidth: 50,
        ringColor: .blue
    )
}
