//
//  WeatherButton.swift
//  WeatherApp
//
//  Created by Home on 1/5/21.
//

import SwiftUI

struct WeatherButton : View{
    
    var title: String
    var textColor : Color 
    var backgroundColor: Color 
    
    var body: some View{
        Text(title)
            .frame(width: 250, height: 50)
            .font(.system(size: 20, weight: .bold, design: .default))
            .foregroundColor(textColor)
            .background(backgroundColor)
            .cornerRadius(10 )
    }
}
