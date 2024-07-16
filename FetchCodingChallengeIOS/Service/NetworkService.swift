//
//  NetworkService.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import Foundation
class NetworkService {
    
    func validateHTTPResponse(response: URLResponse?) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else {
            print("[NetworkService] Error: Invalid response received from server")
            return false
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            print("[NetworkService] Error: Server returned status code \(httpResponse.statusCode)")
            return false
        }
        return true
    }
    
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard validateHTTPResponse(response: response) else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
