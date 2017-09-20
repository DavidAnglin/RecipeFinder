//
//  RecipeResultCell.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/19/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class RecipeResultCell: UICollectionViewCell {
    
    // MARK: - Constants -
    static let reuseIdentifier = "RecipeResult"
    
    // MARK: - IBOutlets -
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var calorieCountLabel: UILabel!
    @IBOutlet weak var ingredientCountLabel: UILabel!
    
    func configure(with viewModel: RecipeCellViewModel) {
//        recipeImage.image = viewModel.recipeImage
        recipeNameLabel.text = viewModel.recipeNameLabel
        calorieCountLabel.text = viewModel.calorieCountLabel
        ingredientCountLabel.text = viewModel.ingredientCountLabel
    }
}
