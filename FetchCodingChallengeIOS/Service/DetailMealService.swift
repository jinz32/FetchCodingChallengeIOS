//
//  DetailMealService.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import Foundation


class DetailMealService: NetworkService {
    
    func fetchMealDetails(forMealId mealId: String) async throws -> Meal {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
        
        guard let url = URL(string: urlString) else {
            print("[DetailMealService] Error: Invalid URL")
            throw NetworkError.invalidURL
        }
        do {
            let data = try await fetchData(from: url)
            let result = try JSONDecoder().decode(Response.self, from: data)
            guard let meal = result.meals?.first else { throw NetworkError.invalidResponse }
            return meal
        } catch {
            print("[DetailMealService] Error fetching or decoding meal details: \(error.localizedDescription)")
            throw error
        }
    }
}
