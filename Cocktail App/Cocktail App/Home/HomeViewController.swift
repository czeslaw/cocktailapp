//
//  HomeViewController.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
}

class HomeViewController: BaseViewController {
    weak var delegate: HomeViewControllerDelegate?
}
