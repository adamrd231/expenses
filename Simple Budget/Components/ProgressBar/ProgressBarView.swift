//
//  ProgressBarView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/21/24.
//

import SwiftUI

struct ProgressBarView: View {
    @State var progress: Double
    @State var startPoint: Double = 0
    var cornerRadius: Double = 25
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: geometry.size.width)
                        .foregroundColor(Color.theme.progressBarBackground)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(Color.theme.progressBarBackground, lineWidth: 5)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.theme.green)
                        
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.theme.green2, Color.theme.green],
                                startPoint: .bottomTrailing,
                                endPoint: .topLeading
                            )
                        )
                        
                }
                .frame(width: progress.isNaN ? 0 : geometry.size.width * startPoint)
                .animation(.linear, value: startPoint)
            }
            .onAppear(perform: {
                self.startPoint = progress
            })
        }
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
