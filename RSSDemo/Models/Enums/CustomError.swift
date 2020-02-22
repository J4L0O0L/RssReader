//
//  CustomError.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import Foundation

enum CustomError: LocalizedError {
    
    case failure(message: String?)
    case unknownMessage
    
    var localization: String {
        switch self {
        case .failure(let message):
            if let m = message {
                return m
            }
            return Message.generalError.rawValue
        case .unknownMessage: return Message.generalError.rawValue
        }
    }
    
    static func  getError(err: Error) -> CustomError  {
        return .unknownMessage
    }
}
