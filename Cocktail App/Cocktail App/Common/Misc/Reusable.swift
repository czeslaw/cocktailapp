//
//  Reusable.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 26/10/2024.
//

import Foundation
import UIKit

protocol Reusable where Self: UIView {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {
    
}
