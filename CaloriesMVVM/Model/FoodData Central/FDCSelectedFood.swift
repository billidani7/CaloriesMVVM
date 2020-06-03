//
//  FDCSelectedFood.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 28/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation


struct FDCSelectedFood: Identifiable, Hashable {
    
    var id = UUID()
    var food: FDCFoodDetail
    var portion: NutritionPortion
    
    static func == (lhs: FDCSelectedFood, rhs: FDCSelectedFood) -> Bool {
        lhs.id == rhs.id
    }
}


struct NutritionPortion: Hashable {
    var carbs: Int
    var fat: Int
    var protein: Int
    var calories: Int
    var portionDescription: String
    var gramWeight: Int
    
    init(carbs: Int,
         fat: Int,
         protein: Int,
         calories: Int,
         portionDescription: String,
         gramWeight: Int ) {
        
        self.carbs = carbs
        self.fat = fat
        self.protein = protein
        self.calories = calories
        self.portionDescription = portionDescription
        self.gramWeight = gramWeight
    }
    
    init() {
        self.init(carbs: 0, fat: 0, protein: 0, calories: 0, portionDescription: "", gramWeight: 0)
    }
    
}
