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
    
    private lazy var homeCoordinator: HomeCoordinator = {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController, 
                                              drinksService: application.dependencies.drinksService)
        return homeCoordinator
    }()
    
    init(application: Application,
         windowScene: UIWindowScene) {
        
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        let navigationController: UINavigationController = .withOverridenBarAppearence()
        navigationController.view.backgroundColor = Configuration.Color.defaultViewBackground
        
        self.application = application
        self.navigationController = navigationController
        self.window = window

        super.init()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func start(launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        addCoordinator(homeCoordinator)
        homeCoordinator.start()
    }
}
