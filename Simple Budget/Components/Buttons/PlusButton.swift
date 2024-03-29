//
//  PlusButton.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct PlusButton: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
        }
    }
}

#Preview {
    PlusButton(action: {} )
}
