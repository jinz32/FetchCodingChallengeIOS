//
//  MealService.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import Foundation
class MealService {
    
    func fetchMeals () async throws -> [Meal] {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else{
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(Response.self, from: data)
            if let meals = result.meals {
                return meals
            } else {
                return []
            }
        } catch {
            throw error
        }
    }
}


class DetailMealService {
    
    func fetchMealDetails(forMealId mealId: String) async throws -> Meal {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let meal = try JSONDecoder().decode(Response.self, from: data).meals?.first
            if let meal = meal {
                return meal
            } else {
                throw NSError(domain: "DetailMealService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Meal not found"])
            }
        } catch {
            throw error
        }
    }
}

struct Response: Decodable {
    let meals: [Meal]?
}
