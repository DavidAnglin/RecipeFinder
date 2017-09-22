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
    
    // MARK: - IBOutlets -
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeLink: UIButton!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var servingLabel: UILabel!
    
    // MARK: - IBActions -
    @IBAction func goToFullRecipe(_ sender: UIButton) {
        
    }
    
    lazy var dataSource: RecipeDetailDataSource = {
        return RecipeDetailDataSource(ingredientData: [])
    }()
    
    // MARK: - View Controller Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        if let recipe = recipe, let viewModel = RecipeDetailCellViewModel(recipe: recipe) {
            configure(with: viewModel)
        }
    }
    
    func setupTableView() {
        tableView.dataSource = dataSource
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    /// Configures the views in the table view's header view
    ///
    /// - Parameter viewModel: View model representation of a YelpBusiness object
    func configure(with viewModel: RecipeDetailCellViewModel) {
        recipeImage.image = #imageLiteral(resourceName: "chickenFingers")
        recipeLabel.text = viewModel.recipeLabel
        recipeLink.setTitle(viewModel.recipeLink, for: .normal)
        calorieLabel.text = viewModel.calorieLabel
        servingLabel.text = viewModel.servingLabel
    }
}
