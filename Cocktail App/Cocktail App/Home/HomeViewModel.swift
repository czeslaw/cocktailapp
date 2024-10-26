//
//  HomeViewModel.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit
import Combine

struct HomeViewModelInput {
    let onDrinkSearchTextChange: AnyPublisher<String, Never>
}

struct HomeViewModelOutput {
    let viewState: AnyPublisher<HomeViewModel.ViewState, Never>
}

class HomeViewModel: VCViewModel {
    private var cancellables: [AnyCancellable] = []
    let drinksService: DrinksService
    
    var hidesBackButton: Bool {
        true
    }
    
    var title: String {
        return "Home"
    }
    
    init(drinksService: DrinksService) {
        self.drinksService = drinksService
    }
    
    func transform(input: HomeViewModelInput) -> HomeViewModelOutput {
        let fetchDrinks = input.onDrinkSearchTextChange
            .flatMapLatest({ [unowned self] query in drinksService.searchDrinks(with: query) })
            .map({ result -> HomeViewModel.ViewState in
                switch result {
                case .success(let drinks): return .success(drinks)
                case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()

        return .init(viewState: fetchDrinks)
    }
}

extension HomeViewModel {
    enum ViewState {
        case success([Drink])
        case failure(Error)
    }
}
