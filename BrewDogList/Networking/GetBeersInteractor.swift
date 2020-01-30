//
//  GetBeersInteractor.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import Foundation

extension NetworkInteractor where ResponseModel == Beer {
    static func getBeers(with itemsPerPage: Int, page: Int, stateHandler: @escaping NetworkStateHandler) -> NetworkInteractor {
        var settingsModel = NetworkSettingModel()
        if let url = URL(string: Endpoint.getBeers + "page=\(page)&per_page=\(itemsPerPage)") {
            let request = URLRequest(url: url)
            settingsModel.request = request
        }
        
        return NetworkInteractor(with: settingsModel, networkStateHandler: stateHandler)
    }
}
