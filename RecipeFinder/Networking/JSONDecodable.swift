//
//  JSONDecodable.swift
//  RecipeFinder
//
//  Created by David Anglin on 9/20/17.
//  Copyright © 2017 David Anglin. All rights reserved.
//

protocol JSONDecodable {
    /// Instantiates an instance of the conforming type with a JSON dictionary
    ///
    /// Returns `nil` if the JSON dictionary does not contain all the values
    /// needed for instantiation of the conforming type
    init?(json: [String: Any])
}
