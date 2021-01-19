//
//  ListView.swift
//  WeatherApp
//
//  Created by Home on 1/15/21.
//

import SwiftUI

struct ListView: View {
    @State var image = UIImage(named: "chicagofire") ?? UIImage()

    @State var breedImage = UIImage(named: "chicagofire") ?? UIImage()
    @State private var breeds : [String] = []
    @State private var selectBreed = 0
    
    

    var body: some View {
        
        VStack{
            Image(uiImage: image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .onAppear(){
                    image = UIImage(named: "chicagofire") ?? UIImage()
                    Api().getImages{ _image in
                        DispatchQueue.main.async {
                            print(_image)
                            self.image = _image 
                        } 
                    }
                }
            
            
            Text("author")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.white)
            
            Picker(selection: $selectBreed, label: Text("Please choose a color")){

                ForEach(0..<breeds.count ){
                    Text(self.breeds[$0]).tag(self.breeds[$0])
                }
            }
            .id(UUID())
            

            
            Image(uiImage: breedImage)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180).onTapGesture {
                    loadSelectedBreed()
                }
            
            Button(action: {
                loadSelectedBreed()
            }, label: {
                Text("click to search image")
                    .foregroundColor(Color.red)
                
            }).padding()
            .clipShape(Rectangle())
            .cornerRadius(5)
            .border(Color.red, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            
        }.onAppear(){
            loadDogList()
        }
        .padding(10)
        
        
    }
    
    func load() {
        guard let url = URL(string: "https://i.mmo.cm/is/image/mmoimg/an-product-max/cutlass-85-cm-larp-weapon--an-600052-1.jpg") else {
            return
        }
        DispatchQueue.global().async { 
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
    
     func loadSelectedBreed(){
        print("I am called 1")

        Api().getConstantDogBreedList(breed: breeds[selectBreed]) { _image in
            print("I am called 2")
            DispatchQueue.main.async{
                print(_image)
                self.breedImage = _image 
            }       
            
        }
    }
    
    func loadDogList(){
        print("called, the list")
        Api().getDogList{ _dogList, _error in
            breeds = _dogList!
            print("The doglist \(_dogList)")
        }
    }

}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
