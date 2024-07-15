//
//  MealDetailViewModel.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import Foundation
import Combine

class MealDetailViewModel: ObservableObject {
    private let ingredientsService = DetailMealService()
    
    @Published var ingredients: [Ingredient] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var mealName: String = ""
    @Published var instructions: String = ""

    @MainActor
    func fetchIngredients(forMealId mealId: String) {
        Task {
            do {
                isLoading = true
                let fetchedMeal = try await ingredientsService.fetchMealDetails(forMealId: mealId)
                
                DispatchQueue.main.async {
                    self.instructions = fetchedMeal.strInstructions ?? ""
                    self.ingredients = fetchedMeal.ingredients
                    self.isLoading = false
                    self.isError = false
                }
            } catch {
                print("Error fetching ingredients: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isError = true
                }
            }
        }
    }
}
