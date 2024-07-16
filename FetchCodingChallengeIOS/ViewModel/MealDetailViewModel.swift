//
//  MealDetailViewModel.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import Foundation
import Combine

class MealDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    
    private let ingredientsService = DetailMealService()
    var isError: Bool = false
    var mealName: String
    var idMeal: String
    var instructions: String = ""
    var ingredients: [Ingredient] = []
    
    init(idMeal: String, mealName: String){
        self.idMeal = idMeal
        self.mealName = mealName
    }
    
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
