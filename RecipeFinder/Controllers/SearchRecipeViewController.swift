//
//  SearchRecipeViewController.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/19/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UICollectionViewController {

    // MARK: - Constants -
    let searchController = UISearchController(searchResultsController: nil)
    let datasSource = SearchRecipesDataSource()
    
    // MARK: - Lazy Variables -
    lazy var flowLayoutDelegate: SearchRecipeCollectionFlowDelegate = {
        return SearchRecipeCollectionFlowDelegate(forView: self.collectionView!)
    }()
    
//    let client = EdamamAPIClient()
    
    // MARK: - View Controller Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupCollectionView()
        
        self.definesPresentationContext = true
    }
    
    @objc func dismissSearchRecipeController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Setup -
    func setupCollectionView() {
        collectionView!.dataSource = datasSource
        collectionView!.delegate = flowLayoutDelegate
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

// MARK: - Search Results Updating -
extension SearchRecipeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
       
    }
}
