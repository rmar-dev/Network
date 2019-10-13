//
//  HTTPTask.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 26/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?
    )
    
    case requestParametersAndHeaders(
        bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionHeaders: Parameters?
    )
}
