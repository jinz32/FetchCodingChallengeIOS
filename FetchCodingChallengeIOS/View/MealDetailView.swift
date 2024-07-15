//
//  MealDetailView.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel = MealDetailViewModel()
    let mealId: String
    let mealName: String
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if viewModel.isError {
                Text("Failed to load meal details.")
                    .foregroundColor(.red)
                    .padding()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions:")
                            .font(.headline)
                            .padding(.top)
                        Text(viewModel.instructions)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                        Text("Ingredients:")
                            .font(.headline)
                        
                        ForEach(viewModel.ingredients) { ingredient in
                            Text("\(ingredient.strIngredient) - \(ingredient.strMeasure )")
                                .font(.body)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(mealName)
        .onAppear {
            viewModel.fetchIngredients(forMealId: mealId)
        }
    }
}
