//
//  HomeCoordinator.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import Foundation
import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
}

class HomeCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    var coordinators: [Coordinator] = []
    
    weak var delegate: HomeCoordinatorDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private lazy var rootViewController: HomeViewController = {
        let viewController = HomeViewController(viewModel: HomeViewModel())
        viewController.delegate = self
        return viewController
    }()
    
    private lazy var splashViewController: SplashViewController = {
        let viewController = SplashViewController(viewModel: BaseViewModel())
        viewController.delegate = self
        return viewController
    }()
    
    func start() {
        presentSplashVC()
    }
    
    func presentSplashVC() {
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([splashViewController], animated: true)
    }
    
    func presentHomeVC() {
        navigationController.setViewControllers([rootViewController], animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
}

extension HomeCoordinator: SplashViewControllerDelegate {
    func didFinishAnimating() {
        presentHomeVC()
    }
}
