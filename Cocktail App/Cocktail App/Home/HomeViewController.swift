//
//  HomeViewController.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
}

class HomeViewController: UIViewController {
    private var viewModel: HomeViewModel
    weak var delegate: HomeViewControllerDelegate?

    init(viewModel: HomeViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        generateSubviews(viewModel: viewModel)
        configure(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    func configure(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        view.backgroundColor = viewModel.backgroundColor
    }

    private func generateSubviews(viewModel: HomeViewModel) {
        
    }
}
