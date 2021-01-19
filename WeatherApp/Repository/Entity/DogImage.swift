//
//  DogImage.swift
//  WeatherApp
//
//  Created by Home on 1/18/21.
//

import Foundation

struct DogImage : Codable{
    
    let status: String
    let message : String
    
}


struct Planet : Codable{
    let name : String
    let type : String
    let hourInDays: Int
    let standGravity : Double
}

struct BreedListResponse : Codable {
    let status : String
    let message:  [String : [String]]
}

struct UserLogin {
    
    var username : String
    var password : String
    
}


struct Note {
    var uuid = ""
    var text = ""
}
