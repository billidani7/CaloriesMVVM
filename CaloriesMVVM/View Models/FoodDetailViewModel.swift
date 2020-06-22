//
//  FoodDetailViewModel.swift
// CaloriesMVVM
//
//  Created by Vasilis Daningelis on 27/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation
import Combine

class FoodDetailViewModel: ObservableObject {
    
    @Published var foodDetail: FDCFoodDetail?{
        didSet{
            updateSelectedPortion()
        }
        
    }
    var foodId: Int
    var mealType: MealType?
    
    var selectedPortion: NutritionPortion
    
    @Published var selectedIndex: Int = 0{
        didSet {
            updateSelectedPortion()
        }
    }
    
    private var detailPublisher: AnyPublisher<FDCFoodDetail, APIError>?
    private var detailCancellable: AnyCancellable? {
        willSet {
            detailCancellable?.cancel()
        }
    }
    
    init(foodId: Int, mealType: MealType?) {
        self.foodId = foodId
        self.mealType = mealType
        self.selectedPortion = NutritionPortion()
        
        getFoodDetail(withId: foodId)
        
        
    }
    
    func getFoodDetail(withId id: Int) {
        
        detailPublisher = FDCClient.getFoodDetail(id: id)
            .mapError{return $0}
            .eraseToAnyPublisher()
        
        detailCancellable = detailPublisher?
            .map{$0}
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  self.foodDetail = nil
                case .finished:
                  break
                }
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }

                self.foodDetail = result
            })
        
    }
    
    
    // MARK: - Helper Functions
    
    func getGramsForPortion() -> String {
        
        return "\(Int(foodDetail!.foodPortions[selectedIndex].gramWeight))g"
    }
    
    func getPortion() -> String {
        return "\(foodDetail!.foodPortions[selectedIndex].modifier)"
    }
    
    func updateSelectedPortion() {
        let selectedGrams = foodDetail!.foodPortions[selectedIndex].gramWeight
        
        let carbsFor100grams = foodDetail?.foodNutrients.first{ $0.nutrient.id == 1005 }?.amount ?? 0.0
        let selectedPortionCarbs = lround((carbsFor100grams  * selectedGrams) / 100)
        
        let proteinFor100grams = foodDetail?.foodNutrients.first{ $0.nutrient.id == 1003 }?.amount ?? 0.0
        let selectedPortionProtein = lround(( proteinFor100grams  * selectedGrams) / 100)
        
        let fatFor100grams = foodDetail?.foodNutrients.first{ $0.nutrient.id == 1004 }?.amount ?? 0.0
        let selectedPortionFat = lround((fatFor100grams  * selectedGrams) / 100)
        
        let calFor100grams = foodDetail?.foodNutrients.first{ $0.nutrient.id == 1008 }?.amount ?? 0.0
        let selectedPortionCal = lround((calFor100grams * selectedGrams) / 100)
        
        self.selectedPortion = NutritionPortion(
            carbs: selectedPortionCarbs,
            fat: selectedPortionFat,
            protein: selectedPortionProtein,
            calories: selectedPortionCal,
            portionDescription: foodDetail!.foodPortions[selectedIndex].modifier,
            gramWeight: Int(selectedGrams)
        )
        
    }
    
}
