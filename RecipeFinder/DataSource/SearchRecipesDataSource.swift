//
//  SearchRecipesDataSource.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/19/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class SearchRecipesDataSource: NSObject, UICollectionViewDataSource {
    
    private var data = [Recipe]()
    
    override init() {
        super.init()
    }
    
    // MARK: - Data Source -

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let recipeCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeResultCell.reuseIdentifier, for: indexPath) as? RecipeResultCell {
            let recipe = data[indexPath.row]
            let viewModel = RecipeCellViewModel(recipe: recipe)
            
            recipeCell.configure(with: viewModel)
            
            return recipeCell
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: - Helper -
    func update(with data: [Recipe]) {
        self.data = data
    }
    
    func recipe(at indexPath: IndexPath) -> Recipe {
        return data[indexPath.row]
    }
}
