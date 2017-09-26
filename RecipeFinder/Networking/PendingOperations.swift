//
//  PendingOperations.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/26/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import Foundation
import UIKit

class PendingOperations {
    var downloadsInProgress = [IndexPath : Operation]()
    var downloadsInRecipeDetailView = [UIImageView : Operation]()
    let downloadQueue = OperationQueue()
}
