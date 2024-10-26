//
//  DrinkSearchCollectionViewManager.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 25/10/2024.
//

import Foundation
import UIKit

protocol DrinkSearchCollectionViewManagerDelegate: AnyObject {
    func selected(drink: Drink)
}

class DrinkSearchCollectionViewManager: NSObject {
    private let styling = CollectionViewStylingType.drink
    weak var collectionView: UICollectionView?
    weak var delegate: DrinkSearchCollectionViewManagerDelegate?

    var drinks: [Drink] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    func setup(collectionView: UICollectionView?) {
        collectionView?.register(DrinkCollectionViewCell.self,
                                 forCellWithReuseIdentifier: DrinkCollectionViewCell.reuseIdentifier)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.keyboardDismissMode = .onDrag

        self.collectionView = collectionView
    }
}

extension DrinkSearchCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row >= 0,
              indexPath.row < drinks.count,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? DrinkCollectionViewCell else { return UICollectionViewCell()
            
        }
        let drink = drinks[indexPath.row]
        cell.reuse(drink: drink)
        return cell
    }
}

extension DrinkSearchCollectionViewManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row >= 0 ,
              indexPath.row < drinks.count
        else { return }
        delegate?.selected(drink: drinks[indexPath.row])
    }
}

extension DrinkSearchCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: styling.styling.inset,
                            left: styling.styling.inset,
                            bottom: styling.styling.inset,
                            right: styling.styling.inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return styling.styling.minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return styling.styling.minimumInteritemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = styling.styling.inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + styling.styling.minimumInteritemSpacing * CGFloat(styling.styling.cellsPerRow - 1)
        let itemWidth = (collectionView.bounds.size.width - marginsAndInsets) / CGFloat(styling.styling.cellsPerRow).rounded(.down)
        return CGSize(width: itemWidth, height: styling.styling.itemHeight)
    }
}
