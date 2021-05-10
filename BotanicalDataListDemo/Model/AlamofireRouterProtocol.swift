//
//  AlamofireRouterProtocol.swift
//  BotanicalDataListDemo
//
//  Created by Joshua Chang on 2021/5/9.
//  Copyright © 2021 Joshua Chang. All rights reserved.
//

import Foundation
import Alamofire

/// HTTP RESTful API module of Alamofire
protocol AlamofireRouterProtocol {
    var header: HTTPHeaders { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var urlEncoding: URLEncoding { get }
    var jsonEncoding: JSONEncoding { get }
    
    /// RESTful API query implement
    /// - Parameters:
    ///   - urlRequest: construct URL requests
    ///   - handler: feeding result value that represents either a success or a failure
    static func query<T: Codable>(_ urlRequest: URLRequestConvertible, completionHandler handler: @escaping((Swift.Result<T,Error>) -> ()))
}

extension AlamofireRouterProtocol {
    var header: HTTPHeaders { get{ return HTTPHeaders() } }
    var path: String { get{ return String() } }
    static func query<T: Codable>(_ urlRequest: URLRequestConvertible, completionHandler handler: @escaping((Swift.Result<T,Error>) -> ())) {}
}
