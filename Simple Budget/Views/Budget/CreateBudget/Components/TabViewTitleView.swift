//
//  TabViewTitleView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct TabViewTitleView: View {
    let currentIndex: Int
    var body: some View {
        switch currentIndex {
        case 0: Text("% Breakdown").font(.largeTitle)
        case 1: Text("Setup").font(.largeTitle)
        case 2: Text("Income").font(.largeTitle)
        case 3: Text("Needs").font(.largeTitle)
        case 4: Text("Wants").font(.largeTitle)
        case 5: Text("Save").font(.largeTitle)
        default: Text("Summary").font(.largeTitle)
        }
    }
}

#Preview {
    TabViewTitleView(currentIndex: 0)
}
