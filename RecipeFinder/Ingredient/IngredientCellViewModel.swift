//
//  IngredientCellViewModel.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/22/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import Foundation

struct IngredientCellViewModel {
    let ingredient: String
}

extension IngredientCellViewModel {
    init(ingredient: Ingredient) {
        self.ingredient = ingredient.ingredient
    }
}
