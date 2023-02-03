import Foundation

public enum GlobalFishWatchError: Error {
    case noData
    case encodingError(Error)
    case decodingError(Error)
    case networkFailure(Error)
    case apiError(APIErrorResponse)
    case responseError(ResponseError)
    case invalidResponse
}

public class GlobalFishWatch {
    
    private let router: Router<GlobalFishWatchApi>
    
    private lazy var decoder = JSONDecoder.globalFishWatchDecoder

    public init(apiKey: String) {
        self.router = Router(headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + apiKey
        ])
    }
    
    // Events
    
    public func event(id: String, dataset: EventsApiDataSet, completion: @escaping ((Result<Event, GlobalFishWatchError>) -> Void)) {
        router.request(.getEvent(id: id, dataset: dataset)) { [weak self] data, response, error in
            guard let self else { return }
            DispatchQueue.main.async {
                completion(self.handleResponse(data: data, response: response, error: error))
            }
        }
    }
    
    @available(macOS 10.15.0, *)
    @available(iOS 15.0, *)
    public func event(id: String, dataset: EventsApiDataSet) async -> Result<Event, GlobalFishWatchError> {
        do {
            let data = try await router.request(.getEvent(id: id, dataset: dataset))
            return decodeResponse(data: data)
        } catch {
            return .failure(.networkFailure(error))
        }
    }
    
    // All Events
    
    public func allEvents(limit: Int, offset: Int, sort: EventSort?, datasets: Set<EventsApiDataSet>, vessels: [String]?, types: Set<EventType>?, endDate: Date?, startDate: Date?, confidences: [Int]?, encounterTypes: Set<EventEncounterType>?, completion: @escaping ((Result<EventListResponse, GlobalFishWatchError>) -> Void)) {
        router.request(.postAllEvents(limit: limit, offset: offset, sort: sort, datasets: datasets, vessels: vessels, types: types, endDate: endDate, startDate: startDate, confidences: confidences, encounterTypes: encounterTypes)) { [weak self] data, response, error in
            guard let self else { return }
            DispatchQueue.main.async {
                completion(self.handleResponse(data: data, response: response, error: error))
            }
        }
    }
    
    @available(macOS 10.15.0, *)
    @available(iOS 15.0, *)
    public func allEvents(limit: Int, offset: Int, sort: EventSort?, datasets: Set<EventsApiDataSet>, vessels: [String]?, types: Set<EventType>?, endDate: Date?, startDate: Date?, confidences: [Int]?, encounterTypes: Set<EventEncounterType>?) async -> Result<EventListResponse, GlobalFishWatchError> {
        do {
            let data = try await router.request(.postAllEvents(limit: limit, offset: offset, sort: sort, datasets: datasets, vessels: vessels, types: types, endDate: endDate, startDate: startDate, confidences: confidences, encounterTypes: encounterTypes))
            return decodeResponse(data: data)
        } catch {
            return .failure(.networkFailure(error))
        }
    }
    
    // Vessel Search
    
    public func vesselSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String, suggestFields: [String]?, queryFields: [String]?, completion: @escaping ((Result<VesselSearchResponse, GlobalFishWatchError>) -> Void)) {
        router.request(
            .getVesselsSearch(limit: limit, offset: offset, datasets: datasets, query: query, suggestFields: suggestFields, queryFields: queryFields), completion: { [weak self] data, response, error in
            guard let self else { return }
            DispatchQueue.main.async {
                completion(self.handleResponse(data: data, response: response, error: error))
            }
        })
    }
    
    @available(macOS 10.15.0, *)
    @available(iOS 15.0, *)
    public func vesselSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String, suggestFields: [String]?, queryFields: [String]?) async -> Result<VesselSearchResponse, GlobalFishWatchError> {
        do {
            let data = try await router.request(.getVesselsSearch(limit: limit, offset: offset, datasets: datasets, query: query, suggestFields: suggestFields, queryFields: queryFields))
            return decodeResponse(data: data)
        } catch {
            return .failure(.networkFailure(error))
        }
    }
    
    // Vessel Advanced Search
    
    public func vesselAdvancedSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String, completion: @escaping ((Result<VesselSearchResponse, GlobalFishWatchError>) -> Void)) {
        router.request(.getVesselsAdvancedSearch(limit: limit, offset: offset, datasets: datasets, query: query), completion: { [weak self] data, response, error in
            guard let self else { return }
            DispatchQueue.main.async {
                completion(self.handleResponse(data: data, response: response, error: error))
            }
        })
    }
    
    @available(macOS 10.15.0, *)
    @available(iOS 15.0, *)
    public func vesselAdvancedSearch(limit: Int, offset: Int, datasets: Set<VesselApiDataSet>, query: String) async -> Result<VesselSearchResponse, GlobalFishWatchError> {
            do {
                let data = try await router.request(.getVesselsAdvancedSearch(limit: limit, offset: offset, datasets: datasets, query: query))
                return decodeResponse(data: data)
            } catch {
                return .failure(.networkFailure(error))
            }
    }
    
    // Vessel
    
    public func vessel(id: String, dataset: VesselApiDataSet, completion: @escaping ((Result<Vessel, GlobalFishWatchError>) -> Void)) {
        router.request(.getVesselWithID(vesselId: id, datasets: dataset), completion: { [weak self] data, response, error in
            guard let self else { return }
            DispatchQueue.main.async {
                completion(self.handleResponse(data: data, response: response, error: error))
            }
        })
    }
    
    @available(macOS 10.15.0, *)
    @available(iOS 15.0, *)
    public func vessel(id: String, dataset: VesselApiDataSet) async -> Result<Vessel, GlobalFishWatchError> {
        do {
            let data = try await router.request(.getVesselWithID(vesselId: id, datasets: dataset))
            return decodeResponse(data: data)
        } catch {
            return .failure(.networkFailure(error))
        }
    }
    
    // Vessels
    
    public func vessels(ids: [String], datasets: Set<VesselApiDataSet>, completion: @escaping ((Result<VesselSearchResponse, GlobalFishWatchError>) -> Void)) {
        router.request(.getVesselWithIDs(ids: ids, datasets: datasets), completion: { [weak self] data, response, error in
            guard let self else { return }
            DispatchQueue.main.async {
                completion(self.handleResponse(data: data, response: response, error: error))
            }
        })
    }
    
    @available(macOS 10.15.0, *)
    @available(iOS 15.0, *)
    public func vessels(ids: [String], datasets: Set<VesselApiDataSet>) async -> Result<Vessel, GlobalFishWatchError> {
        do {
            let data = try await router.request(.getVesselWithIDs(ids: ids, datasets: datasets))
            return decodeResponse(data: data)
        } catch {
            return .failure(.networkFailure(error))
        }
    }
    
    // MARK: - Private
    
    private func handleResponse<D: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<D, GlobalFishWatchError> {
        guard let _ = response as? HTTPURLResponse else {
            return .failure(.invalidResponse)
        }
        
        if let error = error {
            return .failure(.networkFailure(error))
        }
        
        guard let data else {
            return .failure(.noData)
        }
        
       return decodeResponse(data: data)
    }
    
    private func decodeResponse<D: Decodable>(data: Data) -> Result<D, GlobalFishWatchError> {
        do {
            if let errorResponse = try? decoder.decode(ResponseError.self, from: data) {
                return .failure(.responseError(errorResponse))
            } else if let decodedResponse = try? decoder.decode(APIErrorResponse.self, from: data) {
                return .failure(.apiError(decodedResponse))
            } else {
                let decodedResponse = try decoder.decode(D.self, from: data)
                return .success(decodedResponse)
            }
        } catch {
            return .failure(.decodingError(error))
        }
    }
}
