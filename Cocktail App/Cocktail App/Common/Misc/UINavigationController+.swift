//
//  UINavigationController+.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit

extension UINavigationController {
    static func withOverridenBarAppearence(appearence: UINavigationBarAppearance = .defaultAppearence) -> UINavigationController {
        let instance = UINavigationController()
        instance.navigationBar.compactAppearance = appearence
        instance.navigationBar.standardAppearance = appearence
        instance.navigationBar.scrollEdgeAppearance = appearence
        
        return instance
    }
}
