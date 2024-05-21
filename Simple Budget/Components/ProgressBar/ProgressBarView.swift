//
//  ProgressBarView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/21/24.
//

import SwiftUI

struct ProgressBarView: View {
    let currentSpend: Double
    let totalBudget: Double

    let alignment: Alignment?
    var cornerRadius: Double = 10
    
    init(currentSpend: Double, totalBudget: Double, alignment: Alignment? = .leading) {
        self.currentSpend = currentSpend
        self.totalBudget = totalBudget
        self.alignment = alignment
    }
    
    func getProgressWidth(geoWidth: Double) -> Double {
        if (currentSpend / totalBudget).isNaN {
            return 0
        } else if (currentSpend / totalBudget) == 0 {
            return 0
        } else if (currentSpend / totalBudget) >= 1 {
            return geoWidth
        } else {
            return (currentSpend / totalBudget) * geoWidth
        }
        
    }
    
    var body: some View {
        VStack(spacing: 5) {
            GeometryReader { geometry in
                ZStack(alignment: alignment ?? .leading) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: geometry.size.width)
                        .foregroundColor(Color.theme.progressBarBackground)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        (currentSpend / totalBudget) > 1 ? Color.orange : Color.theme.green2,
                                        (currentSpend / totalBudget) > 1 ? Color.theme.red : Color.theme.green],
                                    startPoint: .bottomTrailing,
                                    endPoint: .topLeading
                                )
                            )
                        Text(currentSpend, format: .currency(code: "USD"))
                            .font(.smallCaps(.caption2)())
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            
                    }
                    .frame(width: getProgressWidth(geoWidth: geometry.size.width))
                    .animation(.linear, value: (currentSpend / totalBudget))
                }
            }
            .frame(height: 30)
            
            HStack(spacing: 5) {
                Spacer()
                Text("Total:")
                Text(totalBudget, format: .currency(code: "USD"))
            }
            .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
        }
    }
}




struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section("Progress Bar") {
                ProgressBarView(currentSpend: 100, totalBudget: 1000)
            }
        }
        .preferredColorScheme(.dark)
       
    }
}
