//
//  ImageDownloader.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/26/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader: Operation {
    
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: recipe.recipeImageURLString) else {
            return
        }
        
        do {
            let imageData = try Data(contentsOf: url)
            
            if self.isCancelled {
                return
            }
            
            if imageData.count > 0 {
                recipe.recipeImage = UIImage(data: imageData)
                recipe.artworkState = .downloaded
            } else {
                recipe.artworkState = .failed
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
