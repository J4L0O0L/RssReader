//
//  RssAction.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Alamofire

enum RssAction: APIAction {
    case unitedStates
    case unitedKingdom
    
    var method: HTTPMethod {
        return .get
    }
    
    var responseType: ResponseType {
        switch path.split(separator: ".")[1].uppercased(){
        case "JSON":
            return .JSON
        case "RSS":
            return .XML
        default:
            return .JSON
        }
    }
    
    var path: String {
        switch self {
        case .unitedStates:
            return "/us/books/top-free/all/50/explicit.json"
        case .unitedKingdom:
            return "/gb/books/top-free/all/50/explicit.rss"
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        let originalRequest = try URLRequest(url: baseURL.appending(path),
                                             method: method,
                                             headers: authHeader)
        let encodedRequest = try encoding.encode(originalRequest,
                                                 with: actionParameters)
        return encodedRequest
    }
}
