//
//  BotanicalDataServiceRouter.swift
//  BotanicalDataListDemo
//
//  Created by Joshua Chang on 2021/5/9.
//  Copyright © 2021 Joshua Chang. All rights reserved.
//

import Foundation
import Alamofire

fileprivate let host: String = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f18de02f-b6c9-47c0-8cda-50efad621c14"

enum BotanicalDataServiceError: Error, CustomStringConvertible {
    /// Fatel Error with message
    case FatelErrorWith(message: String)
    /// JSON Decode Error
    case JSONDecoderError
    
    var description: String {
        switch self {
        case .FatelErrorWith(let message):
            return "錯誤訊息: \(message)"
        case .JSONDecoderError:
            return "資料解析失敗"
        }
    }
}

enum BotanicalDataServiceRouter: URLRequestConvertible, AlamofireRouterProtocol {
    
    // MARK: - Service Case
    case getBotanicalData
    
    var method: HTTPMethod {
        switch self {
        case .getBotanicalData:
            return .get
        }
    }
    
    var urlEncoding: URLEncoding {
        switch self {
        default:
            return .default
        }
    }
    
    var jsonEncoding: JSONEncoding {
        switch self {
        default:
            return .default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let endpoint = try host.asURL()
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 5
        
        return urlRequest
    }
    
    static func query<T: Codable>(_ urlRequest: URLRequestConvertible, completionHandler handler: @escaping((Swift.Result<T, Error>) -> ())) {
        Alamofire.request(urlRequest)
            .validate(statusCode: 200..<305)
            .responseJSON(queue: .global(), options: .allowFragments) { (dataResponse) in
                switch (dataResponse.result) {
                case .success(_):
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    guard
                        let data = dataResponse.data,
                        let response = try? decoder.decode(T.self, from: data)
                        else { return handler(.failure(BotanicalDataServiceError.JSONDecoderError)) }
                    handler(.success(response))
                case .failure(let err):
                    handler(.failure(BotanicalDataServiceError.FatelErrorWith(message: err.localizedDescription)))
                }
        }
    }
    
}
