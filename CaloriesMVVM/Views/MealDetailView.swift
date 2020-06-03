//
//  MealDetailView.swift
//  CaloriesDemo
//
//  Created by Vasilis Daningelis on 20/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject var dayMeals: FDCDayMeals
    
    var mealType: MealType
    
    var body: some View {
        
        VStack {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: colorArray(mealType)), startPoint: .topLeading, endPoint: .bottomTrailing).frame(width: screen.width, height: 282, alignment: .top)
                
                 Image(uiImage: #imageLiteral(resourceName: "camera-icon"))
                    .offset(y: -20)
            }
            List {
                HeaderMealDetailView(mealType: self.mealType)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                
                foodRowsSection()
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                
            }
            .padding(.top, 20)
            .background(RoundedCorners(tl: 0, tr: 64, bl: 0, br: 0).fill(Color.white))
            .offset(y: -70)
            
            AddButtonView(mealType: self.mealType)
                .padding(.top, 20)
                .padding(.bottom, 10)
        }
            
        .edgesIgnoringSafeArea(.top)
        
    }
    
    private func foodRow(food: FDCSelectedFood) -> some View {
        
        DetailViewFoodRowView(selectedFood: food)
    
    }
    
    private func foodRowsSection() -> some View {
        Section {
            ForEach(dayMeals.getFoods(forMealType: mealType), id: \.self, content: foodRow)
        }
    }
    
    private func colorArray(_ mealType: MealType) -> [Color] {
        
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

struct MealDetailView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        MealDetailView(mealType: .dinner)
        .environmentObject(FDCDayMeals())
    }
}

struct HeaderMealDetailView: View {
    
    
    @EnvironmentObject var dayMeals: FDCDayMeals
    var mealType: MealType
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle =  .medium
        return formatter
    }()
    
    var body: some View {
        Section {
            VStack {
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("\(dayMeals.getMealName(forMealType: mealType))")
                            .font(.Inter(size: 34, weight: .semibold))
                        
                        Text("\(formatter.string(from: Date()))")
                            .font(.Inter(size: 12))
                    }
                    
                    Spacer()
                    
                    Image(uiImage: #imageLiteral(resourceName: "Thunder-Cal-icon"))
                    Text("\(dayMeals.calculateCalories(forMealType: mealType))")
                        .font(.Inter(size: 22))
                        .foregroundColor(Color(#colorLiteral(red: 0.2784313725, green: 0.2901960784, blue: 0.8509803922, alpha: 1)))
                    
                    Text("kcal")
                        .font(.Inter(size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.2784313725, green: 0.2901960784, blue: 0.8509803922, alpha: 1)))
                }
            }
        }
    }
}

struct DetailViewFoodRowView: View {
    var selectedFood: FDCSelectedFood
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(selectedFood.food.name)")
                        .font(.Inter(size: 14, weight: .semibold))
                    
                    Text("\(selectedFood.portion.portionDescription)")
                        .font(.Inter(size: 13, weight: .semibold))
                        .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                }
                
                Spacer()
                
                Text("\(selectedFood.portion.calories) kcal")
                    .font(.Inter(size: 14, weight: .regular))
                    .foregroundColor(Color(#colorLiteral(red: 0.4352941176, green: 0.5607843137, blue: 0.9176470588, alpha: 1)))
                
            }
            .frame(height: 68)
            .padding(.horizontal,20)
            .listRowBackground(Color.white)
            
            Color(#colorLiteral(red: 0.9176470588, green: 0.9333333333, blue: 0.9882352941, alpha: 1)).frame(width: screen.width, height: 1, alignment: .bottom)
        }
    }
}

struct AddButtonView: View {
    var mealType: MealType
    var body: some View {
        Section {
            HStack {
                Spacer()
                
                NavigationLink(destination: AddMealView(viewModel: AddMealViewModel(mealType: mealType))  ,
                               label: {
                                Text("Add More Food")
                                    .font(.Inter(size: 17, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: 175, height: 48)
                                    
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4352941176, green: 0.5607843137, blue: 0.9176470588, alpha: 1)), Color(#colorLiteral(red: 0.2784313725, green: 0.2901960784, blue: 0.8509803922, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                })
                
                Spacer()
            }
            
        }
        
    }
}
