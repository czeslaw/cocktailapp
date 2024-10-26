//
//  Drink.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 25/10/2024.
//


import Foundation

//protocol MoviePosterUrl {
//    var posterUrlString: String { get }
//}
//
//extension MoviePosterUrl {
//    var posterUrl: URL? {
//        return URL(string: posterUrlString)
//    }
//}

struct Drink {//}: MoviePosterUrl {
    let imdbId: String
    let year: String
    let title: String
    let posterUrlString: String
}

extension Drink: Decodable {
    enum DrinkCodingKeys: String, CodingKey {
        case imdbId = "imdbID"
        case year = "Year"
        case title = "Title"
        case posterUrlString = "Poster"
    }

    init(from decoder: Decoder) throws {
        let movieThumbNailContainer = try decoder.container(keyedBy: DrinkCodingKeys.self)

        imdbId = try movieThumbNailContainer.decode(String.self, forKey: .imdbId)
        year = try movieThumbNailContainer.decode(String.self, forKey: .year)
        title = try movieThumbNailContainer.decode(String.self, forKey: .title)
        posterUrlString = try movieThumbNailContainer.decode(String.self, forKey: .posterUrlString)
    }
}
