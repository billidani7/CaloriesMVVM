//
//  Modifiers.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 28/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation
import SwiftUI

struct GradientModifier: ViewModifier {
    var mealType: MealType
    
    func body(content: Content) -> some View {
        
        content
            .foregroundColor(Color.clear)
            .background(LinearGradient(gradient: Gradient(colors: colorArray(mealType)), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
    func colorArray(_ mealType: MealType) -> [Color] {
        
        var colorTop: Color
        var colorBottom: Color
        
        switch mealType {
        case .breakfast:
            colorTop = Color(#colorLiteral(red: 0.9960784314, green: 0.7058823529, blue: 0.5921568627, alpha: 1))
            colorBottom = Color(#colorLiteral(red: 0.9764705882, green: 0.4235294118, blue: 0.4862745098, alpha: 1))
        case .lunch:
            colorTop = Color(#colorLiteral(red: 0.4901960784, green: 0.6, blue: 0.9254901961, alpha: 1))
            colorBottom = Color(#colorLiteral(red: 0.3529411765, green: 0.3647058824, blue: 0.8666666667, alpha: 1))
            
        case .dinner:
            colorTop = Color(#colorLiteral(red: 0.5333333333, green: 0.5529411765, blue: 0.9137254902, alpha: 1))
            colorBottom = Color(#colorLiteral(red: 0.1019607843, green: 0.05098039216, blue: 0.3647058824, alpha: 1))
        
        case .snacks:
            colorTop = Color(#colorLiteral(red: 1, green: 0.6745098039, blue: 0.7764705882, alpha: 1))
            colorBottom = Color(#colorLiteral(red: 1, green: 0.2862745098, blue: 0.5058823529, alpha: 1))
        }
        return [colorTop, colorBottom]
    }
}
