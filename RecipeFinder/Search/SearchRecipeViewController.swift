//
//  SearchRecipeViewController.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/19/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UIViewController {

    // MARK: - Constants -
    let client = EdamamClient()
    
    // MARK: - Variables -
    var searchController: UISearchController!
    
    // MARK: - IBOutlets -
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarPlaceholder: UIView!
    
    // MARK: - Lazy Variables -
    lazy var flowLayoutDelegate: SearchRecipeCollectionFlowDelegate = {
        return SearchRecipeCollectionFlowDelegate(forView: self.collectionView)
    }()
    
    lazy var dataSource: SearchRecipesDataSource = {
        return SearchRecipesDataSource(collectionView: self.collectionView)
    }()

    // MARK: - View Controller Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        
        setupSearchBar()
        setupCollectionView()
        setupToolbarLogo()
    }
    
    // MARK: - Setup -
    func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchBarPlaceholder.addSubview(searchController.searchBar)
        automaticallyAdjustsScrollViewInsets = false
        definesPresentationContext = true
    }
    
    func setupCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = flowLayoutDelegate
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

// MARK: - Search Bar Delegate -
extension SearchRecipeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        activityIndicator.startAnimating()
        if let text = searchBar.text, text.characters.count > 3 {
            client.search(withTerm: text.lowercased()) { [weak self] result in
                
                switch result {
                case .success(let recipes):
                    self?.dataSource.update(with: recipes)
                    self?.activityIndicator.stopAnimating()
                    self?.collectionView?.reloadData()
                case .failure(let error):
                    self?.activityIndicator.stopAnimating()
                    print("here: \(error)")
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = false
    }
}

// MARK: - Search Controller Delegate -
extension SearchRecipeViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = false
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = false
    }
}

// MARK: - Navigation -
extension SearchRecipeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.collectionView?.indexPath(for: (sender as! UICollectionViewCell)) {
            if segue.identifier == "showRecipeDetail" {
                let recipe = dataSource.object(at: indexPath)
                let recipeDetailVC = segue.destination as! RecipeDetailViewController
                recipeDetailVC.recipe = recipe
                recipeDetailVC.dataSource.update(with: recipe.ingredients)
            }
        }
    }
}


