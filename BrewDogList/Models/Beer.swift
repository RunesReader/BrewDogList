//
//  Beer.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import Foundation

final class Beer: Codable {
    var id = Int()
    var imageURL = String()
    var name = String()
    var tagline = String()
    var description = String()
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case id, name, tagline, description
    }
}
