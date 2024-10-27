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
    private let drinksService: DrinksService
    var coordinators: [Coordinator] = []
    
    weak var delegate: HomeCoordinatorDelegate?

    init(navigationController: UINavigationController,
         drinksService: DrinksService) {
        self.navigationController = navigationController
        self.drinksService = drinksService
    }
    
    private lazy var rootViewController: HomeViewController = {
        let viewController = HomeViewController(viewModel: HomeViewModel(drinksService: drinksService))
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
    func onSelect(drink: Drink) {
        let drinkViewController = DrinkViewController(viewModel: DrinkViewModel(drink: drink,
                                                                                drinksService: drinksService))
        drinkViewController.delegate = self
        navigationController.pushViewController(drinkViewController, animated: true)
    }
    
}

extension HomeCoordinator: SplashViewControllerDelegate {
    func didFinishAnimating() {
        presentHomeVC()
    }
}

extension HomeCoordinator: DrinkViewControllerDelegate {
    func didPressShare(drink: Drink, image: UIImage?) {
        var activityItems = [Any]()
        if let name = drink.strDrink {
            activityItems.append(name)
        }
        if let image = image {
            activityItems.append(image)
        }
        if let url = URL(string: drink.strDrinkThumb ?? "") {
            activityItems.append(url)
        }

        let avc = UIActivityViewController(activityItems: activityItems,
                                           applicationActivities: nil)
        self.navigationController.present(avc, animated: true)
    }
}
