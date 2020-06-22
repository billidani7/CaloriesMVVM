//
//  ContentView.swift
//  WatchApp Extension
//
//  Created by Vasilis Daningelis on 19/6/20.
//  Copyright © 2020 Vasilis Daningelis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9803921569, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        
                        HStack(spacing: 2) { //Eaten
                            Color(#colorLiteral(red: 0.8, green: 0.8431372549, blue: 1, alpha: 1))
                                .frame(width: 2, height: 45)
                            
                            VStack(alignment: .leading) {
                                Text("Eaten")
                                    .font(.Inter(size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                HStack(alignment: .firstTextBaseline) {
                                    Image(uiImage: #imageLiteral(resourceName: "IconEaten"))
                                    Text(viewModel.eatenCal)
                                        .font(.Inter(size: 15))
                                        .foregroundColor(.black)
                                    Text("kcal")
                                        //.fixedSize()
                                        .font(.Inter(size: 11))
                                        .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                }
                            }
                        }
                        
                        HStack(spacing: 2) { //Burned
                            Color(#colorLiteral(red: 0.9960784314, green: 0.768627451, blue: 0.8392156863, alpha: 1))
                                .frame(width: 2, height: 45)
                            
                            VStack(alignment: .leading) {
                                Text("Burned")
                                    .font(.Inter(size: 14))
                                    .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                HStack(alignment: .lastTextBaseline) {
                                    Image(uiImage: #imageLiteral(resourceName: "IconBurned"))
                                    Text("102")
                                        .font(.Inter(size: 15))
                                        .foregroundColor(.black)
                                    Text("kcal")
                                        .font(.Inter(size: 11))
                                        .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                                }
                            }
                        }
                    }
                    .padding(7)
                    
                    Spacer()
                    
                    //Ring progress indicator
                    RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 35, height: 35, percent: CGFloat(viewModel.eatenCallPercentage), show: .constant(true))
                        .padding(.trailing, 10)
                    //.animation(Animation.easeInOut.delay(0.3))
                }
                
                
                Color(#colorLiteral(red: 0.9176470588, green: 0.9333333333, blue: 0.9882352941, alpha: 1)).frame(maxWidth: .infinity).frame(height: 1)
                    .clipShape(RoundedRectangle(cornerRadius: 2, style: .continuous))
                
                HStack() {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Carbs")
                            .font(.Inter(size: 14))
                            .foregroundColor(.black)
                        
                        //Carbs progress bar
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8, green: 0.8431372549, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5607843137, green: 0.6588235294, blue: 1, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: calculateBarWidth(forNutrition: .carbs), height: 4)
                            .cornerRadius(2)
                            .frame(width: 30, height: 4, alignment: .leading)
                            .background(Color(#colorLiteral(red: 0.9176470588, green: 0.9333333333, blue: 0.9882352941, alpha: 1)))
                            .cornerRadius(2)
                        
                        Text(viewModel.carbsLeft)
                            .font(.Inter(size: 11))
                            .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Protein")
                            .font(.Inter(size: 14))
                            .foregroundColor(.black)
                        
                        //Protein progress bar
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.6745098039, blue: 0.7764705882, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.2862745098, blue: 0.5058823529, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: calculateBarWidth(forNutrition: .protein), height: 4)
                            .cornerRadius(2)
                            .frame(width: 30, height: 4, alignment: .leading)
                            .background(Color(#colorLiteral(red: 1, green: 0.9058823529, blue: 0.9333333333, alpha: 1)))
                            .cornerRadius(2)
                        
                        
                        Text(viewModel.proteinLeft)
                            .font(.Inter(size: 11))
                            .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Fat")
                            .font(.Inter(size: 14))
                            .foregroundColor(.black)
                        
                        //Fat progress bar
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8666666667, blue: 0.3764705882, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.7176470588, blue: 0.262745098, alpha: 1))]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: calculateBarWidth(forNutrition: .fat), height: 4)
                            .cornerRadius(2)
                            .frame(width: 30, height: 4, alignment: .leading)
                            .background(Color(#colorLiteral(red: 1, green: 0.9568627451, blue: 0.8, alpha: 1)))
                            .cornerRadius(2)
                        
                        Text(viewModel.fatLeft)
                            .font(.Inter(size: 11))
                            .foregroundColor(Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.6588235294, alpha: 1)))
                        
                    }
                }
                .padding(.horizontal, 7)
                .padding(.bottom, 3)
                
            }
            .background(RoundedCorners(tl: 8, tr: 64, bl: 8, br: 8).fill(Color.white))
            .shadow(color: Color(#colorLiteral(red: 0.4352941176, green: 0.5607843137, blue: 0.9176470588, alpha: 1)).opacity(0.2), radius: 20, x: 4, y: 16)
                .padding(.horizontal, 7)
            
            
        }
    }
    
    
    //Calculates the progress bars width depending on user's selected foods
    private func calculateBarWidth(forNutrition  nutrition: NutritionFact) -> CGFloat{
        
        let fullBarWidth = 56.0
        
        let stepping: CGFloat
        let finalWidth:CGFloat
        switch nutrition {
        case .carbs:
            stepping = CGFloat(fullBarWidth / 360.0)
            finalWidth = stepping * CGFloat(Int(viewModel.carbs) ?? 0)
        case .fat:
            stepping = CGFloat(fullBarWidth / 95.0)
            finalWidth = stepping * CGFloat(Int(viewModel.fat) ?? 0)
        case .protein:
            stepping = CGFloat(fullBarWidth / 145.0)
            finalWidth = stepping * CGFloat(Int(viewModel.protein) ?? 0)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
