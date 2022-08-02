//
//  BaseRouter.swift
//  ArticlesApp
//
//  Created by Aliia Saidillaeva  on 21/7/22.
//

import Foundation

struct HTTPHeader {
    let field: String
    let value: String
}

enum HTTPMethods: String {
    case get
    case post
    case put
}

protocol BaseRouter {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethods { get }
    var httpBody: Data? { get }
    var queryParameters: [URLQueryItem]? { get }
    var headers: [HTTPHeader]? { get }
}

extension BaseRouter {
    
    var scheme: String {
        "https"
    }
    
    var host: String {
        "newsapi.org"
    }
    
    func getURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryParameters
        
        let url = urlComponents.url!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue.uppercased()
        urlRequest.httpBody = httpBody
        headers?.forEach({ header in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.field)
        })
        return urlRequest
    }
}
