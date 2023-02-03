//
//  VesselSearchView.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-01-28.
//

import SwiftUI
import GlobalFishWatch
import CoreLocation
import MapKit

struct VesselSearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var responseText = "Results..."
        
    @State var limit = "10"
    @State var offset = "0"
    @State var datasets: [VesselApiDataSet] = [.carrier()]
    @State var query = ""
    @State var suggestFields: [String] = []
    @State var queryFields: [String] = []
    

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
                .scrollContentBackground(.hidden)
                .background(.cyan)
                .foregroundColor(.black)
                .padding()
                .frame(height: 150)
            Form {
                LabeledTextField(label: "Limit", isNumberOnly: true, text: $limit)
                LabeledTextField(label: "Offset", isNumberOnly: true, text: $offset)
                MultiSelectPickerView<VesselApiDataSet>(label: "Datasets", sourceItems: [.carrier(), .fishing(), .support()], selectedItems: $datasets)
                LabeledTextField(label: "Query", text: $query)
                CloudTag(label: "Suggest-field", tags: $suggestFields)
                CloudTag(label: "Query-fields", tags: $queryFields)
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
        let response = await fishWatch.vesselSearch(
            limit: Int($limit.wrappedValue) ?? 10,
            offset: Int($offset.wrappedValue) ?? 0,
            datasets: Set($datasets.wrappedValue),
            query: $query.wrappedValue,
            suggestFields: $suggestFields.wrappedValue,
            queryFields: $queryFields.wrappedValue
        )
        responseText = Logger.write(response: response)
    }
}

struct VesselSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VesselSearchView()
    }
}
