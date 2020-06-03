//
//  FDCFoodDetailView.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 27/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import SwiftUI

struct FoodDetailView: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var viewModel: FoodDetailViewModel
    
    @EnvironmentObject var dayMeals: FDCDayMeals

    
    var body: some View {
    
        
        VStack(alignment: .center, spacing: 10) {
            Text("\(viewModel.foodDetail?.name ?? "")")
                .multilineTextAlignment(.center)
                .font(.Inter(size: 20, weight: .medium))
            
            
            if viewModel.foodDetail?.foodPortions != nil {
                // VStack {
                Picker(selection: $viewModel.selectedIndex, label: EmptyView()) {
                    ForEach(0..<viewModel.foodDetail!.foodPortions.count){ index in
                        
                        Text("\(self.viewModel.foodDetail!.foodPortions[index].modifier)")
                        //.multilineTextAlignment(.center)
                        
                        
                    }
                }
                .labelsHidden()
                Text("Serving size: \(viewModel.getPortion())")
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                    .padding(.horizontal, 10)
                
                Text("\(viewModel.getGramsForPortion() )")
                    .multilineTextAlignment(.trailing)
                    //.padding(.vertical, 5)
                    .frame(width: 85, height: 44)
                    .padding(.trailing, 14)
                    .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)), lineWidth: 1))
                //.padding(.top, 10)
                
                HStack(spacing: 15) {
                    VStack {
                        Text("Calories")
                            .font(.Inter(size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                        
                        Text("\(viewModel.selectedPortion.calories)")
                            .font(.Inter(size: 16))
                    }
                    
                    VStack {
                        Text("Carbs")
                            .font(.Inter(size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                        
                        Text("\(viewModel.selectedPortion.carbs)")
                            .font(.Inter(size: 16))
                    }
                    
                    VStack {
                        Text("Protein")
                            .font(.Inter(size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                        
                        Text("\(viewModel.selectedPortion.protein)")
                            .font(.Inter(size: 16))
                    }
                    
                    VStack {
                        Text("Fat")
                            .font(.Inter(size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                        
                        Text("\(viewModel.selectedPortion.fat)")
                            .font(.Inter(size: 16))
                    }
                }
                .padding(.top, 10)
   
            }
            
            
            
            Spacer()
            
            Button(action: {
                print("Action")
                
                let selectedFood = FDCSelectedFood(food: self.viewModel.foodDetail!,
                                                   portion: self.viewModel.selectedPortion)

                switch self.viewModel.mealType {
                case .breakfast:
                    self.dayMeals.breakfastFoods.append(selectedFood)
                case .lunch:
                    self.dayMeals.lunchFoods.append(selectedFood)
                case .dinner:
                    self.dayMeals.dinnerFoods.append(selectedFood)
                case .snacks:
                    self.dayMeals.snacksFoods.append(selectedFood)
                case .none:
                    break
                }

                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Add to Diary")
                    .font(.Inter(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 175, height: 48)
                    
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4352941176, green: 0.5607843137, blue: 0.9176470588, alpha: 1)), Color(#colorLiteral(red: 0.2784313725, green: 0.2901960784, blue: 0.8509803922, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                
                
                
            }
            .padding(.bottom, 10)
        }
        .onAppear{
            self.endEditing(true)
        }
    }
        
}

//struct FDCFoodDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FDCFoodDetailView(viewModel: <#FDCFoodDetailViewModel#>)
//    }
//}
