//
//  HTTPTask.swift
//  
//
//  Created by Mark Mroz on 2023-01-14.
//

import Foundation

import Foundation

public enum HTTPTask {
    case requestWithParameters(urlParameters: [String: String?]?, encoding: ParameterEncoding)
    case requestWithUrlAndBodyParameters(urlParameters: [String: String?]?, urlParameterEncoding: ParameterEncoding, bodyParameters: [String: Any?]?, bodyEncoding: ParameterEncoding)
}
