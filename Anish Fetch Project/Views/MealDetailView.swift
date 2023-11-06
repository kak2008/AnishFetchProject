//
//  MealDetailView.swift
//  Anish Fetch Project
//
//  Created by Anish Kodeboyina on 11/5/23.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    @StateObject var viewModel: MealDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Spacer()
                    MealImageView(viewModel: MealImageViewModel(urlString: viewModel.meal.strMealThumb, imageFrame: ImageFrame(width: 300, height: 225)))
                    Spacer()
                }
                HStack(alignment: .center) {
                    Spacer()
                    Text(viewModel.meal.strMeal)
                        .bold()
                    Spacer()
                }
                if let meal = viewModel.mealsInfo.first, let strInstructions = meal["strInstructions"] {
                    Text("Instructions:")
                        .bold()
                        .padding([.leading, .top, .trailing])
                        .frame(alignment: .leading)
                    Text(strInstructions ?? "")
                        .padding([.leading, .bottom, .trailing])
                }
                Text("Ingredients:")
                    .bold()
                    .padding([.leading, .top, .trailing])
                    .frame(alignment: .leading)
                
                ForEach(Array(viewModel.ingredients.enumerated()), id: \.offset) { index, element in
                    Text("\(element.capitalized): \(viewModel.measurements[index])")
                        .padding([.leading])
                }
            }.onAppear{
                viewModel.fetchMealDetails()
            }
        }.navigationTitle("Dessert")
    }
}
