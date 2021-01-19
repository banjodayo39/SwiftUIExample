//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Home on 1/5/21.
//

import SwiftUI

struct WeatherView : View{
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundGradientView(isNight: $isNight)
            
            VStack(spacing: 8){
                
                CityView(cityName: "Lagos, Nigeria")
                
                MainWeatherCloudView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                
                HStack(spacing: 20){
                    
                    WeatherDayView(dayOfTheWeek: "TUE", 
                                   imageName: "cloud.sun.fill",
                                   temperature: 70)
                    
                    WeatherDayView(dayOfTheWeek: "WED",
                                   imageName: "sun.max.fill",
                                   temperature: 80)
                    
                    WeatherDayView(dayOfTheWeek: "THUR", 
                                   imageName: "wind.snow",
                                   temperature: 55)
                    
                    WeatherDayView(dayOfTheWeek: "FRI", 
                                   imageName: "sunset.fill", 
                                   temperature: 60)
                    
                    WeatherDayView(dayOfTheWeek: "SAT",
                                   imageName: "snow",
                                   temperature: 25 )
                    
                }
                
                Spacer()
                
                Button{
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherView()
        }
    }
}

struct WeatherDayView: View {
    
    var dayOfTheWeek : String
    var imageName: String
    var temperature : Int
    
    var body: some View {
        HStack{
            VStack{
                Text(dayOfTheWeek)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(.white)
                
                Image(systemName: imageName )
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                
                Text("\(temperature) °")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }
}

struct BackgroundGradientView: View {
    @Binding var isNight : Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightblue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}


struct CityView : View  {
    
    var cityName: String 
    
    var body: some View{
        
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct  MainWeatherCloudView : View {
    
    var imageName : String
    var temperature : Int
    
    var body: some View{
        VStack{
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180, alignment: .center)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }.padding(.bottom, 50) 
    }
}



