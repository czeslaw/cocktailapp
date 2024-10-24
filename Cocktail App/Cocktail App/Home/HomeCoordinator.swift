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
        let viewController = HomeViewController()
        viewController.delegate = self
        return viewController
    }()
}

extension HomeCoordinator: HomeViewControllerDelegate {

}
