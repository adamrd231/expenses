//
//  CustoPageControl.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/22/24.
//

import SwiftUI

struct CustomPageControl: View {
    let numberOfPages: Int
    @Binding var currentPage: Int?
    
    init(numberOfPages: Int, currentPage: Binding<Int?> = Binding.constant(nil)) {
        self.numberOfPages = numberOfPages
        self._currentPage = currentPage
    }
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Image(systemName: index == currentPage ? "circle.fill" : "circle")
                    
            }
        }
        .padding()
    }
}


struct CustomPageControl_Previews: PreviewProvider {
    static var previews: some View {
        CustomPageControl(numberOfPages: 6, currentPage: .constant(1))
    }
}
