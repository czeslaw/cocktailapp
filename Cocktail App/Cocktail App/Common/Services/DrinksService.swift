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
}

struct DrinksResponse: Decodable {
    let drinks: [Drink]?
}

extension Resource {
    static func drinks(query: String) -> Resource<DrinksResponse> {
        let url = URL(string: Application.shared.environment.rootURL.appending("search.php"))!
        let parameters: [String : CustomStringConvertible] = [
            "s": query,
            ]
        return Resource<DrinksResponse>(url: url, parameters: parameters)
    }
}

