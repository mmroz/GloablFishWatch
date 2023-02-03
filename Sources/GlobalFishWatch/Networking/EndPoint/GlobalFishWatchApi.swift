//
//  OpenMetioApi.swift
//  
//
//  Created by Mark Mroz on 2023-01-14.
//

import Foundation

public enum GlobalFishWatchApi {
    case getVesselsSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String, suggestFields: [String]?, queryFields: [String]?)
    case getVesselsAdvancedSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String)
    case getVesselWithID(vesselId: String, datasets: VesselApiDataSet)
    case getVesselWithIDs(ids: [String], datasets: Set<VesselApiDataSet>)
    
    case postAllEvents(limit: Int, offset: Int, sort: EventSort?, datasets: Set<EventsApiDataSet>, vessels: [String]?, types: Set<EventType>?, endDate: Date?, startDate: Date?, confidences: [Int]?, encounterTypes: Set<EventEncounterType>?)
    case getEvent(id: String, dataset: EventsApiDataSet)
}

// MARK: - EndPointType

extension GlobalFishWatchApi: EndPointType {
    
    // MARK: - Public Properties
    
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    
    public var baseURL: URL {
        URL(string: "https://gateway.api.globalfishingwatch.org/")!
    }
    
    /// Path for each of the destination paths
    public var path: String {
        switch self {
        case .getVesselsSearch:
            return "v2/vessels/search"
        case .getVesselsAdvancedSearch:
            return "v2/vessels/advanced-search"
        case .getVesselWithID(vesselId: let id, datasets: _):
            return "v2/vessels/\(id)"
        case .getVesselWithIDs:
            return "v2/vessels"
        case .postAllEvents:
            return "v2/events"
        case .getEvent(id: let id, dataset: _):
            return "v2/events/\(id)"
        }
    }
    
    /// The method to use for each queries
    /// - Note: Always use GET for this API
    public var httpMethod: HTTPMethod {
        switch self {
        case .getVesselsSearch, .getVesselsAdvancedSearch, .getVesselWithID, .getVesselWithIDs, .getEvent:
            return .get
        case .postAllEvents:
            return .post
        }
    }
    
    /// The task constructed from the path with the parameters with the required encoding
    public var task: HTTPTask {
        switch self {
        case .getEvent(id: _, dataset: let dataset):
            return .requestWithParameters(
                urlParameters: [
                    "datasets": dataset.qualifiedName,
                ],
                encoding: .customParameterEncoding
            )
        case .postAllEvents(
            limit: let limit,
            offset: let offset,
            sort: let sort,
            datasets: let datasets,
            vessels: let vessels,
            types: let types,
            endDate: let endDate,
            startDate: let startDate,
            confidences: let confidences,
            encounterTypes: let encounterTypes):
            return .requestWithUrlAndBodyParameters(
                urlParameters: [
                    "limit": "\(limit)",
                    "offset": "\(offset)",
                ],
                urlParameterEncoding: .customParameterEncoding,
                bodyParameters: [
                    //"sort": sort?.value, // TODO - fix me. This parameter breaks the API
                    "datasets": Array(datasets.map(\.qualifiedName)),
                    "vessels": vessels,
                    "types": types?.map(\.rawValue),
                    "startDate": endDate.map { ISO8601DateFormatter().string(from: $0) },
                    "endDate": startDate.map { ISO8601DateFormatter().string(from: $0) },
                    "confidences": confidences?.map(\.description),
                    "encounterTypes": encounterTypes?.map(\.rawValue)
                ],
                bodyEncoding: .jsonEncoding(JSONParameterEncoder(encoder: GlobalFishWatchApi.encoder)))
        case .getVesselsSearch(let limit, let offset, let datasets, let query, let suggestFields, let queryFields):
            return .requestWithParameters(
                urlParameters: [
                    "limit": "\(limit)",
                    "offset": "\(offset)",
                    "query": query,
                    "datasets": datasets.map(\.qualifiedName).joined(separator: ","),
                    "suggest-field": suggestFields?.encoded,
                    "query-fields": queryFields?.encoded
                ],
                encoding: .customParameterEncoding
            )
        case .getVesselsAdvancedSearch(limit: let limit, offset: let offset, datasets: let datasets, query: let query):
            return .requestWithParameters(
                urlParameters: [
                    "limit": "\(limit)",
                    "offset": "\(offset)",
                    "query": query,
                    "datasets": datasets.map(\.qualifiedName).joined(separator: ","),
                ],
                encoding: .customParameterEncoding
            )
        case .getVesselWithID(vesselId: _, datasets: let dataset):
            return .requestWithParameters(
                urlParameters: [
                    "datasets": dataset.qualifiedName,
                ],
                encoding: .customParameterEncoding
            )
        case .getVesselWithIDs(ids: let ids, datasets: let datasets):
            return .requestWithParameters(
                urlParameters: [
                    "datasets": datasets.map(\.qualifiedName).joined(separator: ","),
                    "ids": ids.joined(separator: ","),
                ],
                encoding: .customParameterEncoding
            )
        }
    }
}
