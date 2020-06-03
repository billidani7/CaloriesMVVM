//
//  AddMealView.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 21/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import SwiftUI


struct AddMealView: View {
    @ObservedObject var viewModel: AddMealViewModel
    
    //@EnvironmentObject var partialSheetManager : PartialSheetManager
    @EnvironmentObject var dayMeals: FDCDayMeals
    //@State var searchText = ""
    
    var body: some View {
        
        //NavigationView {
            VStack {
                ZStack{
                    
                    RoundedCorners(tl: 0, tr: 0, bl: 64, br: 0, mealType: .breakfast)
                        .modifier(GradientModifier(mealType: viewModel.mealType))
                        .frame(height: 202)
                        .frame(maxWidth: .infinity)
                    
                    
                    SearchField(searchText: $viewModel.searchText)
                        .padding(.horizontal, 30)
                        .padding(.top, 50)
                    
                    Text("\(dayMeals.getMealName(forMealType: viewModel.mealType))")
                        .offset(y: -30)
                        .font(.Inter(size: 17, weight: .medium))
                        .foregroundColor(.white)
                }
                
                List {
                    //Text("Results")
                    self.foodRowsSection()
                    
                }
            
            }
            .background(Color(#colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9803921569, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
            .modifier(DismissingKeyboardOnSwipe())
            //.navigationBarHidden(true)
            .navigationBarTitle("")
    }
    
    private func foodRow(food: FDCFood) -> some View {
        
        return NavigationLink(destination:
            
            LazyView(FoodDetailView(viewModel: FoodDetailViewModel(foodId: food.fdcID , mealType: self.viewModel.mealType))),
                              
                              label: {
                                FoodItemRowView(food: food)
                              })
    }
    
    private func foodRowsSection() -> some View {
        Section {
            
            ForEach(viewModel.foodResults, id: \.self){ food in
                self.foodRow(food: food)
            }
        }
        
    }
}

struct SearchField: View {
    @Binding var searchText: String
    var placeholder: LocalizedStringKey = "Search..."

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(placeholder, text: $searchText)
                //.offset(y: 10)
                .accentColor(.gray)
                .frame(height: 30)
        }
        
        .foregroundColor(.gray)
        .padding(8)
        .background(Color.white)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.top, 40)
        .padding(2)
        
        
    }
}


struct FoodItemRowView: View {
        
    var food: FDCFood
    //var viewStore: ViewStore<SearchState, SearchAction>
    @State var isTapped = false
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(food.foodDescription)
                    .font(.Inter(size: 14, weight: .semibold))
            }
            
            Spacer()
            
            
        }
        .frame(height: 68)
        .padding(.leading,20)
        .listRowBackground(Color.white)
    }
}

struct AddMealView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddMealView(viewModel: AddMealViewModel(mealType: .breakfast))
            .environmentObject(FDCDayMeals())
    }
}
