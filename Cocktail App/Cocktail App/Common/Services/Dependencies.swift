//
//  Dependencies.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import Foundation

protocol DependenciesProvidable: AnyObject {
    static func dependencies(with environment: Configuration.Environment) -> Dependencies
}

struct Dependencies {
    let drinksService: DrinksService
    
    init(drinksService: DrinksService) {

        self.drinksService = drinksService
    }
}
