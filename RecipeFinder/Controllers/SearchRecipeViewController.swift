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
    var searchController: UISearchController?
    let datasSource = SearchRecipesDataSource()
    let client = EdamamClient()
    
    // MARK: - Lazy Variables -
    lazy var flowLayoutDelegate: SearchRecipeCollectionFlowDelegate = {
        return SearchRecipeCollectionFlowDelegate(forView: self.collectionView!)
    }()

    // MARK: - View Controller Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupCollectionView()
        setupToolbarLogo()
        
        self.definesPresentationContext = true
    }
    
    // MARK: - Setup -
    func setupCollectionView() {
        collectionView!.dataSource = datasSource
        collectionView!.delegate = flowLayoutDelegate
    }
    
    func setupSearchController() {
//        self.searchController = UISearchController(searchResultsController: nil)
//
//        if let searchController = self.searchController {
//            searchController.searchResultsUpdater = self
//            searchController.searchBar.delegate = self
//            searchController.delegate = self
//
//            searchController.hidesNavigationBarDuringPresentation = false
//            searchController.dimsBackgroundDuringPresentation = false
//            searchController.obscuresBackgroundDuringPresentation = false
//
////            searchController.searchBar.becomeFirstResponder()
//
//            self.navigationItem.titleView = searchController.searchBar
//        }
        
        
    }
    
    func setupToolbarLogo() {
        if let logo = UIImage(named: "edamam.png")?.withRenderingMode(.alwaysOriginal) {
            navigationController?.isToolbarHidden = false
            var items = [UIBarButtonItem]()
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            items.append(UIBarButtonItem(image: logo, style: .plain, target: nil, action: nil))
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))

            toolbarItems = items
        }
    }
}

// MARK: - Search Results Updating -
extension SearchRecipeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension SearchRecipeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchController?.searchBar.text, text.characters.count > 3 {
            client.search(withTerm: text.lowercased()) { [weak self] result in
                
                switch result {
                case .success(let recipes):
                    self?.datasSource.update(with: recipes)
                    self?.collectionView?.reloadData()
                case .failure(let error):
                    print("here: \(error)")
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchRecipeViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}
