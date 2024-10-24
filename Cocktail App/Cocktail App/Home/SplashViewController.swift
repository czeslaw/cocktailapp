//
//  SplashViewController.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 24/10/2024.
//

import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func didFinishAnimating()
}

class SplashViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    weak var delegate: SplashViewControllerDelegate?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: AnimationDurations.mediumAnimationDuration,
                       delay: AnimationDurations.mediumAnimationDuration,
                       options: .curveEaseInOut) {
            self.imageView.alpha = 0.0
            self.imageView.transform = self.imageView.transform.scaledBy(x: 3, y: 3)
            
        } completion: { completed in
            self.delegate?.didFinishAnimating()
        }

    }
}

