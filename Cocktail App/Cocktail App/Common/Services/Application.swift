//
//  Application.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import Foundation
import Combine

class Application {
    private var cancelable = Set<AnyCancellable>()
    private let dependencies: [Dependencies] = []
    
    static let shared: Application = {
        Application()
    }()
}

extension Application: DependenciesProvidable {
    func dependencies(with environment: Configuration.Environment) -> Dependencies {
        switch environment {
        case .dev:
            return Dependencies(drinksService: DrinksService())
        case .prod:
            return Dependencies(drinksService: DrinksService())
        case .xctests:
            return Dependencies(drinksService: DrinksService())
        }
    }
}
