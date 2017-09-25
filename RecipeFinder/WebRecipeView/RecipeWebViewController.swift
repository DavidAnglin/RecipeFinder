//
//  RecipeWebViewController.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/25/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import UIKit
import WebKit

class RecipeWebViewController: UIViewController {
    
    // MARK: - IBOutlets -
    @IBOutlet weak var progBar: UIProgressView!
    
    // MARK: - Stored Properties -
    var recipeWebView: WKWebView?
    
    // MARK: - Lazy Variable -
    lazy var recipeURL: URL? = {
        return URL(string: "") ?? nil
    }()
    
    // MARK: - View Controller Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        setupToolbarLogo()
    }
    
    // MARK: - Setup -
    func setupWebView() {
        
        self.recipeWebView = WKWebView(frame: self.view.frame)
        
        if let recipeView = recipeWebView {
            recipeView.navigationDelegate = self
            recipeView.allowsBackForwardNavigationGestures = true
            recipeView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)

            if let url = recipeURL {
                let request = URLRequest(url: url)
                recipeView.load(request)
                self.view.addSubview(recipeView)
                self.view.sendSubview(toBack: recipeView)
            }
        }
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
    
    // MARK: - Observe Value for Progress Bar -
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progBar.isHidden = recipeWebView?.estimatedProgress == 1
            progBar.setProgress(Float(recipeWebView!.estimatedProgress), animated: false)
        }
    }
}

// MARK: - WKNavigation Delegate -
extension RecipeWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
