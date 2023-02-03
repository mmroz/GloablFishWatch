//
//  VesselAdvancedSearchView.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-01-29.
//

import Foundation
import SwiftUI
import GlobalFishWatch

struct VesselAdvancedSearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var responseText = "Results..."
        
    @State var limit = "10"
    @State var offset = "0"
    @State var datasets: [VesselApiDataSet] = [.carrier()]
    @State var query = "shipname = 'HAI XUEN 007' OR imo='0'"
    
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
        let response = await fishWatch.vesselAdvancedSearch(
            limit: Int($limit.wrappedValue) ?? 10,
            offset: Int($limit.wrappedValue) ?? 0,
            datasets: Set($datasets.wrappedValue),
            query: $query.wrappedValue
        )
        responseText = Logger.write(response: response)
    }
}

struct VesselAdvancedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VesselAdvancedSearchView()
    }
}
