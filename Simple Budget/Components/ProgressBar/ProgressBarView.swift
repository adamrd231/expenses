//
//  ProgressBarView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/21/24.
//

import SwiftUI

struct ProgressBarView: View {
    let progress: Double
    var cornerRadius: Double = 25
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: geometry.size.width)
                        .foregroundColor(Color.theme.background.opacity(0.85))
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(Color.theme.progressBarBackground, lineWidth: 5)
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
                .frame(width: geometry.size.width * progress)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section("Progress Bar") {
                ProgressBarView(progress: 0.4)
                ProgressBarView(progress: 0.4)
            }
        }
        .preferredColorScheme(.dark)
       
    }
}
