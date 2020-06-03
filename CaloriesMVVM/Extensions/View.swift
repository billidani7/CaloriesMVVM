//
//  View.swift
//  CaloriesDemo
//
//  Created by Vasilis Daningelis on 20/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation
import SwiftUI


extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
