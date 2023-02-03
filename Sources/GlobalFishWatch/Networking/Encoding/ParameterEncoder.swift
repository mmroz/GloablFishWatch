//
//  ParameterEncoder.swift
//  
//
//  Created by Mark Mroz on 2023-01-14.
//

import Foundation


public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: [String: Any?]?) throws
}
