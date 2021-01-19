//
//  Constants.swift
//  WeatherApp
//
//  Created by Home on 1/18/21.
//

import Foundation

class TmdbClient{
    
    enum EndPoint {
        
        case randomDogImage 
        case dogBreedUrl(String) 
        case randomDogListUrl 
        
        var url : URL?{
            return URL(string: self.stringValue)
        }
        
        var stringValue : String{
            switch self {
                case .randomDogImage : return "https://dog.ceo/api/breeds/image/random"

                case .dogBreedUrl(let breed):
                    return  "https://dog.ceo/api/breed/\(breed)/images/random"
                
                case .randomDogListUrl:
                    return "https://dog.ceo/api/breeds/list/all"
                    
                default:
                    break 
            }
        }
    }
}
