//
//  SearchRecipesDataSource.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/19/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class SearchRecipesDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - Variables -
    private var data = [Recipe]()
    
    // MARK: - Constants -
    let pendingOperations = PendingOperations()
    let collectionView: UICollectionView
    
    // MARK: - Init -
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
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
            
            if recipe.artworkState == .placeholder {
                downloadImageForRecipe(recipe, atIndexPath: indexPath)
            }
            
            return recipeCell
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: - Helper -
    func object(at indexPath: IndexPath) -> Recipe {
        return data[indexPath.row]
    }
    
    func update(with data: [Recipe]) {
        self.data = data
    }
    
    func update(_ object: Recipe, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
    func downloadImageForRecipe(_ recipe: Recipe, atIndexPath indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
        let downloader = ImageDownloader(recipe: recipe)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.collectionView.reloadItems(at: [indexPath])
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}
