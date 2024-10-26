//
//  DrinkCollectionViewCell.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 25/10/2024.
//

import Foundation
import UIKit

class DrinkCollectionViewCell: UICollectionViewCell, Reusable {
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Configuration.Font.text
        label.textColor = Configuration.Color.defaultTextColor
        label.numberOfLines = 2
        return label
    }()

    var imageTask: URLSessionTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        addConstraint(NSLayoutConstraint(item: imageView,
                                         attribute: NSLayoutConstraint.Attribute.leading,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.leading,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView,
                                         attribute: NSLayoutConstraint.Attribute.top,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.top,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView,
                                         attribute: NSLayoutConstraint.Attribute.trailing,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.trailing,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: titleLabel,
                                         attribute: NSLayoutConstraint.Attribute.leading,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.leading,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel,
                                         attribute: NSLayoutConstraint.Attribute.top,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: imageView,
                                         attribute: NSLayoutConstraint.Attribute.bottom,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel,
                                         attribute: NSLayoutConstraint.Attribute.trailing,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.trailing,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel,
                                         attribute: NSLayoutConstraint.Attribute.bottom,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.bottom,
                                         multiplier: 1,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel,
                                         attribute: NSLayoutConstraint.Attribute.height,
                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                         toItem: self,
                                         attribute: NSLayoutConstraint.Attribute.height,
                                         multiplier: 0.35,
                                         constant: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reuse(drink: Drink) {
        titleLabel.text = drink.title
        imageTask?.cancel()
//        imageTask = imageView.imageFromURL(url: drink.posterUrl)
    }
}
