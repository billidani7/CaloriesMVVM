//
//  Font.swift
//  CaloriesDemo
//
//  Created by Vasilis Daningelis on 19/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation
import SwiftUI

extension Font {
    public static func Inter(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        
        switch weight {
        case .bold:
            return Font.custom("Inter-Bold", size: size)
        case .regular:
            return Font.custom("Inter-Regular", size: size)
        case .semibold:
            return Font.custom("Inter-SemiBold", size: size)
        case .medium:
            return Font.custom("Inter-Medium", size: size)
        default:
            return Font.custom("Inter-Regular", size: size)
        }
        
    }
    
}
