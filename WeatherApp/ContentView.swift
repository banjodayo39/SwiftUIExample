//
//  ContentView.swift
//  WeatherApp
//
//  Created by Home on 1/5/21.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
       Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct Home : View {
    
    @State var movieDataSource = [
        Movie(title: "Chicago Fire", coverImage: "chicagofire"),
        Movie(title: "Chicago Fire", coverImage: "chicagofire"),
        Movie(title: "Chicago Fire", coverImage: "chicagofire"),
        Movie(title: "Chicago Fire", coverImage: "chicagofire"),
        Movie(title: "Chicago Fire", coverImage: "chicagofire")

    ]
    
    
    @State var grid : [Int] = []
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                ZStack{
                    
                    HStack{
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "square.grid.2x2")
                                .resizable()
                                .renderingMode(.original)
                                .foregroundColor(.red)
                                .frame(width: 25, height: 23)
                        })
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: WeatherView(),
                            label: {
                                Image(systemName: "cloud.drizzle")
                                    .resizable()
                                    .renderingMode(.original)
                                    .foregroundColor(.red)
                                    .frame(width: 25, height: 25)
                            })
                     
                    }
                    
                    Text("Movie")
                        .font(.title)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }.padding()
                
                CollectionView(movieDataSource: self.$movieDataSource, grid: self.$grid)

                
                TabBar()
            }.background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.top))
            .edgesIgnoringSafeArea(.bottom)
            .onAppear{
                self.generateGrid()
            }.navigationTitle("")
            .navigationBarHidden(true)
        }.accentColor(.white)
    }
    
    func generateGrid(){
        
        for i in stride(from: 0, to: self.movieDataSource.count, by: 2){
            
            if i != self.movieDataSource.count{
                
                self.grid.append(i)
            }
            
        }
    }
    
}

struct  TabBar : View {
    
    @State var index  = 0 
    
    var body: some View{
        
        HStack {
            
            TabItemView(index: $index, tabIndex: 0, imageName: "house")
            Spacer(minLength: 0)
            
            TabItemView(index: $index, tabIndex: 1, imageName: "magnifyingglass")
            Spacer(minLength: 0)

            TabItemView(index: $index, tabIndex: 2, imageName: "message")
            Spacer(minLength: 0)

            TabItemView(index: $index, tabIndex: 3,  imageName: "line.horizontal.3.decrease.circle")
            
        }.padding(.horizontal, 35)
        .padding(.top, 12)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.04), radius: 0, x: 0, y: -6)

    }
}


struct TabItemView : View{
    
    @Binding var index : Int
    var tabIndex  = 0
    var imageName : String

        
    var body: some View{
        
        Button(action: {
            index = tabIndex            
        }, label: {
            
            VStack{
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(index == 0 ? .red : .gray)
                
                if index == tabIndex{
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                        .offset(y: 6)
                }
            }.padding(.bottom, 12)
        })
    }
}

struct Card : View {
    
    var movie : Movie
    
    var body: some View{
        
        VStack(spacing: 15){
            
            Image(movie.coverImage)
                .resizable()
                .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 260)
                .cornerRadius(12)
            
            Text(movie.title)
            
            Button(action: {
                
            }) {
                
                Text("Play Now")
                    .foregroundColor(.white)
                    .frame(width: (UIScreen.main.bounds.width - 70) / 2)
                    .padding(.vertical,10)
                
            }.background(Color.red)
            .cornerRadius(10) 
            .shadow(radius: 6)
        }
    }
}


struct CollectionView: View {
    
    @Binding var movieDataSource : [Movie]
    @Binding var grid : [Int]
    
    var body: some View{
        
        VStack{
            
            if !self.grid.isEmpty{
                
                ScrollView(.vertical){
                    ForEach(self.grid, id: \.self){ i in
                        
                        HStack(spacing : 15){
                            
                            ForEach(i...i+1, id: \.self){ j in 
                                
                                if j != self.movieDataSource.count{
                                    
                                    Card(movie: self.movieDataSource[j])

                                }
                                
                                if i == self.grid.last! && self.movieDataSource.count % 2 != 0{
                                    
                                    Spacer(minLength: 0)
                                }
                            }
                        }.padding()

                    }

                }
            }
        }
    }
}

struct Movie {
    
    var title : String
    var coverImage : String
}
