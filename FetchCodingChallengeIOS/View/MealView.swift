//
//  MealView.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import SwiftUI

struct MealView: View {
    @ObservedObject private var viewModel = MealViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal, mealName: meal.strMeal)) {
                    HStack {
                        if let url = URL(string: meal.strMealThumb) {
                            AsyncImage(url: url)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        Text(meal.strMeal)
                    }
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchMeals()
                viewModel.sortMealsAlphabetically()
            }
        }
    }
}


#Preview {
    MealView()
}
