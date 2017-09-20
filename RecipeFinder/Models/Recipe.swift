//
//  Recipe.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/20/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import Foundation

class Recipe: JSONDecodable {
    
    let recipeName: String
    let recipeImageURLString: String
    let recipeSource: String
    let recipeSourceURLString: String
    let calories: Int
    let servings: Int
    let ingredients: Ingredients
    
    required init?(json: [String : Any]) {
        guard let recipeName = json["label"] as? String,
            let recipeImageURLString = json["image"] as? String,
            let recipeSource = json["source"] as? String,
            let recipeSourceURLString = json["url"] as? String,
            let calories = json["calories"] as? Int,
            let servings = json["yield"] as? Int,
            let ingredientArray = json["ingredientLines"] as? [String] else { return nil }
        
        self.recipeName = recipeName
        self.recipeImageURLString = recipeImageURLString
        self.recipeSource = recipeSource
        self.recipeSourceURLString = recipeSourceURLString
        self.calories = calories
        self.servings = servings
        self.ingredients = Ingredients(withIngredients: ingredientArray)
    }
}
