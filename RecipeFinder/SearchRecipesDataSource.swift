//
//  SearchRecipesDataSource.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/19/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class SearchRecipesDataSource: NSObject, UICollectionViewDataSource {
    
    
    override init() {
        super.init()
    }
    
    // MARK: - Data Source -

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeResultCell.reuseIdentifier, for: indexPath) as? RecipeResultCell {
            return cell
        }
        return UICollectionViewCell()
    }
}
