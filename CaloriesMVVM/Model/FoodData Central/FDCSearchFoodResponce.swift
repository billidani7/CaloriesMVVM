//
//  FDCSearchFoodResponce.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 27/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation

// MARK: - ConfigData
struct FDCSearchFoodResponce: Codable {
    let foodSearchCriteria: FoodSearchCriteria?
    let totalHits, currentPage, totalPages: Int
    let foods: [FDCFood]
    
        init(foods: [FDCFood]) {
            self.foods = foods
            self.totalHits = 0
            self.currentPage = 0
            self.totalPages = 0
            self.foodSearchCriteria = nil
        }
}

// MARK: - FoodSearchCriteria
struct FoodSearchCriteria: Codable {
    let dataType: [DataType]
    let query, generalSearchInput: String
    let pageNumber: Int
    let sortBy, sortOrder: String?
    let requireAllWords: Bool
}

enum DataType: String, Codable {
    case srLegacy = "SR Legacy"
}

// MARK: - Food
struct FDCFood: Codable, Hashable {
    static func == (lhs: FDCFood, rhs: FDCFood) -> Bool {
        lhs.fdcID == rhs.fdcID
    }
    
    let fdcID: Int
    let foodDescription: String
    let dataType: DataType
    let ndbNumber, publishedDate: String
    let foodNutrients: [FoodNutrient]
    let allHighlightFields: String
    let score: Double

    enum CodingKeys: String, CodingKey {
        case fdcID = "fdcId"
        case foodDescription = "description"
        case dataType, ndbNumber, publishedDate, foodNutrients, allHighlightFields, score
    }
}

// MARK: - FoodNutrient
struct FoodNutrient: Codable, Hashable {
    let nutrientID: Int
    let nutrientName, nutrientNumber: String
    let unitName: UnitName
    let value: Double
    let derivationCode: String?
    let derivationDescription: String?

    enum CodingKeys: String, CodingKey {
        case nutrientID = "nutrientId"
        case nutrientName, nutrientNumber, unitName, value, derivationCode, derivationDescription
    }
}


enum UnitName: String, Codable {
    case g = "G"
    case iu = "IU"
    case kJ = "kJ"
    case kcal = "KCAL"
    case mg = "MG"
    case ug = "UG"
}

