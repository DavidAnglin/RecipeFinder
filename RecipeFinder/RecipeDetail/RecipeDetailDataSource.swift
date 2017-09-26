//
//  RecipeDetailDataSource.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/20/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class RecipeDetailDataSource: NSObject, UITableViewDataSource {

    // MARK: - Stored Properties -
    var ingredientData: [Ingredient]
    
    // MARK: - Init -
    init(ingredientData: [Ingredient]) {
        self.ingredientData = ingredientData
    }
    
    // MARK: - Data Source -
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.reuseIdentifier, for: indexPath) as? IngredientCell {
            let ingredient = object(at: indexPath)
            let viewModel = IngredientCellViewModel(ingredient: ingredient)
            
            cell.configure(with: viewModel)
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ingredients"
    }
    
    // MARK: - Helpers -
    func update(with ingredients: [Ingredient]) {
        self.ingredientData = ingredients
    }
    
    func object(at indexPath: IndexPath) -> Ingredient {
        return ingredientData[indexPath.row]
    }
}
