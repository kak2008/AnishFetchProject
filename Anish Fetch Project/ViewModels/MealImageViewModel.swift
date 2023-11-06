//
//  MealImageViewModel.swift
//  Anish Fetch Project
//
//  Created by Anish Kodeboyina on 11/5/23.
//

import Foundation
import SwiftUI

class MealImageViewModel: ObservableObject  {
    let urlString: String
    let imageFrame: ImageFrame
    @Published var image: UIImage?
    
    init(urlString: String, imageFrame: ImageFrame = ImageFrame(width: 120, height: 80)) {
        self.urlString = urlString
        self.imageFrame = imageFrame
    }
    
    func fetchImageData() {
        if let url = URL(string: urlString) {
            do {
                Task {
                    let image = try await UIImageStore().getCachedImage(url: url)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
