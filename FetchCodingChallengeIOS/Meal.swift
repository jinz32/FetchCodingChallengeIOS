//
//  Meal.swift
//  FetchCodingChallengeIOS
//
//  Created by Jonathan Zheng on 7/15/24.
//

import Foundation

struct Meal: Identifiable, Decodable, Hashable {
    var id: String { idMeal }
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
    var ingredients: [Ingredient] = []
    var strInstructions: String?
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
        case strInstructions
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
        case strinstructions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        
        // Extract ingredients dynamically
        var ingredientsArray: [Ingredient] = []
        for index in 1...20 {
            if let ingredientKey = CodingKeys(rawValue: "strIngredient\(index)"),
               let measureKey = CodingKeys(rawValue: "strMeasure\(index)"),
               let ingredientName = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try container.decodeIfPresent(String.self, forKey: measureKey),
               !ingredientName.isEmpty {
                let ingredient = Ingredient(idIngredient: "\(index)", strIngredient: ingredientName, strMeasure: measure)
                ingredientsArray.append(ingredient)
            }
        }
        ingredients = ingredientsArray
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
    }
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.idMeal == rhs.idMeal
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idMeal)
    }
}

struct Ingredient: Identifiable, Decodable {
    var id: String { idIngredient }
    
    var idIngredient: String
    var strIngredient: String
    var strMeasure: String
    
    enum CodingKeys: String, CodingKey {
        case idIngredient
        case strIngredient
        case strMeasure
    }
}
