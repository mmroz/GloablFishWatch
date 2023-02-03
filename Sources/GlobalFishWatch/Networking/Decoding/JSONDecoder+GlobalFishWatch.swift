//
//  JSONDecoder+GlobalFishWatch.swift
//  
//
//  Created by Mark Mroz on 2023-02-11.
//

import Foundation

extension JSONDecoder {
    private static var shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        return formatter
    }()

    private static var longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()

    private static var longDateFormatterWithoutSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()

    static var globalFishWatchDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .anyFormatter(in: [shortDateFormatter, longDateFormatter, longDateFormatterWithoutSeconds])
        return decoder
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static func anyFormatter(in formatters: [DateFormatter]) -> Self {
        return .custom { decoder in
          guard formatters.count > 0 else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "No date formatter provided"))
          }
          
          guard let dateString = try? decoder.singleValueContainer().decode(String.self) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date string"))
          }
          
          let successfullyFormattedDates = formatters.lazy.compactMap { $0.date(from: dateString) }
          guard let date = successfullyFormattedDates.first else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Date string \"\(dateString)\" does not match any of the expected formats (\(formatters.compactMap(\.dateFormat).joined(separator: " or ")))"))
          }
          
          return date
        }
      }
}
