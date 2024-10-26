//
//  HomeViewController.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit
import Combine

protocol HomeViewControllerDelegate: AnyObject {
}

class HomeViewController: BaseViewController {
    private var cancelables = Set<AnyCancellable>()
    private let onDrinkSearchTextChange = PassthroughSubject<String, Never>()
    let searchController = UISearchController(searchResultsController: DrinkSearchViewController(collectionViewLayout: UICollectionViewFlowLayout()))
    var drinkSearchTask: URLSessionTask?

    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchBar.placeholder = "Search Drinks"
        searchController.searchResultsUpdater = self
        (searchController.searchResultsController as? DrinkSearchViewController)?.collectionViewManager.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func bind(viewModel: VCViewModel) {
        let input = HomeViewModelInput(onDrinkSearchTextChange: onDrinkSearchTextChange.eraseToAnyPublisher())
        
        let output = (viewModel as! HomeViewModel).transform(input: input)
        
        output.viewState.sink(receiveValue: { [unowned self] state in
            print("dsadsa\(self)")
            print("dsadsa\(state)")
        }).store(in: &cancelables)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let drinkSearchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

        drinkSearchTask?.cancel()
        guard !drinkSearchText.isEmpty else {
            (searchController.searchResultsController as? DrinkSearchViewController)?.collectionViewManager.drinks = []
            searchController.searchBar.isLoading = false
            return
        }

        searchController.searchBar.isLoading = true

        onDrinkSearchTextChange.send(drinkSearchText)
        
        
//        drinkSearchTask = DrinkApi.SearchMovies(titleSearch: drinkSearchText).request(completion: { (outcome) in
//            switch outcome {
//            case .success(let movieThumbNails):
//                searchController.searchBar.isLoading = false
//                (searchController.searchResultsController as? MovieSearchViewController)?.collectionViewManager.thumbNails = movieThumbNails
//            case .failure(let error):
//                guard let networkResponseError = error as? NetworkResponse, networkResponseError != .cancelled else { return }
//                searchController.searchBar.isLoading = false
//                (searchController.searchResultsController as? MovieSearchViewController)?.collectionViewManager.thumbNails = []
//            }
//        })
    }
}

extension HomeViewController: DrinkSearchCollectionViewManagerDelegate {
    func selected(drink: Drink) {
//        movieSearchTask?.cancel()
//        performSegue(withIdentifier: MovieDetailViewController.segueId, sender: movieThumbNail)
    }
}
