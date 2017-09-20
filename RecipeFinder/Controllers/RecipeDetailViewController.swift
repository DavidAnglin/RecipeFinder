//
//  RecipeDetailViewController.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/20/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UITableViewController {

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
        return RecipeDetailDataSource()
    }()
    
    // MARK: - View Controller Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        self.definesPresentationContext = true
    }
    
    func setupTableView() {
        tableView.dataSource = dataSource
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
}
