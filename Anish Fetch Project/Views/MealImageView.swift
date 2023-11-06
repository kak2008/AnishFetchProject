//
//  MealImageView.swift
//  Anish Fetch Project
//
//  Created by Anish Kodeboyina on 11/4/23.
//

import Foundation
import SwiftUI

struct MealImageView: View {

    @StateObject var viewModel: MealImageViewModel
    
    var body: some View {
        if let uiimage = viewModel.image {
            Image(uiImage: uiimage)
                .resizable()
                .frame(width: viewModel.imageFrame.width, height: viewModel.imageFrame.height)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
        } else {
            Image(systemName: "photo")
                .resizable()
                .frame(width: 120, height: 80)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .onAppear {
                    viewModel.fetchImageData()
                }
        }
    }
}
