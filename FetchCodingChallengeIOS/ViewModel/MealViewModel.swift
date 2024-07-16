//
//  MealViewModel.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import Foundation
class MealViewModel: ObservableObject {
    var meals: [Meal] = []
    var errorMessage: String?
    @Published var isLoading = true
    
    private let mealService = MealService()
    
    func fetchMeals() {
        isLoading = true
        Task {
            do {
                let fetchedMeals = try await mealService.fetchMeals()
                let sortedMeals = fetchedMeals.sorted { $0.strMeal < $1.strMeal }
                DispatchQueue.main.async {
                    self.errorMessage = nil
                    self.meals = sortedMeals
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
