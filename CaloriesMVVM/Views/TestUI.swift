////
////  TestUI.swift
//// CaloriesMVVM
////
////  Created by Vasilis Daningelis on 2/6/20.
////  Copyright © 2020 Vasilis Daningelis. All rights reserved.
////
//
//import SwiftUI
//
//struct TestUI: View {
//    
//    @ObservedObject var viewModel: AddMealViewModel
//    
//    var body: some View {
//        
//        VStack {
//            TextField("Search food", text: $viewModel.searchText)
//            
//            List(viewModel.foodResults) { food in
//                Text(food.name)
//            }
//        }
//        
//        
//    }
//}
//
//struct TestUI_Previews: PreviewProvider {
//    static var previews: some View {
//        TestUI(viewModel: AddMealViewModel(mealType: .breakfast))
//        .environmentObject(FDCDayMeals())
//
//    }
//}
