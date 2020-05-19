//
//  NetworkManager.swift
//  WorkMate
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2019 Mohammad Safad. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum ResponseStatus: Equatable {
    case ok,
    badRequest,
    networkFailure
}

typealias NetworkRequest = BaseNetworkRequest

protocol BaseNetworkRequest {
    var baseURL: String { get }
    var endpoint: String { get }
    var parameters: Parameters { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var encoding: ParameterEncoding { get }
    var url: String { get }
}

extension BaseNetworkRequest {
    var baseURL: String {
        return Environment().configuration(PlistKey.baseURL)
    }
    var headers: [String: String] {
        return [:]
    }
    var encoding: ParameterEncoding {
        switch self.method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    var url: String {
        return baseURL + endpoint
    }
}

protocol NetworkStubHandler: class {
    func getSampleResponse() -> (isSuccess: Bool, response: Data?)
}

class NetworkManager {
    weak var networkStubHandler: NetworkStubHandler?
    func request(_ request: NetworkRequest,
                 shouldRetry: Bool? = true,
                 completionHandler: @escaping (_ isSuccess: Bool, _ responseCode: ResponseStatus, _ response: Data?) -> Void) {
        
        self.networkRequest(request, shouldRetry: shouldRetry) { (isSuccess, responseCode, response) in
            completionHandler(isSuccess, responseCode, response)
        }
        
    }
    private func networkRequest(_ request: NetworkRequest,
                                shouldRetry: Bool? = true,
                                completionHandler: @escaping (_ isSuccess: Bool, _ responseCode: ResponseStatus, _ response: Data?) -> Void) {
        
        let sessionManager = AlamofireNetworkManager.sharedInstance.sessionManager
        sessionManager.session.configuration.timeoutIntervalForRequest = 15
        let networkRequest = sessionManager.networkRequest(request.url,
                                                           method: request.method,
                                                           parameters: request.parameters,
                                                           encoding: request.encoding,
                                                           headers: request.headers)
        networkRequest.validate().responseJSON { [weak self]
            response in
            guard let self = self else {
                return
            }
            let result = self.handleResponse(response)
            completionHandler(result.isSuccess, result.responseCode, result.response)
        }
    }
    private func handleResponse(_ response: DataResponse<Any>) -> (isSuccess: Bool, responseCode: ResponseStatus, response: Data?) {
        if let responseCode = response.response?.statusCode {
            if responseCode == 200{
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    
                    return (true, .ok, try! json.rawData())
                case .failure:
                    return (false, .badRequest, nil)
                }
            }
            return (false, .badRequest, nil)
        }
        return (false, .networkFailure , nil)
    }
}

