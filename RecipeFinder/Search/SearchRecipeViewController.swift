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
    let client = EdamamClient()
    
    // MARK: - IBOutlets -
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    // MARK: - Lazy Variables -
    lazy var flowLayoutDelegate: SearchRecipeCollectionFlowDelegate = {
        return SearchRecipeCollectionFlowDelegate(forView: self.collectionView!)
    }()

    // MARK: - View Controller Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        
        setupSearchController()
        setupCollectionView()
        setupToolbarLogo()
        
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
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search For Recipes"
        self.navigationItem.titleView = searchController.searchBar
        
        searchController.searchBar.becomeFirstResponder()
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

// MARK: - Search Delegate -
extension SearchRecipeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        activityIndicator.startAnimating()
        if let text = searchController.searchBar.text, text.characters.count > 3 {
            client.search(withTerm: text.lowercased()) { [weak self] result in
                
                switch result {
                case .success(let recipes):
                    self?.datasSource.update(with: recipes)
                    self?.activityIndicator.stopAnimating()
                    self?.collectionView?.reloadData()
                case .failure(let error):
                    self?.activityIndicator.stopAnimating()
                    print("here: \(error)")
                }
            }
        }
    }
}

// MARK: - Navigation -
extension SearchRecipeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.collectionView?.indexPath(for: (sender as! UICollectionViewCell)) {
            if segue.identifier == "showRecipeDetail" {
                let recipe = datasSource.object(at: indexPath)
                let recipeDetailVC = segue.destination as! RecipeDetailViewController
                recipeDetailVC.recipe = recipe
                recipeDetailVC.dataSource.updateData(recipe.ingredients)
            }
        }
    }
}


