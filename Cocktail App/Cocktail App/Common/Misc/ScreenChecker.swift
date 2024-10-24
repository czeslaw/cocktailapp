//
//  ScreenChecker.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit

public class ScreenChecker {
    public init() {}

    static public var isNarrowScreen: Bool {
        let iPhone6Width = CGFloat(375)
        return UIScreen.main.bounds.width < iPhone6Width
    }

    static public var isBigScreen: Bool {
        return UIScreen.main.bounds.width >= 768 && UIScreen.main.bounds.height >= 768
    }
    
    static public var isIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}

extension ScreenChecker {
    public static func size(big: CGFloat, small: CGFloat) -> CGFloat {
        //todo: write more screen sizes variations; include landscape
        if isIPad {
            return big
        }
        
        return small
    }
}
