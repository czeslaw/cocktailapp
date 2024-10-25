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

class SplashViewController: BaseViewController {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(image: Images.logotype)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    weak var delegate: SplashViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        view.addConstraint(NSLayoutConstraint(item: imageView,
                                              attribute: NSLayoutConstraint.Attribute.centerY,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: view,
                                              attribute: NSLayoutConstraint.Attribute.centerY,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: imageView,
                                              attribute: NSLayoutConstraint.Attribute.width,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: imageView,
                                              attribute: NSLayoutConstraint.Attribute.height,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: imageView,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: view,
                                              attribute: NSLayoutConstraint.Attribute.leading,
                                              multiplier: 1,
                                              constant: 96))
        view.addConstraint(NSLayoutConstraint(item: imageView,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: view,
                                              attribute: NSLayoutConstraint.Attribute.trailing,
                                              multiplier: 1,
                                              constant: -96))
    }

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

