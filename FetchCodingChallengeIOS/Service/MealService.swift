//
//  MealService.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import Foundation

class MealService: NetworkService {
    
    func fetchMeals() async throws -> [Meal] {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        guard let url = URL(string: urlString) else {
            print("[MealService] Error: Invalid URL")
            throw NetworkError.invalidURL
        }
        do {
            let data = try await fetchData(from: url)
            let result = try JSONDecoder().decode(Response.self, from: data)
            guard let meals = result.meals else {
                print("[MealService] Error: No meals found in response")
                throw NetworkError.decodeFailed
            }
            return meals
        } catch {
            print("[MealService] Error fetching or decoding meals: \(error.localizedDescription)")
            throw error
        }
    }
}
