//
//  RecipeCellViewModel.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/20/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import Foundation
import UIKit

struct RecipeCellViewModel {
    
    let recipeImage: UIImage
    let recipeNameLabel: String
    let calorieCountLabel: String
    let ingredientCountLabel: String
}

extension RecipeCellViewModel {
    init(recipe: Recipe) {

        self.recipeImage = recipe.artworkState == .downloaded ? recipe.recipeImage! : #imageLiteral(resourceName: "chickenFingers")
        self.recipeNameLabel = recipe.recipeName
        
        let calories = Int(recipe.calories)
        let servingCount = recipe.servings
        
        self.calorieCountLabel = String(calories/servingCount)
        self.ingredientCountLabel = String(recipe.servings)
    }
}


