//
//  MealDetailView.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import SwiftUI

struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel
    
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                loadingView
            } else if viewModel.isError {
                errorView
            } else {
                mealDetailView
            }
        }
        .navigationBarTitle(viewModel.mealName, displayMode: .inline)
        .onAppear {
            viewModel.fetchIngredients(forMealId: viewModel.idMeal)
        }
    }
    
    private var loadingView: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
    }
    
    private var errorView: some View {
        Text("Failed to load meal details.")
            .foregroundColor(.red)
            .padding()
    }
    
    private var mealDetailView: some View {
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
