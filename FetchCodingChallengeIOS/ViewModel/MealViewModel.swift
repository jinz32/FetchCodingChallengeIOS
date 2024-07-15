//
//  MealViewModel.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import Foundation
class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
       @Published var errorMessage: String?
       private let mealService = MealService()
       
       func fetchMeals() {
           Task {
               do {
                   let fetchedMeals = try await mealService.fetchMeals()
                   
                   DispatchQueue.main.async {
                       self.meals = fetchedMeals
                   }
               } catch {
                   DispatchQueue.main.async {
                       self.errorMessage = error.localizedDescription
                   }
               }
           }
       }
       
       func sortMealsAlphabetically() {
           meals.sort { $0.strMeal < $1.strMeal }
       }
   }
