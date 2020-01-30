//
//  GetBeersInteractor.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

protocol GetBeers: UIViewController {
    var loadingView: LoadingView? {set get}
    var getBeersInteractor: NetworkInteractor<[Beer]>? {set get}
    
    func startGetBeersInteractor(success: @escaping ([Beer]) -> ())
    func stopGetBeersInteractor()
}

extension GetBeers {
    func startGetBeersInteractor(success: @escaping ([Beer]) -> ()) {
        let handler: NetworkInteractor<[Beer]>.NetworkStateHandler = { [weak self] event in
            switch event {
            case .notLoaded:
                self?.loadingView?.hide()
            case .willLoad:
                self?.loadingView?.show()
            case .didLoad(let beers):
                self?.loadingView?.hide(completion: {
                    success(beers)
                })
            case .failLoading(let error):
                self?.loadingView?.hide(completion: {
                    
                })
            }
        }
    }
    
    func stopGetBeersInteractor() {
        getBeersInteractor?.cancel()
    }
}

extension NetworkInteractor where ResponseModel == [Beer] {
    static func getBeers(with itemsPerPage: Int, page: Int, stateHandler: @escaping NetworkStateHandler) -> NetworkInteractor {
        var settingsModel = NetworkSettingModel()
        if let url = URL(string: Endpoint.getBeers + "page=\(page)&per_page=\(itemsPerPage)") {
            let request = URLRequest(url: url)
            settingsModel.request = request
        }
        
        return NetworkInteractor(with: settingsModel, networkStateHandler: stateHandler)
    }
}
