//
//  EventIDSearchView.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-02-01.
//

import Foundation
import SwiftUI
import GlobalFishWatch

struct EventIDSearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var responseText = "Results..."
        
    @State var dataset: EventsApiDataSet = .fishing()
    @State var eventID = "c2f0967e061f99a01793edac065de003"
    
    var body: some View {
        NavigationView {
            contents
                .toolbar {
                    Button("Done") {
                        dismiss()
                    }
                }
        }
    }
    
    private var contents: some View {
        VStack(alignment: .leading) {
            TextEditor(text: $responseText)
                .foregroundColor(.black)
                .scrollContentBackground(.hidden)
                .background(.cyan)
                .padding()
                .frame(height: 150)
            Form {
                SelectPickerView<EventsApiDataSet>(label: "Datasets", sourceItems: [.encounters(), .port(), .loitering(), .fishing()], selectedItem: $dataset)
                LabeledTextField(label: "Event ID:", text: $eventID)
                Button("Submit") {
                    Task {
                        await fetch()
                    }
                }
            }
        }
    }
    
    private func fetch() async {
        let fishWatch = GlobalFishWatch(apiKey: apiKey)
        let response = await fishWatch.event(
            id: $eventID.wrappedValue,
            dataset: $dataset.wrappedValue
        )
        responseText = Logger.write(response: response)
    }
    
    private func describe(_ codable: Codable) -> String {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(codable)
        return String(data: data ?? Data(), encoding: .utf8) ?? ""
    }
}

extension EventsApiDataSet: CustomStringConvertible {
    public var description: String {
        qualifiedName
    }
}


struct EventIDSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VesselIDSearchView()
    }
}
