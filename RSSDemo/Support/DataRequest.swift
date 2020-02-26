//
//  DataSource.swift
//
//  Created by raika on 27/11/2019.
//  Copyright © 2019 raikak. All rights reserved.
//

import Foundation
import Alamofire

public extension DataRequest {
    
    @discardableResult
    func verboseLog() -> Self {
        self.logRequest()
        return self.logResponse()
    }
    
    @discardableResult
    func logRequest() -> Self {
        guard
            let method = self.request?.httpMethod,
            let url = self.request?.url else {
                return self
        }
        var message = "[REQUEST] \(method) \(url)"
        
        if let headers = self.request?.allHTTPHeaderFields {
            for header in headers {
                message += "\n\(header.key): \(header.value)"
            }
        }
        if let data = self.request?.httpBody,
            let body = String(data: data, encoding: .utf8) {
            message += "\n\(body)"
        }
        
        
        print(message)
        
        return self
    }
    
    @discardableResult
    func logResponse() -> Self {
        return self.response(completionHandler: {
            guard
                let method = $0.request?.httpMethod,
                let url = $0.request?.url else {
                    return
            }
            
            var message = "[RESPONSE] \(method) \($0.response?.statusCode ?? -1) \(url) \(String(format: "%.3fms", $0.timeline.requestDuration * 1000))"
            
            if let err = $0.error?.localizedDescription {
                message += " [!] \(err)"
            }
            
            
            if let headers = $0.response?.allHeaderFields {
                for header in headers {
                    message += "\n\(header.key): \(header.value)"
                }
            }
            if let data = $0.data,
                let body = String(data: data, encoding: .utf8) {
                if body.count > 0 {
                    message += "\n\(body)"
                }
            }
            
            
            print(message)
        })
    }
}
