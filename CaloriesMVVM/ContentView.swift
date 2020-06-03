//
//  ContentView.swift
//  CaloriesMVVM
//
//  Created by Vasilis Daningelis on 21/5/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var dayMeals: FDCDayMeals
    
    var body: some View {
        NavigationView{
            
            ZStack {
                Color(#colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9803921569, alpha: 1)).edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                
                                HStack { //Eaten
                                    Color(#colorLiteral(red: 0.8, green: 0.8431372549, blue: 1, alpha: 1))
                                        .frame(width: 2, height: 45)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Eaten")
                                            .font(.Inter(size: 14))
                                            .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                        HStack(alignment: .firstTextBaseline) {
                                            Image(uiImage: #imageLiteral(resourceName: "IconEaten"))
                                            Text("\(dayMeals.calculateTotalCalories())")
                                                .font(.Inter(size: 22))
                                            Text("kcal")
                                                //.fixedSize()
                                                .font(.Inter(size: 11))
                                                .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                        }
                                    }
                                }
                                
                                HStack { //Burned
                                    Color(#colorLiteral(red: 0.9960784314, green: 0.768627451, blue: 0.8392156863, alpha: 1))
                                        .frame(width: 2, height: 45)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Burned")
                                            .font(.Inter(size: 14))
                                            .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                        HStack(alignment: .lastTextBaseline) {
                                            Image(uiImage: #imageLiteral(resourceName: "IconBurned"))
                                            Text("102")
                                                .font(.Inter(size: 22))
                                            Text("kcal")
                                                .font(.Inter(size: 11))
                                                .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                        }
                                    }
                                }
                            }
                            
                            //Ring progress indicator
                            RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 112, height: 112, percent: CGFloat(dayMeals.calculateEatenCalPercentage()), show: .constant(true))
                                .padding(.leading, 30)
                            //.animation(Animation.easeInOut.delay(0.3))
                        }
                        
                        Color(#colorLiteral(red: 0.9176470588, green: 0.9333333333, blue: 0.9882352941, alpha: 1)).frame(width: 267, height: 1)
                            .clipShape(RoundedRectangle(cornerRadius: 2, style: .continuous))
                        
                        HStack() {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Carbs")
                                    .font(.Inter(size: 14))
                                
                                //Carbs progress bar
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8, green: 0.8431372549, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5607843137, green: 0.6588235294, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                                    .frame(width: calculateBarWidth(forNutrition: .carbs), height: 4)
                                    .cornerRadius(2)
                                    .frame(width: 56, height: 4, alignment: .leading)
                                    .background(Color(#colorLiteral(red: 0.9176470588, green: 0.9333333333, blue: 0.9882352941, alpha: 1)))
                                    .cornerRadius(2)
                                
                                Text(dayMeals.calculateCarbsLeft())
                                    .font(.Inter(size: 11))
                                    .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Protein")
                                    .font(.Inter(size: 14))
                                
                                //Protein progress bar
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.6745098039, blue: 0.7764705882, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.2862745098, blue: 0.5058823529, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                                    .frame(width: calculateBarWidth(forNutrition: .protein), height: 4)
                                    .cornerRadius(2)
                                    .frame(width: 56, height: 4, alignment: .leading)
                                    .background(Color(#colorLiteral(red: 1, green: 0.9058823529, blue: 0.9333333333, alpha: 1)))
                                    .cornerRadius(2)
                                
                                
                                Text(dayMeals.calculateProteinLeft())
                                    .font(.Inter(size: 11))
                                    .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Fat")
                                    .font(.Inter(size: 14))
                                
                                //Fat progress bar
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.3764705882, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.7176470588, blue: 0.262745098, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                                    .frame(width: calculateBarWidth(forNutrition: .fat), height: 4)
                                    .cornerRadius(2)
                                    .frame(width: 56, height: 4, alignment: .leading)
                                    .background(Color(#colorLiteral(red: 1, green: 0.9568627451, blue: 0.8, alpha: 1)))
                                    .cornerRadius(2)
                                
                                Text(dayMeals.calculateFatLeft())
                                    .font(.Inter(size: 11))
                                    .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                
                            }
                        }
                        
                    }
                    .padding(20)
                    .frame(width: 315)
                    .background(RoundedCorners(tl: 8, tr: 64, bl: 8, br: 8).fill(Color.white))
                    .shadow(color: Color(#colorLiteral(red: 0.4352941176, green: 0.5607843137, blue: 0.9176470588, alpha: 1)).opacity(0.2), radius: 20, x: 4, y: 16)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Meals today")
                            .padding(.leading, 25)
                        
                        // Carousel (Horizontal ScrollView) for Meal Views
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                
                                ForEach(MealType.allCases, id: \.self, content: carouselItem )
                                
                                
                            }
                            .padding(.bottom, 60)
                            .padding(.horizontal, 30)
                        }
                        
                    }
                    .padding(.top, 55)
                }
            }
        }
        .accentColor( .white)
    }
    
    private func carouselItem(mealType: MealType) -> some View {
        
        //If a meal is empty, the user should navigate to AddMealView to add foods
        //If meal is not empty, the details of meal are shown
        
        if dayMeals.getFoods(forMealType: mealType).count == 0 {
            return AnyView(
                NavigationLink(destination: AddMealView(viewModel: AddMealViewModel(mealType: mealType))  ,
                               label: {
                                MealCarouselItemView(mealType: mealType)
                                
                })
            )
        }
        else{
            return AnyView(
                NavigationLink(destination: MealDetailView(mealType: mealType),
                               label: {
                                MealCarouselItemView(mealType: mealType)
                })
            
            )
        }
        
    }
    
    //Calculates the progress bars width depending on user's selected foods
    private func calculateBarWidth(forNutrition  nutrition: NutritionFact) -> CGFloat{
        
        let fullBarWidth = 56.0
        
        let stepping: CGFloat
        let finalWidth:CGFloat
        switch nutrition {
        case .carbs:
            stepping = CGFloat(fullBarWidth / Double(dayMeals.carbsLimit))
            finalWidth = stepping * CGFloat(dayMeals.calculateTotalCarbs())
        case .fat:
            stepping = CGFloat(fullBarWidth / Double(dayMeals.fatLimit))
            finalWidth = stepping * CGFloat(dayMeals.calculateTotalFat())
        case .protein:
            stepping = CGFloat(fullBarWidth / Double(dayMeals.proteinLimit))
            finalWidth = stepping * CGFloat(dayMeals.calculateTotalProtein())
        }
        
        guard finalWidth < CGFloat(fullBarWidth) else {
            return CGFloat(fullBarWidth)
        }
        
        //Return a minimum valuer if user hasn't selected any food so far
        guard finalWidth != 0 else {
            return 3
        }
        
        return finalWidth
    }
    
}


struct MealCarouselItemView: View {
    @EnvironmentObject var dayMeals: FDCDayMeals
    var mealType: MealType
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if dayMeals.getFoods(forMealType: mealType).count > 0{
                
                Text(dayMeals.getMealName(forMealType: mealType))
                .font(.Inter(size: 16))
                .foregroundColor(.white)
                //.frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
                .padding(.top, 35)
                
                Text(dayMeals.getFoodNames(forMealType: mealType))
                .font(.Inter(size: 11))
                .foregroundColor(.white)
                //.lineLimit(4)
                .padding(.horizontal, 15)
                .frame(height: 65)
                
                HStack(alignment: .firstTextBaseline, spacing: 1) {
                    Spacer()
                    Text(dayMeals.calculateCalories(forMealType: mealType))
                        .font(.Inter(size: 28))
                        .foregroundColor(.white)
                    
                    Text("kcal")
                        .font(.Inter(size: 12))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
            }else{
                
                Text(dayMeals.getMealName(forMealType: mealType))
                .font(.Inter(size: 16))
                .foregroundColor(.white)
                //.frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
                .padding(.top, 65)
                
                Text("Add foods")
                .font(.Inter(size: 11))
                .foregroundColor(.white)
                //.lineLimit(4)
                .padding(.horizontal, 15)
                .frame(height: 30)
                
                
                Image(uiImage: #imageLiteral(resourceName: "add-maeal-button"))
                .offset(y: 7)
            }
        }
        .frame(width: 116, height: 178, alignment: .leading)
        .background(RoundedCorners(tl: 8, tr: 100, bl: 8, br: 8).fill(LinearGradient(gradient: Gradient(colors: getGradientColors()), startPoint: .topLeading, endPoint: .bottomTrailing)))
        .shadow(color: getGradientColors()[1].opacity(0.8), radius: 20, x: 4, y: 12)
        .overlay(getTopIcon().offset(x: -21, y: -75))
        .padding(.top, 30)
    }
    
    private func getTopIcon() -> Image{
        switch mealType {
        case .breakfast:
            return Image(uiImage: #imageLiteral(resourceName: "breakfast-icon"))
        case .lunch:
            return Image(uiImage: #imageLiteral(resourceName: "Lunch-icon"))
            
        case .dinner:
            return Image(uiImage: #imageLiteral(resourceName: "Diner-icon"))
        
        case .snacks:
            return Image(uiImage: #imageLiteral(resourceName: "Snack-icon"))
        }
        
    }
    
    
    private func getGradientColors() -> [Color]{
        
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

struct ContentView_Previews: PreviewProvider {
    //var dayMeals = FDCDayMeals()
    
    static var previews: some View {
        ContentView()
            .environmentObject(FDCDayMeals())
    }
}

let screen = UIScreen.main.bounds

