//
//  CloudTag.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-01-29.
//

import Foundation
import SwiftUI

struct CloudTag: View {
    let label: String
    @State var text: String = ""
    @Binding var tags: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            TextField("Add \(label)", text: $text)
                .disableAutocorrection(true)
                .onSubmit(addNewTag)
                .submitLabel(.done)
            HStack(alignment: .firstTextBaseline) {
                ForEach(tags, id: \.self) { tag in
                    Button(action: {
                        removeTag(tag: tag)
                    }) {
                        HStack {
                            Text(tag)
                                .padding(4)
                                .lineSpacing(10)
                                .foregroundColor(.white)
                        }
                        .background(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
        }
    }
    
    // check if tag is already there
    func isOriginal(word: String) -> Bool {
        !tags.contains(word)
    }

    // add new tag
    func addNewTag() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let tagWord = text.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard text.count > 0 else { return }

        // exit if the tag was already used
        guard isOriginal(word: tagWord) else {
            text = ""
            return
        }

        tags.insert(tagWord, at: 0)
        text = ""
    }

    func removeTag(tag: String) {
        if let index = tags.firstIndex(of: tag) {
            tags.remove(at: index)
        }
    }
}

//struct Tag: View {
//    let name: String
//
//    var body: some View {
//        HStack {
//            Text(name)
//            Button(name, action: <#T##() -> Void#>)
//        }
//    }
//}
