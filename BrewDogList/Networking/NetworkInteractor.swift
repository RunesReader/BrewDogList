//
//  NetworkInteractor.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import Foundation

enum NetLog {
    static let requestNil = "Bad request. Request is nil."
    static let responseNil = "Unknown server error. Response is nil."
    static let successNil = "Error. Success data is nil."
    static let failNil = "Error. Fail response is nil."
}

enum NetworkState<T: Codable> {
    case notLoaded
    case willLoad
    case didLoad(T)
    case failLoading(FailResponseModel)
}

extension NetworkState: Equatable {
    static func ==(lhs: NetworkState, rhs: NetworkState) -> Bool {
        switch (lhs, rhs) {
        case (.notLoaded, .notLoaded):
            return true
        case (.willLoad, .willLoad):
            return true
        case (.didLoad, .didLoad):
            return true
        case (.failLoading, .failLoading):
            return true
        default:
            return false
        }
    }
}

struct NetworkSettingModel {
    var session = URLSession(configuration: URLSessionConfiguration.default)
    var request: URLRequest?
    var canceledCode = -999
    var successCode = 200
    var redirectCode = 300...399
}

final class FailResponseModel: Codable {
    var errorCode = Int()
    var error = String()
    
    enum CodingKeys: String, CodingKey {
        case error = "message"
    }
}

final class NetworkInteractor<ResponseModel: Codable> {
    typealias NetworkStateHandler = (NetworkState<ResponseModel>) -> Swift.Void
    
    // MARK: - Properties
    private let settings: NetworkSettingModel
    private var task: URLSessionDataTask?
    private var networkStateHandler: NetworkStateHandler
    private var state: NetworkState<ResponseModel> = .notLoaded {
        didSet {
            if Thread.isMainThread {
                networkStateHandler(state)
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let this = self else { return }
                    this.networkStateHandler(this.state)
                }
            }
        }
    }
    private var errorModel = FailResponseModel()
    
    // MARK: - Initializations and Deallocation
    init(with settings: NetworkSettingModel, networkStateHandler: @escaping NetworkStateHandler) {
        self.settings = settings
        self.networkStateHandler = networkStateHandler
    }
    
    // MARK: - Internal
    func execute() {
        guard let request = settings.request else {
            errorModel.error = NetLog.requestNil
            state = .failLoading(errorModel)
            
            return
        }
        
        if state == .willLoad { return }
        state = .willLoad
        
        task = settings.session.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let this = self else { return }
            
            if let error = error as NSError? {
                if error.code == this.settings.canceledCode {
                    this.state = .notLoaded
                    
                    return
                }
                
                this.errorModel.error = error.localizedDescription
                this.state = .failLoading(this.errorModel)
                
                return
            }
            
            if let httpURLResponse = response as? HTTPURLResponse {
                let statusCode = httpURLResponse.statusCode
                switch statusCode {
                case this.settings.successCode:
                    this.parseSuccess(data: data)
                case this.settings.redirectCode:
                    this.parseSuccess(data: data)
                default:
                    this.parseFail(data: data, statusCode: statusCode)
                }
            } else {
                this.errorModel.error = NetLog.responseNil
                this.state = .failLoading(this.errorModel)
            }
        })
        
        task?.resume()
    }
    
    func cancel() {
        if state == .willLoad {
            task?.cancel()
            state = .notLoaded
        }
    }
    
    // MARK: - Private
    private func parseSuccess(data: Data?) {
        if let data = data {
            do {
                let result = try JSONDecoder().decode(ResponseModel.self, from: data)
                state = .didLoad(result)
            } catch {
                errorModel.error = error.localizedDescription
                state = .failLoading(errorModel)
            }
        } else {
            errorModel.error = NetLog.successNil
            state = .failLoading(errorModel)
        }
    }
    
    private func parseFail(data: Data?, statusCode: Int) {
        let defaultErrorString = HTTPURLResponse.localizedString(forStatusCode: statusCode)
        let fullDefaultErrorString = "\(statusCode)\n\(defaultErrorString)"
        errorModel.errorCode = statusCode
        
        if let data = data {
            do {
                let result = try JSONDecoder().decode(FailResponseModel.self, from: data)
                result.errorCode = statusCode
                if result.error.isEmpty {
                    result.error = fullDefaultErrorString
                }
                state = .failLoading(result)
            } catch {
                errorModel.error = fullDefaultErrorString
                state = .failLoading(errorModel)
            }
        } else {
            errorModel.error = "\(statusCode)\n\(NetLog.failNil)"
            state = .failLoading(errorModel)
        }
    }
}
