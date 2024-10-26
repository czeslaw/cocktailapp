//
//  Application.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import Foundation
import Combine

class Application {
    let environment: Configuration.Environment
    let dependencies: Dependencies
    
    static let shared: Application = {
        Application()
    }()
    
    init(environment: Configuration.Environment = .dev) {
        self.environment = .dev
        self.dependencies = Application.dependencies(with: environment)
    }
}

extension Application: DependenciesProvidable {
    internal static func dependencies(with environment: Configuration.Environment) -> Dependencies {
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
