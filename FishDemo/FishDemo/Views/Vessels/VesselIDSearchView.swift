//
//  VesselDetailView.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-01-29.
//

import Foundation
import SwiftUI
import GlobalFishWatch

struct VesselIDSearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var responseText = "Results..."
    
    @State var dataset: VesselApiDataSet = .carrier()
    @State var vesselID = "8c7304226-6c71-edbe-0b63-c246734b3c01"
    
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
                SelectPickerView<VesselApiDataSet>(label: "Datasets", sourceItems: [.carrier(), .fishing(), .support()], selectedItem: $dataset)
                LabeledTextField(label: "Vessel ID:", text: $vesselID)
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
        let response = await fishWatch.vessel(
            id: $vesselID.wrappedValue,
            dataset: $dataset.wrappedValue
        )
        responseText = Logger.write(response: response)
    }
}

struct VesselIDSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VesselIDSearchView()
    }
}
