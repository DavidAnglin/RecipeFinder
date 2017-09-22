//
//  IngredientCell.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/20/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {

    static let reuseIdentifier = "IngredientCell"
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    func configure(with viewModel: IngredientCellViewModel) {
        ingredientLabel.text = viewModel.ingredient
    }
}
