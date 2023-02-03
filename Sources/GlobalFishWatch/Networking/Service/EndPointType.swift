//
//  EndPointType.swift
//  
//
//  Created by Mark Mroz on 2023-01-14.
//

import Foundation

public protocol EndPointType {
    
    // MARK: - Public Types
    
    /// The Base URL to make requests against
    var baseURL: URL { get }
    
    /// The Path to append to the Base URL
    var path: String { get }
    
    /// The HTTP method used for the request
    var httpMethod: HTTPMethod { get }
    
    /// The task representing the encoding of the variables for the method
    var task: HTTPTask { get }
}
