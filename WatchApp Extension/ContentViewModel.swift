//
//  ContentViewModel.swift
//  WatchApp Extension
//
//  Created by Vasilis Daningelis on 20/6/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var protein = "0"
    @Published var carbs = "0"
    @Published var fat = "0"
    @Published var eatenCal = "0"
    
    @Published var proteinLeft = "145 left"
    @Published var carbsLeft = "360 left"
    @Published var fatLeft = "95 left"
    @Published var eatenCallPercentage = 0
    
    init() {
        
        // Install notification observer.
        //
        NotificationCenter.default.addObserver(
            self, selector: #selector(type(of: self).dataDidFlow(_:)),
            name: .dataDidFlow, object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // .dataDidFlow notification handler. Update the UI based on the command status.
    //
    @objc
    func dataDidFlow(_ notification: Notification) {
        guard let message = notification.object as? [String: Any] else { return }
        
        self.protein = "\(message[PayloadKey.protein] ?? 0)"
        self.carbs = "\(message[PayloadKey.carbs] ?? 0)"
        self.fat = "\(message[PayloadKey.fat] ?? 0)"
        self.eatenCal = "\(message[PayloadKey.eatenCal] ?? 0)"
        
        self.proteinLeft = "\(message[PayloadKey.proteinLeft] ?? "-")"
        self.carbsLeft = "\(message[PayloadKey.carbsLeft] ?? "-")"
        self.fatLeft = "\(message[PayloadKey.fatLeft] ?? "-")"
        self.eatenCallPercentage = message[PayloadKey.eatenCalPercentage] as? Int ?? 0
        
    }
}
