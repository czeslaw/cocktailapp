//
//  Drink.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 25/10/2024.
//


import Foundation

struct Drink: Decodable {
    let idDrink: String?
    let strDrink: String?
    let strDrinkAlternate: String?
    let strTags: String?
    let strVideo: String?
    let strCategory: String?
    let strIBA: String?
    let strAlcoholic: String?
    let strGlass: String?
    let strInstructions: String?
    let strDrinkThumb: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strImageSource: String?
    let strImageAttribution: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
}

extension Drink {
    static let empty = Drink(idDrink: nil,
                             strDrink: nil,
                             strDrinkAlternate: nil,
                             strTags: nil,
                             strVideo: nil,
                             strCategory: nil,
                             strIBA: nil,
                             strAlcoholic: nil,
                             strGlass: nil, 
                             strInstructions: nil,
                             strDrinkThumb: nil,
                             strIngredient1: nil,
                             strIngredient2: nil,
                             strIngredient3: nil,
                             strIngredient4: nil,
                             strIngredient5: nil,
                             strIngredient6: nil,
                             strIngredient7: nil,
                             strIngredient8: nil,
                             strIngredient9: nil, 
                             strIngredient10: nil,
                             strIngredient11: nil,
                             strIngredient12: nil,
                             strIngredient13: nil,
                             strIngredient14: nil,
                             strIngredient15: nil,
                             strMeasure1: nil, 
                             strMeasure2: nil,
                             strMeasure3: nil,
                             strMeasure4: nil,
                             strMeasure5: nil,
                             strMeasure6: nil,
                             strMeasure7: nil, 
                             strMeasure8: nil,
                             strMeasure9: nil,
                             strMeasure10: nil,
                             strMeasure11: nil,
                             strMeasure12: nil,
                             strMeasure13: nil,
                             strMeasure14: nil,
                             strMeasure15: nil,
                             strImageSource: nil,
                             strImageAttribution: nil,
                             strCreativeCommonsConfirmed: nil,
                             dateModified: nil)
}
