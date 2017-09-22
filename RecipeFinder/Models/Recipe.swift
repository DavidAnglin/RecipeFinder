//
//  Recipe.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/20/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import Foundation

class Recipe: NSObject, JSONDecodable {
    
    let recipeName: String
    let recipeImageURLString: String
    let recipeSource: String
    let recipeSourceURLString: String
    let calories: Double
    let servings: Int
    let ingredients: [Ingredient]
    
    required init?(json: [String : Any]) {
        guard let recipe = json["recipe"] as? [String: Any],
            let recipeName = recipe["label"] as? String,
            let recipeImageURLString = recipe["image"] as? String,
            let recipeSource = recipe["source"] as? String,
            let recipeSourceURLString = recipe["url"] as? String,
            let calories = recipe["calories"] as? Double,
            let servings = recipe["yield"] as? Int,
            let ingredientArray = recipe["ingredientLines"] as? [String] else { return nil }
        
        self.recipeName = recipeName
        self.recipeImageURLString = recipeImageURLString
        self.recipeSource = recipeSource
        self.recipeSourceURLString = recipeSourceURLString
        self.calories = calories
        self.servings = servings
        self.ingredients = ingredientArray.flatMap { Ingredient(withIngredient: $0) }
        
        super.init()
    }
}
