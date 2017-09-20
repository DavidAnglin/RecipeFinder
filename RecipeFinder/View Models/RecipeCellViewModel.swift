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
    
//    let recipeImage: UIImage
    let recipeNameLabel: String
    let calorieCountLabel: String
    let ingredientCountLabel: String
}

extension RecipeCellViewModel {
    init(recipe: Recipe) {

        // TODO: - Do Recipe Image -
        self.recipeNameLabel = recipe.recipeName
        
        let calories = recipe.calories
        let servingCount = recipe.servings
        
        self.calorieCountLabel = String(calories/servingCount)
        self.ingredientCountLabel = String(recipe.servings)
        
    }
}


