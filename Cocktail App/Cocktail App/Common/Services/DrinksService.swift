//
//  DrinksService.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import Foundation
import Combine

class DrinksService: NetworkService {
    private var cancellables = Set<AnyCancellable>()

    func searchDrinks(with text: String) -> AnyPublisher<Result<[Drink], Error>, Never> {
        return load(Resource<DrinksResponse>.drinks(query: text))
            .map {
                guard let drinks = $0.drinks else {
                    return .success([])
                }
                
                return .success(drinks)
            }
            .catch { error -> AnyPublisher<Result<[Drink], Error>, Never> in .just(.failure(error)) }
            .eraseToAnyPublisher()
    }
    
    func lookupDrink(with identifier: String) -> AnyPublisher<Result<Drink, Error>, Never> {
        return load(Resource<DrinkResponse>.drink(identifier: identifier))
            .map {
                return .success($0.drink)
            }
            .catch { error -> AnyPublisher<Result<Drink, Error>, Never> in .just(.failure(error)) }
            .eraseToAnyPublisher()
    }
}

struct DrinksResponse: Decodable {
    let drinks: [Drink]?
}

struct DrinkResponse: Decodable {
    let drink: Drink
}

extension Resource {
    static func drinks(query: String) -> Resource<DrinksResponse> {
        let url = URL(string: Application.shared.environment.rootURL.appending("search.php"))!
        let parameters: [String : CustomStringConvertible] = [
            "s": query,
            ]
        return Resource<DrinksResponse>(url: url, parameters: parameters)
    }
    
    static func drink(identifier: String) -> Resource<DrinkResponse> {
        let url = URL(string: Application.shared.environment.rootURL.appending("lookup.php"))!
        let parameters: [String : CustomStringConvertible] = [
            "i": identifier,
        ]
        return Resource<DrinkResponse>(url: url, parameters: parameters)
    }
}
