//
//  CustomProgressBar.swift
//  SimpleBudget
//
//  Created by Jaymeen Unadkat on 17/03/24.
//

import SwiftUI

///`CustomProgressBar`
struct CustomProgressBar: View {
    let progress: Double
    var cornerRadius: Double = 9
    var backgroundColor: Color = .AppThemeGrayColor
    var foregroundColor: Color = .AppBlack
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: 3)
                            .frame(width: geometry.size.width)
                            .foregroundColor(backgroundColor)
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .opacity(0.3)
                            .foregroundColor(.clear)
                        
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundColor(backgroundColor)
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .foregroundStyle(backgroundColor.opacity(0.3))
                    }
                    .frame(width: geometry.size.width * progress)
                }
                .frame(
                    height: geometry.size.height
                )
            }
        }
        .frame(height: 50)
    }
}


#Preview {
    CustomProgressBar(progress: 0.2)
        .preferredColorScheme(.dark)
}
