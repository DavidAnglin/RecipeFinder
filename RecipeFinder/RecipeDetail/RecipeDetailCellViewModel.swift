//
//  RecipeDetailCellViewModel.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/20/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import Foundation
import UIKit

struct RecipeDetailCellViewModel {
    
    let recipeImage: UIImage
    let recipeLabel: String
    let recipeLink: NSAttributedString
    let calorieLabel: String
    let servingLabel: String
}

extension RecipeDetailCellViewModel {
    init?(recipe: Recipe) {
        
        self.recipeImage = recipe.artworkState == .downloaded ? recipe.recipeImage! : #imageLiteral(resourceName: "chickenFingers")
        self.recipeLabel = recipe.recipeName
        
        let text = recipe.recipeSource
        let attributedRecipe = NSAttributedString(string: text, attributes:
            [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        self.recipeLink =  attributedRecipe
        
        let calories = Int(recipe.calories)
        self.calorieLabel = String(calories/recipe.servings)
        self.servingLabel = String(recipe.servings)
    }
}

