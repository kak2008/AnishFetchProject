//
//  MealDetailViewModel.swift
//  Anish Fetch Project
//
//  Created by Anish Kodeboyina on 11/5/23.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    
    let meal: Meal
    @Published var mealsInfo: [[String: String?]] = [[:]]
    
    var ingredients: [String] = []
    var measurements: [String] = []
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    func fetchMealDetails() {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)"
        if let mealUrl = URL(string: urlString) {
            let urlReqest = URLRequest(url: mealUrl)
            let task = URLSession.shared.dataTask(with: urlReqest) { [weak self] data, response, error in
                if error == nil, let data = data, let self = self {
                    do {
                        let data = try JSONDecoder().decode(MealDetail.self, from: data)
                        DispatchQueue.main.async {
                            self.mealsInfo = data.meals
                            self.extractMealsInfo(from: self.mealsInfo)
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func extractMealsInfo(from mealsInfo: [[String: String?]]) {
        if let meal = mealsInfo.first {
            var allIngredients: [String : String] = [:]
            var allMeasurements: [String : String] = [:]
            
            for (key, value) in meal {
                if key.contains("strIngredient"), let value = value, !value.isEmpty {
                    allIngredients.updateValue(value, forKey: key)
                }
                
                if key.contains("strMeasure"), let value = value, !value.isEmpty, value != " " {
                    allMeasurements.updateValue(value, forKey: key)
                }
            }
                                
            let sortedIngredients = allIngredients.sorted(by: { $0.0 < $1.0})
            let sortedMeasurements = allMeasurements.sorted(by: { $0.0 < $1.0})
            
            self.ingredients = Array(sortedIngredients.map({ $0.value }))
            self.measurements = Array(sortedMeasurements.map({ $0.value }))
        }
    }
}
