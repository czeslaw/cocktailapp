//
//  HomeViewController.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit
import Combine

protocol HomeViewControllerDelegate: AnyObject {
    func onSelect(drink: Drink)
}

class HomeViewController: BaseViewController {
    private var cancelables = Set<AnyCancellable>()
    private let onDrinkSearchTextChange = PassthroughSubject<String, Never>()
    let searchController = UISearchController(searchResultsController: DrinkSearchViewController(collectionViewLayout: UICollectionViewFlowLayout()))

    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized: "home.emptyState")
        label.font = Configuration.Font.bigLabel
        label.textColor = Configuration.Color.defaultTextColor
        label.numberOfLines = 0
        return label
    }()
    
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchBar.placeholder = String(localized: "search.placeholder")
        searchController.searchResultsUpdater = self
        (searchController.searchResultsController as? DrinkSearchViewController)?.collectionViewManager.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        view.addSubview(emptyStateLabel)
        view.centerXAnchor.constraint(equalTo: emptyStateLabel.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: emptyStateLabel.centerYAnchor).isActive = true
    }
    
    override func bind(viewModel: VCViewModel) {
        let input = HomeViewModelInput(onDrinkSearchTextChange: onDrinkSearchTextChange.eraseToAnyPublisher())
        
        let output = (viewModel as! HomeViewModel).transform(input: input)
        
        output.viewState
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] state in
                self.searchController.searchBar.isLoading = false
                switch state {
                case .success(let drinks):
                    (searchController.searchResultsController as? DrinkSearchViewController)?.collectionViewManager.drinks = drinks
                case .failure(let error):
                    (searchController.searchResultsController as? DrinkSearchViewController)?.collectionViewManager.drinks = []
                    print("error\(error)")
                }
        }).store(in: &cancelables)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let drinkSearchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

        guard !drinkSearchText.isEmpty else {
            (searchController.searchResultsController as? DrinkSearchViewController)?.collectionViewManager.drinks = []
            searchController.searchBar.isLoading = false
            return
        }

        searchController.searchBar.isLoading = true

        onDrinkSearchTextChange.send(drinkSearchText)
    }
}

extension HomeViewController: DrinkSearchCollectionViewManagerDelegate {
    func selected(drink: Drink) {
        delegate?.onSelect(drink: drink)
    }
}
