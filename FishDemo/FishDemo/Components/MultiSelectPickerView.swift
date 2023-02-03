//
//  MultiSelectPickerView.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-01-29.
//

import Foundation
import SwiftUI

struct MultiSelectPickerView<T: Hashable & Equatable & CustomStringConvertible>: View {
    let label: String
    @State var sourceItems: [T]
    @Binding var selectedItems: [T]
    
    var body: some View {
        List {
            Section {
                ForEach(sourceItems, id: \.self) { item in
                    Button(action: {
                        withAnimation {
                            if self.selectedItems.contains(item) {
                                //you may need to adapt this piece, my object has an ID I match against rather than just the string
                                self.selectedItems.removeAll(where: { $0 == item })
                            } else {
                                self.selectedItems.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(self.selectedItems.contains(item) ? 1.0 : 0.0)
                            Text(item.description)
                        }
                    }
                    .foregroundColor(.primary)
                }
            } header: {
                Text(label)
            }
        }
    }
}
