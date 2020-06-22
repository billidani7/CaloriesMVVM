//
//   AddMealViewModel.swift
// CaloriesMVVM
//
//  Created by Vasilis Daningelis on 21/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class AddMealViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var foodResults: [FDCFood] = []
    
    var mealType: MealType
    
    private var searchPublisher: AnyPublisher<FDCSearchFoodResponce, APIError>?
    
    private var searchCancellable: AnyCancellable? {
        willSet {
            searchCancellable?.cancel()
        }
    }
    
    private var disposables = Set<AnyCancellable>()
    
    init(mealType: MealType) {
        self.mealType = mealType
        
        $searchText
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: searchAction(forFood:))
            .store(in: &disposables)
    }
    
    
//    func searchAction(forFood query: String) {
//
//        searchPublisher = FDCClient.searchFoods(query: query)
//            .replaceError(with: FDCSearchFoodResponce(foods: []))
//            .eraseToAnyPublisher()
//
//        searchCancellable = searchPublisher?
//            .map{$0.foods}
//            .subscribe(on: DispatchQueue.global())
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.foodResults, on: self)
//
//    }
    
    func searchAction(forFood query: String) {
                
        searchCancellable = FDCClient
            .searchFoods(query: query)
            .replaceError(with: FDCSearchFoodResponce(foods: []))
            .map{$0.foods}
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .assign(to: \.foodResults, on: self)
                                

    }
    
}
