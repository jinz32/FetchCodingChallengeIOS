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
            content()
                .navigationBarTitle("Desserts")
                .onAppear {
                    viewModel.fetchMeals()
                }
        }
    }
    
    private func content() -> some View {
        Group {
            if viewModel.isLoading {
                loadingView()
            } else if let errorMessage = viewModel.errorMessage {
                errorView(message: errorMessage)
            } else {
                mealsListView()
            }
        }
    }
    
    private func loadingView() -> some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.5, anchor: .center)
    }
    
    private func errorView(message: String) -> some View {
        Text(message)
            .foregroundColor(.red)
    }
    
    private func mealsListView() -> some View {
        List(viewModel.meals) { meal in
            NavigationLink(destination: MealDetailView(viewModel: MealDetailViewModel(idMeal: meal.idMeal, mealName: meal.strMeal))) {
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
    }
}
