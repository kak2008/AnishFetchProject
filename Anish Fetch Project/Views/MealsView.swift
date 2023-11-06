//
//  MealsView.swift
//  Anish Fetch Project
//
//  Created by Anish Kodeboyina on 11/4/23.
//

import Foundation
import SwiftUI

struct MealsView: View {
    
    @StateObject var viewModel = MealsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.meals, id: \.self) { meal in
                    NavigationLink {
                        MealDetailView(viewModel: MealDetailViewModel(meal: meal))
                    } label: {
                        HStack {
                            MealImageView(viewModel: MealImageViewModel(urlString: meal.strMealThumb))
                            VStack(alignment: .leading, spacing: 10) {
                                Text(meal.strMeal)
                                    .bold()
                                Text(meal.idMeal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Desserts")
        }
        .onAppear {
            viewModel.fetchMeals()
        }
    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView()
    }
}
