//
//  DrinkViewModel.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 26/10/2024.
//

import Foundation
import Combine
import UIKit

struct DrinkViewModelInput {
    let onAppear: AnyPublisher<Void, Never>
}

struct DrinkViewModelOutput {
    let viewState: AnyPublisher<DrinkViewModel.ViewState, Never>
}

class DrinkViewModel: VCViewModel {
    struct DrinkCellViewModel {
        let title: String
        let detail: String
        
        static func create(key: String?, value: Any?) -> DrinkCellViewModel? {
            guard let key = key,
                  let value = value as? String else {
                return nil
            }

            return DrinkCellViewModel(title: key.replacingOccurrences(of: "str", with: ""),
                                      detail: value)
        }
    }
    
    private var cancellables: [AnyCancellable] = []
    private let onPressShare = PassthroughSubject<Void, Never>()
    let drinksService: DrinksService
    var drink: Drink

    var cellViewModels = [DrinkCellViewModel]()
    
    var title: String {
        return drink.strDrink ?? "no name"
    }
    
    var rightBarButtonItemImage: UIImage? {
        return UIImage(systemName: "square.and.arrow.up")?.withRenderingMode(.alwaysTemplate)
    }
    
    init(drink: Drink,
         drinksService: DrinksService) {
        self.drink = drink
        self.drinksService = drinksService
    }
    
    func transform(input: DrinkViewModelInput) -> DrinkViewModelOutput {
        let fetchDrinks = input.onAppear
            .flatMapLatest({ [unowned self] query in drinksService.lookupDrink(with: drink.idDrink ?? "") })
            .map({ result -> DrinkViewModel.ViewState in
                switch result {
                case .success(let drink): 
                    
                    do {
                        self.cellViewModels.removeAll()
                        let allProperties = try drink.allProperties()

                        allProperties.keys.sorted { k1, k2 in
                            return k1.compare(k2) == ComparisonResult.orderedAscending
                        }
                        .forEach { key in
                            if let cell = DrinkCellViewModel.create(key: key, 
                                                                    value: allProperties[key]) {
                                self.cellViewModels.append(cell)
                            }
                        }
                    } catch _ {

                    }
                    
                    return .success(drink)
                case .failure(let error):
                    return .failure(error)
                }
            })
        
        let share = onPressShare
            .map({ [unowned self] result -> DrinkViewModel.ViewState in
                return .share(self.drink)
            })

        let merge = Publishers.Merge(fetchDrinks, share).removeDuplicates().eraseToAnyPublisher()
        
        return .init(viewState: merge)
    }
    
    func rightBarButtonItemAction() {
        onPressShare.send()
    }
}

extension DrinkViewModel {
    enum ViewState: Equatable {
        case success(Drink)
        case failure(Error)
        case share(Drink)
        
        static func == (lhs: DrinkViewModel.ViewState, rhs: DrinkViewModel.ViewState) -> Bool {
            switch (lhs, rhs) {
            case (.share, .share): return true
            case (.success(let lhsDrink), .success(let rhsDrink)): return lhsDrink.idDrink == rhsDrink.idDrink
            case (.failure, .failure): return true
            default: return false
            }
        }
    }
}
