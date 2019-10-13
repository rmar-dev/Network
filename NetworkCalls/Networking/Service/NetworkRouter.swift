//
//  NetworkRouter.swift
//  NetworkCalls
//
//  Created by Ricardo Rabeto on 26/08/2019.
//  Copyright © 2019 Ricardo Rabeto. All rights reserved.
//

import Foundation
import UIKit
public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()

public typealias ImageDownloadHandler = (_ image: UIImage?,_ response: URL?,_ error: Error?) -> ()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}


