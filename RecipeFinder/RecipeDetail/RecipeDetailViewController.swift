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
    
    /// Configures the views in the table view's header view
    ///
    /// - Parameter viewModel: View model representation of a YelpBusiness object
    func configure(with viewModel: RecipeDetailCellViewModel) {
        recipeImage.image = #imageLiteral(resourceName: "chickenFingers")
        recipeLabel.text = viewModel.recipeLabel
        recipeLink.setTitleColor(UIColor.white, for: .normal)
        recipeLink.setAttributedTitle(viewModel.recipeLink, for: .normal)
        calorieLabel.text = viewModel.calorieLabel
        servingLabel.text = viewModel.servingLabel
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
