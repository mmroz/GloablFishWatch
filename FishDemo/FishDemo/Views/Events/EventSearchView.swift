//
//  EventSearchView.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-01-28.
//

import SwiftUI
import GlobalFishWatch

struct EventSearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var responseText = "Results..."
        
    @State var limit = "10"
    @State var offset = "0"
    
    @State var sortField = "createdAt"
    @State var isSortedAsc = true
    
    @State var datasets: [EventsApiDataSet] = [.fishing()]
    @State var vessels: [String] = ["907e92b1c-c61a-03fc-17b9-7840ae78aa82"]
    @State var types: [EventType] = [.gap]
    
    @State var confidences: [Confidence] = [.two]
    @State var encounterTypes: [EventEncounterType] = [.carrierFishing]
    
    @State var includesDates: Bool = false
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()

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
                Group {
                    LabeledTextField(label: "Limit", isNumberOnly: true, text: $limit)
                    LabeledTextField(label: "Offset", isNumberOnly: true, text: $offset)
                    ButtonTextField(label: "Order", text: $sortField, isAsc: $isSortedAsc)
                }
                Group {
                    MultiSelectPickerView<EventsApiDataSet>(label: "Datasets", sourceItems: [.fishing(), .loitering(), .encounters(), .port()], selectedItems: $datasets)
                    CloudTag(label: "Vessel IDS", tags: $vessels)
                    MultiSelectPickerView<EventType>(label: "Types", sourceItems: EventType.allCases, selectedItems: $types)
                }
                Toggle("Include Dates", isOn: $includesDates)
                if $includesDates.wrappedValue {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                    DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                }
                Group {
                    MultiSelectPickerView<Confidence>(label: "Confidences", sourceItems: Confidence.allCases, selectedItems: $confidences)
                    MultiSelectPickerView<EventEncounterType>(label: "Encounter Types", sourceItems: EventEncounterType.allCases, selectedItems: $encounterTypes)
                }
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
        let response = await fishWatch.allEvents(
            limit: Int(limit) ?? 10,
            offset: Int(offset) ?? 0,
            sort: isSortedAsc ? .asc(sortField) : .desc(sortField),
            datasets: Set($datasets.wrappedValue),
            vessels: $vessels.wrappedValue,
            types: Set($types.wrappedValue),
            endDate: includesDates ? startDate : nil,
            startDate: includesDates ? endDate : nil,
            confidences: confidences.isEmpty ? nil : confidences.map(\.rawValue),
            encounterTypes: Set($encounterTypes.wrappedValue)
        )
        responseText = Logger.write(response: response)
    }
}

struct EventSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VesselSearchView()
    }
}

enum Confidence: Int, CaseIterable, CustomStringConvertible {
    case two = 2, three = 3, four = 4
    
    var description: String {
        "\(rawValue)"
    }
}
