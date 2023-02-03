//
//  LabeledTextField.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-01-29.
//

import Foundation
import SwiftUI

struct LabeledTextField: View {
    private let label: String
    private let isNumberOnly: Bool
    
    private var text: Binding<String>
    
    init(label: String, isNumberOnly: Bool = false, text: Binding<String>) {
        self.label = label
        self.isNumberOnly = isNumberOnly
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(label)
            TextField(label, text: text)
                .keyboardType(isNumberOnly ? .numberPad : .default)
        }
    }
}
