//
//  ButtonTextField.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-02-02.
//

import Foundation
import SwiftUI

struct ButtonTextField: View {
    private let label: String
    private var text: Binding<String>
    private var isAsc: Binding<Bool>
    
    init(label: String, text: Binding<String>, isAsc: Binding<Bool>) {
        self.label = label
        self.text = text
        self.isAsc = isAsc
    }
    
    var body: some View {
        HStack {
            Text(label)
            TextField(label, text: text)
            Button(isAsc.wrappedValue ? "ASC" : "DESC") {
                isAsc.wrappedValue.toggle()
            }
        }
    }
}
