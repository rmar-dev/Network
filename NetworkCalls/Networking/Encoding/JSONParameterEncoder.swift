//
//  JSONParameterEncoder.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 26/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do{
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
