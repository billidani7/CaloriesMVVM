//
//  FDCFoodDetail.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 27/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation

struct FDCFoodDetail: Codable, Hashable  {
    let foodClass: String?
    let name: String
    let foodNutrients: [FoodDetailNutrient]
    //let nutrientConversionFactors: [NutrientConversionFactor]
    let isHistoricalReference: Bool
    let ndbNumber, fdcID: Int
    let dataType, publicationDate: String
    let foodPortions: [FoodPortion]
    let foodCategory: Food

    enum CodingKeys: String, CodingKey {
        case foodClass
        case name = "description"
        case foodNutrients, isHistoricalReference, ndbNumber
        case fdcID = "fdcId"
        case dataType, publicationDate, foodPortions, foodCategory
    }
}

// MARK: - Food
struct Food: Codable, Hashable  {
    static func == (lhs: Food, rhs: Food) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let code, foodDescription: String
    //let foodNutrientSource: Food?

    enum CodingKeys: String, CodingKey {
        case id, code
        case foodDescription = "description"
        //case foodNutrientSource
    }

}

// MARK: - FoodNutrient
struct FoodDetailNutrient: Codable, Hashable  {
    static func == (lhs: FoodDetailNutrient, rhs: FoodDetailNutrient) -> Bool {
        lhs.id == rhs.id
    }
    
    let type: TypeEnum
    let nutrient: Nutrient
    let id, dataPoints: Int?
    let amount: Double?
    //let foodNutrientDerivation: Food?
}

// MARK: - Nutrient
struct Nutrient: Codable, Hashable  {
    let id: Int
    let number, name: String
    let rank: Int
    let unitName: String
}



enum TypeEnum: String, Codable {
    case foodNutrient = "FoodNutrient"
}

// MARK: - FoodPortion
struct FoodPortion: Codable, Hashable  {
    static func == (lhs: FoodPortion, rhs: FoodPortion) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let measureUnit: MeasureUnit
    let modifier: String
    let gramWeight: Double
    let amount: Double?
    let sequenceNumber: Int
    let dataPoints: Int?
}

// MARK: - MeasureUnit
struct MeasureUnit: Codable, Hashable {
    let id: Int
    let name, abbreviation: String
}

// MARK: - NutrientConversionFactor
struct NutrientConversionFactor: Codable {
    let type: String
    let id: Int
    let value: Double?
    let name: String?
    let proteinValue: Int?
    let fatValue, carbohydrateValue: Double?
}

