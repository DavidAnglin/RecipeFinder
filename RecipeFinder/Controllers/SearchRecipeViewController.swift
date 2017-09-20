//
//  SearchRecipeViewController.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/19/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UICollectionViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    let datasSource = SearchRecipesDataSource()
    lazy var flowLayoutDelegate: SearchRecipeCollectionFlowDelegate = {
        return SearchRecipeCollectionFlowDelegate(forView: self.collectionView!)
    }()
    
//    let client = EdamamAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        
        self.definesPresentationContext = true
        
        collectionView!.dataSource = datasSource
        collectionView!.delegate = flowLayoutDelegate
    }
    
    @objc func dismissSearchRecipeController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupSearchController() {
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.titleView = searchController.searchBar
        
        searchController.searchBar.becomeFirstResponder()
    }
}

extension SearchRecipeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
       
    }
}
