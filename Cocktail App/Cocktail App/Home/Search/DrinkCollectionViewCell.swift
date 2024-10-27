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
        label.font = Configuration.Font.title
        label.textAlignment = .center
        label.textColor = Configuration.Color.defaultTextColor
        label.numberOfLines = 2
        return label
    }()

    var imageTask: URLSessionTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0).isActive = true
        
        leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reuse(drink: Drink) {
        titleLabel.text = drink.strDrink
        imageTask?.cancel()
        guard let urlString = drink.strDrinkThumb,
              let url = URL(string: urlString) else {
            return
        }
        imageTask = imageView.imageFromURL(url: url)
    }
}
