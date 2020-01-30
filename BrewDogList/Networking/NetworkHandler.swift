//
//  NetworkHandler.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import Foundation

enum NetConfig {
    static let post = "POST"
    static let get = "GET"
    static let baseURL = "https://api.punkapi.com/v2/"
}

enum Endpoint {
    static let getBeers = NetConfig.baseURL + "beers?"
}
