//
//  RecipeDetailViewController.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/20/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UITableViewController {

    // MARK: - Variables -
    var recipe: Recipe?
    var recipeURL: URL?
    
    // MARK: - Constants -
    let pendingOperations = PendingOperations()
    
    // MARK: - IBOutlets -
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeLink: UIButton!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var servingLabel: UILabel!
    
    // MARK: - IBActions -
    @IBAction func goToFullRecipe(_ sender: UIButton) {
        if let recipeURL = recipe?.recipeSourceURLString {
            self.recipeURL = URL(string: recipeURL)
        } else {
            // TODO: Add Alert Message
        }
    }
    
    // MARK: - Lazy Variables -
    lazy var dataSource: RecipeDetailDataSource = {
        return RecipeDetailDataSource(ingredientData: [])
    }()
    
    // MARK: - View Controller Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupToolbarLogo()
        
        if let recipe = recipe, let viewModel = RecipeDetailCellViewModel(recipe: recipe) {
            configure(with: viewModel)
        }
    }
    
    // MARK: - Setup -
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
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
    
    // MARK: - Configure Header View -
    func configure(with viewModel: RecipeDetailCellViewModel) {
        
        recipeLabel.text = viewModel.recipeLabel
        recipeLink.setTitleColor(UIColor.white, for: .normal)
        recipeLink.setAttributedTitle(viewModel.recipeLink, for: .normal)
        calorieLabel.text = viewModel.calorieLabel
        servingLabel.text = viewModel.servingLabel

        if recipe?.artworkState == .placeholder {
            downloadImageForRecipe(recipe!, inView: recipeImage)
        } else {
            recipeImage.image = recipe?.recipeImage
        }
    }
    
    // MARK: - Download Image -
    func downloadImageForRecipe(_ recipe: Recipe, inView view: UIImageView) {
        if let _ = pendingOperations.downloadsInRecipeDetailView[view] {
            return
        }
        
        let downloader = ImageDownloader(recipe: recipe)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInRecipeDetailView.removeValue(forKey: view)
                self.recipeImage.image = recipe.recipeImage
            }
        }
        
        pendingOperations.downloadsInRecipeDetailView[view] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}

// MARK: - TableView Delegate -
extension RecipeDetailViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont(name: "System", size: 20.0)
        header?.textLabel?.textAlignment = .left
        header?.textLabel?.textColor = UIColor.white
    }
}

// MARK: - Navigation -
extension RecipeDetailViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebRecipe" {
            let webViewReipeVC = segue.destination as! RecipeWebViewController
            webViewReipeVC.recipeURL = recipeURL
        }
    }
}
