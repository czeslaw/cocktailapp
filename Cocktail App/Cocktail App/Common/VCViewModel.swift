//
//  VCViewModel.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 25/10/2024.
//

import Foundation
import UIKit

protocol VCViewModel {
    var backgroundColor: UIColor { get }
    var hidesBackButton: Bool { get }
    var title: String { get }
}

extension VCViewModel {
    var backgroundColor: UIColor {
        Configuration.Color.defaultViewBackground
    }
    var hidesBackButton: Bool {
        false
    }
    var title: String {
        String(describing: self).replacingOccurrences(of: "ViewModel", with: "")
    }
}

class BaseViewModel: VCViewModel {
    
}
