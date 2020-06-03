//
//  FDCDayMeals.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 28/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation


class FDCDayMeals: ObservableObject {
    
    @Published var breakfastFoods: [FDCSelectedFood] = []
    @Published var lunchFoods: [FDCSelectedFood] = []
    @Published var dinnerFoods: [FDCSelectedFood] = []
    @Published var snacksFoods: [FDCSelectedFood] = []
    
    
    let carbsLimit = 360
    let proteinLimit = 145
    let fatLimit = 95
    let caloriesLimit = 2300.0
    
    
    func getFoodNames(forMealType mealType: MealType) -> String {
        
        let foods:[FDCSelectedFood]
        switch mealType {
        case .breakfast:
            foods = breakfastFoods
        case .lunch:
            foods = lunchFoods
        case .dinner:
            foods = dinnerFoods
        case .snacks:
            foods = snacksFoods
        }
        
        var string = ""
        for food in foods {
            string += "\(food.food.name), "
        }
        
        return string
    }
    
    func getFoods(forMealType mealType:MealType) -> [FDCSelectedFood] {
        switch mealType {
        case .breakfast:
            return self.breakfastFoods
        case .lunch:
             return self.lunchFoods
        case .dinner:
             return self.dinnerFoods
        case .snacks:
            return self.snacksFoods
        }
    }
    
    func getMealName(forMealType mealType:MealType) -> String {
        switch mealType {
        case .breakfast:
            return "Breakfast"
        case .lunch:
            return "Lunch"
        case .dinner:
            return "Dinner"
        case .snacks:
           return "Snacks"
        }
    }
    
    func calculateCalories(forMealType mealType:MealType) -> String{
        
        let foods:[FDCSelectedFood]
        switch mealType {
        case .breakfast:
            foods = breakfastFoods
        case .lunch:
            foods = lunchFoods
        case .dinner:
            foods = dinnerFoods
        case .snacks:
            foods = snacksFoods
        }
        
        var totalCal = 0
        for food in foods{
            totalCal += Int(food.portion.calories) 
        }
        
        return "\(totalCal)"
        
    }
    
    
    func calculateEatenCalPercentage() -> Int {
        let eatenCal = self.calculateTotalCalories()

        let percentage = Double(eatenCal) / caloriesLimit
        
        let final = percentage * 100
        return lround(final)
    }
    
    func calculateTotalCalories() -> Int {
        let allFoods = breakfastFoods + lunchFoods + dinnerFoods + snacksFoods
        
        var totalCal = 0
        for food in allFoods{
            totalCal += Int(food.portion.calories) 
        }
        
        return totalCal
        
    }
    
    
    func calculateTotalCarbs() -> Int {
        
        let allFoods = breakfastFoods + lunchFoods + dinnerFoods + snacksFoods
        
        var totalCarbs = 0.0
        for food in allFoods{
            totalCarbs += Double(food.portion.carbs)
        }
        
        return lround(totalCarbs)
    }
    
  
    func calculateCarbsLeft() -> String {
        
        let allFoods = breakfastFoods + lunchFoods + dinnerFoods + snacksFoods
        
        var totalCarbs = 0.0
        for food in allFoods{
            totalCarbs += Double(food.portion.carbs)
        }
        
        let left = carbsLimit - lround(totalCarbs)
        if  left > 0 {
            return "\(left)g left"
        }else{
            return "\(abs(left))g over"
        }
        
    }
    
    func calculateTotalProtein() -> Int {
        let allFoods = breakfastFoods + lunchFoods + dinnerFoods + snacksFoods
        
        var totalProtein = 0.0
        for food in allFoods{
            totalProtein += Double(food.portion.protein)
        }
        
        return lround(totalProtein)
    }
    
    
    func calculateProteinLeft() -> String {
        let allFoods = breakfastFoods + lunchFoods + dinnerFoods + snacksFoods
        
        var totalProtein = 0
        for food in allFoods{
            totalProtein += food.portion.protein
        }
        
        let left = proteinLimit - totalProtein
        
        if  left > 0 {
            return "\(left)g left"
        }else{
            return "\(abs(left))g over"
        }
        
        //return "\(Int(round(totalProtein)))"
    }
    
    func calculateTotalFat() -> Int {
        let allFoods = breakfastFoods + lunchFoods + dinnerFoods + snacksFoods
        
        var totalFat = 0.0
        for food in allFoods{
            totalFat += Double(food.portion.fat)
        }
        
        return lround(totalFat)
    }
    
    
    func calculateFatLeft() -> String {
        let allFoods = breakfastFoods + lunchFoods + dinnerFoods + snacksFoods
        
        var totalFat = 0.0
        for food in allFoods{
            totalFat += Double(food.portion.fat) 
        }
        
        let left = fatLimit - lround(totalFat)
        
        if  left > 0 {
            return "\(left)g left"
        }else{
            return "\(abs(left))g over"
        }
    }
    
}

enum MealType: CaseIterable {
    case breakfast
    case lunch
    case dinner
    case snacks
}

enum NutritionFact{
    case carbs
    case fat
    case protein
}
