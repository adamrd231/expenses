//
//  OverviewModel.swift
//  SimpleBudget
//
//  Created by Jaymeen Unadkat on 17/03/24.
//

import Foundation

///`OverviewModel`
struct OverviewModel: Codable, Hashable, Equatable {
    let startDate: Date
    let endDate: Date
    
    let incomeReceived: Double
    let incomeExpected: Double
    
    let needsLeft: Double
    let needsSpent: Double
    
    let wantsLeft: Double
    let wantsSpent: Double
    
    let saveSaved: Double
    let saveLeft: Double
}
