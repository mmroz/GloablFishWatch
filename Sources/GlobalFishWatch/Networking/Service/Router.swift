//
//  Router.swift
//  
//
//  Created by Mark Mroz on 2023-01-14.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
}

public class Router<EndPoint: EndPointType>: NetworkRouter {
    
    // MARK: - Private Properties
    private let timeoutInterval: Double
    private let cachingPolicy: NSURLRequest.CachePolicy
    private var task: URLSessionTask?
    private let headers: [String: String]
    
    init(timeoutInterval: Double = 30.0, cachingPolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy, headers: [String: String]) {
        self.timeoutInterval = timeoutInterval
        self.cachingPolicy = cachingPolicy
        self.headers = headers
    }
    
    // MARK: - Public Methods
    
    @available(macOS 10.15.0, *)
    @available(iOS 15.0, *)
    func request(_ route: EndPoint) async throws -> Data {
           let (data, _) = try await URLSession.shared.data(for: buildRequest(from: route))
           return data
    }
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: completion)
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    // MARK: - Public Methods
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(
            url: route.baseURL.appendingPathComponent(route.path),
            cachePolicy: cachingPolicy,
            timeoutInterval: timeoutInterval
        )
        
        request.httpMethod = route.httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        switch route.task {
        case .requestWithParameters(let urlParameters, let encoding):
            try encoding.encode(urlRequest: &request, with: urlParameters)
        case .requestWithUrlAndBodyParameters(urlParameters: let urlParameters, urlParameterEncoding: let urlParameterEncoding, bodyParameters: let bodyParameters, bodyEncoding: let bodyEncoding):
            try urlParameterEncoding.encode(urlRequest: &request, with: urlParameters)
            try bodyEncoding.encode(urlRequest: &request, with: bodyParameters)
        }

        return request
    }
}
