//
//  MovieView.swift
//  WeatherApp
//
//  Created by Home on 1/18/21.
//

import SwiftUI

struct MovieView: View {
    @State private var selection = 3
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                Text("V1").tabItem {
                    TabItem(selection: $selection, title: "Home", image: .constant("house.fill"), tag: 1)
                }.tag(1)
                
                Text("V2").tabItem {
                    TabItem(selection: $selection, title: "List", image: .constant("list.bullet"), tag: 2)
                }.tag(2)
                WeatherView().tabItem { 
                    TabItem(selection: $selection, title: "Like", image: .constant("heart"), tag: 3)
                }.tag(3)
                
                WeatherView().tabItem { 
                    TabItem(selection: $selection, title: "Like", image: .constant("book"), tag: 3)
                }.tag(3)
          
            }
            
        }
        
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
