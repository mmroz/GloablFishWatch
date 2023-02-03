//
//  MapEventView.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-02-02.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit
import GlobalFishWatch

struct PlaceAnnotationView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.callout)
                .padding(5)
                .background(Color(.white))
                .cornerRadius(10)
            
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }
    }
}

struct MapEventView: View {
    private let api = GlobalFishWatch(apiKey: apiKey)
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.748433, longitude: -73.985656), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))

    
    @State private var navalEvents: [Event] = []
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region,
                annotationItems: navalEvents
            ) { event in
                MapAnnotation(coordinate: event.position.clLocationCoordinate) {
                    NavigationLink {
                        EventDetailsView(event: event)
                    } label: {
                        PlaceAnnotationView(title: "\(event.type.rawValue) \(event.vessel.name ?? "")")
                    }
                }
            }.onAppear {
                Task {
                    await self.fetchEvents()
                }
            }
        }
    }
    
    private func fetchEvents() async {
        switch await api.allEvents(limit: 10, offset: 0, sort: nil, datasets: [.fishing(), /* .port, .loitering, .encounters */], vessels: nil, types: [.loitering, .port, .portVisit, .gap, .gapStart], endDate: nil, startDate: nil, confidences: nil, encounterTypes: [.supportFishing, .fishingSupport, .fishingCarrier, .carrierFishing]) {
        case .success(let result):
            navalEvents = result.entries
        case .failure(let failure):
            print("Error: \(failure.localizedDescription)")
        }
    }
}

struct EventDetailsView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Type:")
                Spacer()
                Text(event.type.rawValue)
            }
            HStack {
                Text("Start:")
                Spacer()
                Text(event.start.formatted())
            }
            HStack {
                Text("End:")
                Spacer()
                Text(event.end.formatted())
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("Vessel SSID:")
                    Spacer()
                    Text(event.vessel.ssvid)
                }
                HStack {
                    Text("Vessel Name:")
                    Spacer()
                    Text(event.vessel.name ?? "")
                }
            }
            if let fishing = event.fishing {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Avg Duration")
                        Spacer()
                        Text(fishing.averageDurationHours.formatted())
                    }
                    HStack {
                        Text("Avg Speed")
                        Spacer()
                        Text(fishing.averageSpeedKnots.formatted())
                    }
                    HStack {
                        Text("Total Distance:")
                        Spacer()
                        Text(fishing.totalDistanceKm.formatted())
                    }
                }
            }
            if let portVisit = event.portVisit {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Confidence:")
                        Spacer()
                        Text(portVisit.confidence.formatted())
                    }
                    HStack {
                        Text("Duration:")
                        Spacer()
                        Text(portVisit.durationHrs.formatted())
                    }
                    anchorage(portVisit.startAnchorage)
                    anchorage(portVisit.intermediateAnchorage)
                    anchorage(portVisit.endAnchorage)
                }
            }
        }
    }
    
    func anchorage(_ anchorage: PortVisit.Anchorage) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Start:")
                Spacer()
                Text(anchorage.name)
            }
            HStack {
                Text("Flag:")
                Spacer()
                Text(anchorage.flag)
            }
            HStack {
                Text("Top Destination:")
                Spacer()
                Text(anchorage.topDestination)
            }
            HStack {
                Text("At Dock:")
                Spacer()
                Text(anchorage.atDock.description)
            }
            HStack {
                Text("Distance From Shore:")
                Spacer()
                Text(anchorage.distanceFromShoreKM.formatted())
            }
        }
    }
}
