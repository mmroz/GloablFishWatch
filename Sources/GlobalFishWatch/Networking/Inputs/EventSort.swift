//
//  EventSort.swift
//
//
//  Created by Mark Mroz on 2023-01-28.
//

import Foundation

//'+start', '-start', '+end', '-end'
public enum EventSort {
    case asc(String)
    case desc(String)
    
    var value: String {
        switch self {
        case .asc(let string):
            return "+\(string)"
        case .desc(let string):
            return "-\(string)"
        }
    }
}
