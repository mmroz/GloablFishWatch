//
//  ContentView.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-02-03.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var isVesselSearchPresented = false
    @State private var isVesselAdvancedSearchPresented = false
    @State private var isVesselIDSearchPresented = false
    @State private var isEvenIDSearchPresented = false
    @State private var isEvenSearchPresented = false
    @State private var isMapPresented = false
    
    var body: some View {
        VStack {
            Button("Vessel Search") {
                isVesselSearchPresented.toggle()
            }.buttonStyle(.borderedProminent)
                .sheet(isPresented: $isVesselSearchPresented) {
                    VesselSearchView()
                }
            Button("Vessel Advanced Search") {
                isVesselAdvancedSearchPresented.toggle()
            }.buttonStyle(.borderedProminent)
                .sheet(isPresented: $isVesselAdvancedSearchPresented) {
                    VesselAdvancedSearchView()
                }
            Button("Vessel ID Search") {
                isVesselIDSearchPresented.toggle()
            }.buttonStyle(.borderedProminent)
                .sheet(isPresented: $isVesselIDSearchPresented) {
                    VesselIDSearchView()
                }
            Button("Event ID Search") {
                isEvenIDSearchPresented.toggle()
            }.buttonStyle(.borderedProminent)
                .sheet(isPresented: $isEvenIDSearchPresented) {
                    EventIDSearchView()
                }
            Button("Event Search") {
                isEvenSearchPresented.toggle()
            }.buttonStyle(.borderedProminent)
                .sheet(isPresented: $isEvenSearchPresented) {
                    EventSearchView()
                }
            Button("Map") {
                isMapPresented.toggle()
            }.buttonStyle(.borderedProminent)
                .sheet(isPresented: $isMapPresented) {
                    MapEventView()
                }
        }
    }
}
