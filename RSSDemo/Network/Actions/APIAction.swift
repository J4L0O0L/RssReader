//
//  APIAction.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Alamofire

protocol APIAction: URLRequestConvertible {
  var method: HTTPMethod { get }
  var path: String { get }
  var actionParameters: [String: Any] { get }
  var baseURL: String { get }
  var authHeader: [String: String] { get }
  var encoding: ParameterEncoding { get }
}

extension APIAction {
  var actionParameters: [String : Any] {
    return [:]
  }
  var authHeader: [String : String] {
    return [:]
  }
  var baseURL: String {
    return "https://rss.itunes.apple.com/api/v1"
  }
}
