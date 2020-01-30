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
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? Int()
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? String()
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? String()
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline) ?? String()
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? String()
    }
}
