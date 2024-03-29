//
//  BorderModifier.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct BorderModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 1)
            content
                .padding(5)
        }
        .frame(minHeight: 30)
        .fixedSize(horizontal: false, vertical: true)
    }
}
