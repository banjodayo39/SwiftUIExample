//
//  Repoository.swift
//  WeatherApp
//
//  Created by Home on 1/15/21.
//

import SwiftUI

struct Piscum : Codable, Identifiable{
    let id = UUID()
    
    var name : String?
    var author : String? = ""
    var download_url : String? = ""
    var url : String? = ""
}

class  Api  {
    
    private var dogList : [String] = []
    
    func getPost(completion: @escaping ([Piscum]) ->())  {
        guard let url = URL(string: "https://picsum.photos/v2/list") else{
            return
        }
        
        URLSession.shared.dataTask(with: url){(data, response, error) in
            let piscums = try! JSONDecoder().decode([Piscum].self, from: data!)
            print(piscums)
            DispatchQueue.main.async {
                completion(piscums)
            }
        }.resume()
    }
    
    func getImages(completion: @escaping (UIImage) -> ()){
        
        //https://images.unsplash.com/flagged/1/apple-gear-looking-pretty.jpg
        guard let url = TmdbClient.EndPoint.randomDogImage.url else {
            return
        }
        print("the url is \(url)")
        
        URLSession.shared.dataTask(with: url){ [ weak self] (data, res, err) in 
            print("the url data breed  is \(data) \(res) ")
            guard let data = data else {
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                print("the json breed  is \(json)")
                let imageUrl = json["message"] as! String
                
                print("the url image  breed is \(imageUrl)")
                
                let imageData = try!   JSONDecoder().decode(DogImage.self, from: data)
                print("The image data is \(imageData)")
                var image = UIImage()
                
                let task = URLSession.shared.dataTask(with: URL(string: imageData.message)!){ (data, _, _) in
                    
                    guard let data = data else {
                        return
                    }
                    print("data is breed  \(data)")
                    image = UIImage(data: data) ?? UIImage()
                    print("data is  breed \(image)")
                    completion(image)

                }.resume()
            }catch {
                print(err)
            }
          
        }.resume()
    }
    
    
    
    
    func getConstantDogBreedList(breed : String, completion: @escaping ((UIImage) -> ())){
        guard let breedUrl = TmdbClient.EndPoint.dogBreedUrl(breed).url  else {
            return
        }
        
        print("It is end point")
        URLSession.shared.dataTask(with: breedUrl){(data, response, error) in 
            
            guard let data = data else {
                return
            }
            do{
                let imageData  = try  JSONDecoder().decode(DogImage.self, from: data)
                
                var image = UIImage()
                
                var _imageUrl : URL? = URL(string: imageData.message)
                guard let imageUrl = _imageUrl else {
                    return
                }
                
                let task = URLSession.shared.dataTask(with: imageUrl){ (data, _, _) in
                    
                    guard let data = data else {
                        return
                    }
                    print("data is \(data)")
                    image = UIImage(data: data) ?? UIImage()
                    print("data is \(image)")
                    completion(image)
                    
                }.resume()
            }catch {
                print(error)
            }
        }.resume()
    } 

    
    func usingUrlComponent(){
        // "https/itunes.apple.com/us/app/udacity/id819700633?mt=8"
        var udacityAppUrl  = URLComponents()
        udacityAppUrl.scheme = "https"
        udacityAppUrl.host = "itunes.apple.com"
        udacityAppUrl.path = "/us/app/udacity/id819700633"
        udacityAppUrl.queryItems = [URLQueryItem(name: "mt", value: "8")]
    }
    
    func getDogList(completionHandler : @escaping (([String]?, Error?) -> ())){
        
        print("getting dog list")
        guard let url = TmdbClient.EndPoint.randomDogListUrl.url else {
            print("getting dog list esp")
            return
        }

        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: url){ [weak self] (data, response, error) in

            guard let data = data else {
                return
            }
            
            do{
                /**
                let DogImageDict = try decoder.decode([String: String].self, from: data)
                print("Dog image dict \(DogImageDict)")
                let breeds = DogImageDict.values.map({
                    ($0)
                }) 
                 Encode stuff like json{
                 "1000" : {
                        "people" : []
                 }
                 "200" : {
                        "people": []
                        }
                 }*/
                let breedResponse = try decoder.decode(BreedListResponse.self, from: data)

                let breeds = breedResponse.message.keys.map({
                   ($0)
                })
                completionHandler(breeds ?? [], nil)

            } catch{
                print("error while catching \(error)")
                completionHandler(self?.dogList ?? [], nil)

            }
            
        }.resume()
    }
}


struct AppStore {
    
    static let sscheme = "https"
    static let host = "itunes.apple.com"
    static let path = "/us/app/udacity/id819700633"
    
    enum ParameterKey: String {
        case mediaType = "mt"
    }
    
    enum MediaType : String {
        case music = "1",
        podcast = "2" , 
        audiobook = "3",
        mobileApps = "8"
    }
}

