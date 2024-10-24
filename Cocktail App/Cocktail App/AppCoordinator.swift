//
//  AppCoordinator.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    private let application: Application
    private let window: UIWindow
    let navigationController: UINavigationController
    
    var coordinators: [Coordinator] = []
    
    static func create(application: Application) -> AppCoordinator {
        applyStyle()

        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController: UINavigationController = .withOverridenBarAppearence()
        navigationController.view.backgroundColor = Configuration.Color.defaultViewBackground

        let coordinator = AppCoordinator(
            window: window,
            navigationController: navigationController,
            application: application)

        return coordinator
    }
    
    init(window: UIWindow,
         navigationController: UINavigationController,
         application: Application) {

        self.application = application
        self.navigationController = navigationController
        self.window = window
        
        self.window.backgroundColor = .black
        self.navigationController.view.backgroundColor = .red

        super.init()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
