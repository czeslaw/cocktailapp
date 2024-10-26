//
//  Configuration.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit

fileprivate func colorFrom(trait: UITraitCollection, lightColor: UIColor, darkColor: UIColor) -> UIColor {
    switch trait.userInterfaceStyle {
    case .unspecified, .light:
        return lightColor
    case .dark:
        return darkColor
    @unknown default:
        return lightColor
    }
}

enum Configuration {
    enum Environment {
        case dev
        case prod
        case xctests

        var rootURL: String {
            switch self {
            case .dev:
                return "https://www.thecocktaildb.com/api/json/v1/1/"
            case .prod:
                return "https://www.thecocktaildb.com/api/json/v1/1/"
            case .xctests:
                return "https://www.thecocktaildb.com/api/json/v1/1/"
            }
        }
    }

    enum Color {
        static let defaultViewBackground = UIColor { trait in
            return colorFrom(trait: trait, lightColor: .white, darkColor: .black)
        }
        static let defaultTextColor = UIColor { trait in
            return colorFrom(trait: trait, lightColor: .black, darkColor: .white)
        }
        static let appTint = UIColor { trait in
            return colorFrom(trait: trait,
                             lightColor: Configuration.Color.mainTint,
                             darkColor: Configuration.Color.mainTint)
        }
        static let navigationBarButtonItemTint = UIColor { trait in
            return colorFrom(trait: trait,
                             lightColor: mainTint,
                             darkColor: mainTint)
        }
        static let navigationBarSeparator = UIColor { trait in
            return colorFrom(trait: trait,
                             lightColor: separatorColor,
                             darkColor: separatorColor)
        }
        static let navigationBarBackgroundColor = UIColor { trait in
            return colorFrom(trait: trait, lightColor: backgroundMainTheme,
                             darkColor: backgroundMainTheme)
        }
        static let navigationBarPrimaryFontColor = UIColor { trait in
            return colorFrom(trait: trait, lightColor: .black, darkColor: .white)
        }
        static let searchBarTint = UIColor { trait in
            return colorFrom(trait: trait, lightColor: mainTint, darkColor: .white)
        }
        static let tableViewSeparator = UIColor { trait in
            return colorFrom(trait: trait, lightColor: separatorColor, darkColor: separatorColor)
        }
 
        private static let mainTint = UIColor(r: 250, g: 90, b: 40, a: 1)
        private static let separatorColor = UIColor.gray
        private static let backgroundMainTheme = UIColor.white
        private static let mine = UIColor(r: 227, g: 132, b: 222, a: 1)
    }

    enum Font {
        static let title = Fonts.semibold(size: ScreenChecker.size(big: 18, small: 14))
        static let text = Fonts.regular(size: ScreenChecker.size(big: 18, small: 14))
        static let label = Fonts.regular(size: ScreenChecker.size(big: 18, small: 14))
    }
}

enum Fonts {
    static func regular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    static func semibold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    static func bold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
}

enum Images {
    static var backWhite: UIImage? {
        return UIImage(named: "backWhite")
    }
    static var logotype: UIImage? {
        return UIImage(named: "logotype")
    }
    static var drinkPlaceholder: UIImage? {
        return UIImage(named: "drinkPlaceholder")
    }
}

enum AnimationDurations {
    static var fastAnimationDuration: TimeInterval {
        return 0.23
    }
    static var shortAnimationDuration: TimeInterval {
        return 0.35
    }
    static var mediumAnimationDuration: TimeInterval {
        return 0.65
    }
    static var longAnimationDuration: TimeInterval {
        return 0.85
    }
}

enum CollectionViewStylingType {
    case drink
    
    var styling: CollectionViewStyling {
        switch self {
        case .drink:
            return CollectionViewStyling(inset: 5,
                                         minimumLineSpacing: 5,
                                         minimumInteritemSpacing: 5,
                                         cellsPerRow: ScreenChecker.isIPad ? 7 : 3,
                                         itemHeight: ScreenChecker.isIPad ? 300 : 180)
        }
    }
    
    struct CollectionViewStyling {
        let inset: CGFloat
        let minimumLineSpacing: CGFloat
        let minimumInteritemSpacing: CGFloat
        let cellsPerRow: Int
        let itemHeight: CGFloat
    }
}
