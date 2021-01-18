//
//  Player.swift
//  NBAPLayersApp
//
//  Created by Александр Зубарев on 24.12.2020.
//

import Foundation


struct PlayersResponse: Decodable {
    let data: [Player]
}

struct Player: Decodable {
    let team: Team
    let firstName: String
    let lastName: String
    let heightFeet: Int?
    let heightInches: Int?
    let position: String
    
    var name: String {
        firstName + " " + lastName
    }
    
    var height: String {
        if let heightFeet = heightFeet, let heightInches = heightInches {
            return "\(heightFeet)'\(heightInches)''"
        } else {
            return "Unknown"
        }
    }

    enum CodingKeys: String, CodingKey {
        case team
        case firstName = "first_name"
        case lastName = "last_name"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case position
    }
}

struct Team: Decodable {
    let name: String
    let city: String
    let conference: String
    
    var fullName: String {
        return city + " " + name
    }
}

let lakers = Team(name: "Lakers", city: "Los Angeles", conference: "West")
let heat = Team(name: "Heat", city: "Miami", conference: "East")
