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
    let leftSide: Bool
    var cornerRadius: Double = 25
    
    func getProgressWidth(geoWidth: Double) -> Double {
        print("Startpoint \(startPoint)")
        if progress.isNaN {
            return 0
        } else if startPoint == 0 {
            return 0
        } else {
            return startPoint * geoWidth
        }
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: leftSide ? .leading : .trailing) {
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
                        .foregroundColor(progress == 0 ? Color.theme.red : Color.theme.green)
                        
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [progress == 0 ? Color.theme.red : Color.theme.green2, progress == 0 ? Color.theme.red : Color.theme.green],
                                startPoint: .bottomTrailing,
                                endPoint: .topLeading
                            )
                        )
                        
                }
                .frame(width: getProgressWidth(geoWidth: geometry.size.width))
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
                ProgressBarView(progress: 0.4, leftSide: true)
                ProgressBarView(progress: 0.4, leftSide: false)
            }
        }
        .preferredColorScheme(.dark)
       
    }
}
