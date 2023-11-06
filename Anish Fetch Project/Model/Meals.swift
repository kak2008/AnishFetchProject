//
//  Meals.swift
//  Anish Fetch Project
//
//  Created by Anish Kodeboyina on 11/4/23.
//

import Foundation

// MARK: - Meals
struct Meals: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
