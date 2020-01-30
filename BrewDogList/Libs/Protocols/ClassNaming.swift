//
//  ClassNaming.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import Foundation

protocol ClassNaming {
    static var className: String { get }
}

extension ClassNaming {
    static var className: String {
        return String(describing: Self.self)
    }
}
