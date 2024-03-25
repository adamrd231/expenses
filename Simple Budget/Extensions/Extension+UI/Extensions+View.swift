//
//  Extensions+View.swift
//  SimpleBudget
//
//  Created by Jaymeen Unadkat on 17/03/24.
//

import Foundation
import SwiftUI

/// `applyBorder` to a View
extension View {
    func applyBorder(borderColor: Color = .AppBlack, cornerRadius: Double, width: Double = 1.0) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: width)
            )
            .padding(.horizontal, 1)
    }
}

///`markUnderline` Modifier
extension View {
    func markUnderline(color: Color, offset: Double = -2.0, height: Double = 1.0) -> some View {
        self
            .overlay(
                Rectangle()
                    .fill(color)
                    .frame(height: height)
                    .offset(y: offset)
                , alignment: .bottom
            )
    }
}
