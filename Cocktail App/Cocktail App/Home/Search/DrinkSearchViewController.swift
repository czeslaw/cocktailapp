//
//  DrinkSearchViewController.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 25/10/2024.
//

import UIKit

class DrinkSearchViewController: UICollectionViewController {
    var collectionViewManager = DrinkSearchCollectionViewManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewManager.setup(collectionView: collectionView)
        collectionView?.backgroundColor = .white
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionViewManager.collectionView?.reloadData()
    }
}

