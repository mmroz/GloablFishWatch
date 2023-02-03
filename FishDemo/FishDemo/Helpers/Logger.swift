//
//  Logger.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-02-02.
//

import Foundation
import GlobalFishWatch

struct Logger {
    static func write<T: Encodable>(response: Result<T, GlobalFishWatchError>) -> String {
        switch response {
        case .success(let success):
            return describe(success)
        case .failure(.apiError(let error)):
            return describe(error)
        case .failure(.noData):
            return "No Data"
        case .failure(.encodingError(let error)):
            return "Encoding error: \(error.localizedDescription)"
        case .failure(.decodingError(let error)):
            return "Decoding error: \(error.localizedDescription)"
        case .failure(.networkFailure(let error)):
            return "Networking error: \(error.localizedDescription)"
        case .failure(.responseError(let error)):
            return describe(error)
        case .failure(.invalidResponse):
            return "Invalid Response"
        }
    }
    
    private static func describe(_ codable: Encodable) -> String {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(codable)
        return String(data: data ?? Data(), encoding: .utf8) ?? ""
    }
}
