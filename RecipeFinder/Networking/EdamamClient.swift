//
//  EdamamClient.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/21/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

import Foundation

class EdamamClient: APIClient {
    
    // MARK: - Constants -
    let session: URLSession
    
    // MARK: - Initialization -
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // MARK: - Search Method -
    typealias completionHandler = (Result<[Recipe], APIError>) -> Void
    
    func search(withTerm term: String = "chicken", withLimit limit: Int = 50, completion: @escaping completionHandler) {
        
        let endpoint = Edamam.search(term: term, limit: limit)
        let request = endpoint.request
        fetch(with: request, parse: { json -> [Recipe] in
            guard let hits = json["hits"] as? [[String: Any]] else { return [] }
            return hits.flatMap { Recipe(json: $0) }
        }, completion: completion)
    }
}
