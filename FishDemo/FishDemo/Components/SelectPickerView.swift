//
//  SelectPickerView.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-01-29.
//

import Foundation
import SwiftUI

struct SelectPickerView<T: Hashable & Equatable & CustomStringConvertible>: View {
    let label: String
    @State var sourceItems: [T]
    @Binding var selectedItem: T
    
    var body: some View {
        List {
            ForEach(sourceItems, id: \.self) { item in
                Button(action: {
                    withAnimation {
                        self.selectedItem = item
                    }
                }) {
                    HStack {
                        Image(systemName: "checkmark")
                            .opacity(self.selectedItem == item ? 1.0 : 0.0)
                        Text(item.description)
                    }
                }
                .foregroundColor(.primary)
            }
        }
    }
}
