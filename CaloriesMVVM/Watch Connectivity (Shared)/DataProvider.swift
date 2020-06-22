//
//  DataProvider.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 20/6/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation

struct PayloadKey {
    static let protein = "protein"
    static let carbs = "carbs"
    static let fat = "fat"
    static let eatenCal = "eatenCal"
    
    
    static let proteinLeft = "proteinLeft"
    static let carbsLeft = "carbsLeft"
    static let fatLeft = "fatLeft"
    
    static let eatenCalPercentage = "eatenCalPercentage"
    

    
}

// Constants to identify the app group container used for Settings-Watch.bundle and access
// the information in Settings-Watch.bundle.
//
struct WatchSettings {
    static let sharedContainerID = "group.dani.calories" // Specify your group container ID here and
}

protocol DataProvider {
    var message: [String: Any] { get }
}

