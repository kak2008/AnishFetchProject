//
//  MealsViewModel.swift
//  Anish Fetch Project
//
//  Created by Anish Kodeboyina on 11/4/23.
//

import Foundation

class MealsViewModel: ObservableObject {
    
    @Published var meals: [Meal] = []
    
    let mealsUrl = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    func fetchMeals() {
        if let url = URL(string: mealsUrl) {
            let urlRequest = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard error == nil, let data = data, let self = self else {
                    return
                }
                
                do {
                    let mealsInfo = try JSONDecoder().decode(Meals.self, from: data)
                    DispatchQueue.main.async {
                        self.meals = mealsInfo.meals
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}
