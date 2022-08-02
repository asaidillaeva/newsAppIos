//
//  ArticlesRouter.swift
//  ArticlesApp
//
//  Created by Aliia Saidillaeva  on 21/7/22.
//

import Foundation

enum ArticlesRouter: BaseRouter {
    case getAll

    
    var path: String {
        switch self {
        case .getAll:
            return "/v2/top-headlines"
        }
    }
   //https://Articlesapi.org/v2/everything?country=us&apiKey=b4dbc3cdc551448eba2d6de259aabb04
    var httpMethod: HTTPMethods {
        switch self {
        case .getAll:
            return .get
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getAll:
            return nil
        }
    }
    
    var queryParameters: [URLQueryItem]? {
        switch self {
        case .getAll:
            return [URLQueryItem(name: "country", value: "us"), URLQueryItem(name: "apiKey", value: "b4dbc3cdc551448eba2d6de259aabb04")]
        }
    }
    
    var headers: [HTTPHeader]? {
        switch self {
        case .getAll:
            return nil
        }
    }
    
}
