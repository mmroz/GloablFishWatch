//
//  EncodingExtensions.swift
//  
//
//  Created by Mark Mroz on 2023-02-02.
//

import Foundation

extension Set where Element: RawRepresentable, Element.RawValue: Equatable & CustomStringConvertible {
    var arrayEncoded: String {
        "[" + encoded + "]"
    }
    
    var encoded: String {
        map(\.rawValue.description).joined(separator: ",")
    }
}

extension Array where Element: CustomStringConvertible {
    var encoded: String? {
        guard !isEmpty else { return nil }
        return map(\.description).joined(separator: ",")
    }
}
