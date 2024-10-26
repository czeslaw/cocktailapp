//
//  DrinkViewController.swift
//  Cocktail App
//
//  Created by Piotr Nietrzebka on 26/10/2024.
//

import UIKit
import Combine

protocol DrinkViewControllerDelegate: AnyObject {
    func didPressShare(drink: Drink, image: UIImage?)
}

class DrinkViewController: BaseViewController {
    private var cancelables = Set<AnyCancellable>()
    private let onAppear = PassthroughSubject<Void, Never>()
    
    weak var delegate: DrinkViewControllerDelegate?

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func bind(viewModel: VCViewModel) {
        let input = DrinkViewModelInput(onAppear: onAppear.eraseToAnyPublisher())
        
        let output = (viewModel as! DrinkViewModel).transform(input: input)
        
        output.viewState
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] state in
                switch state {
                case .success(let drink):
                    print("dsadsa\(drink)")
                case .failure(let error):
                    print("error\(error)")
                case .share(let drink):
                    self.delegate?.didPressShare(drink: drink,
                                                 image: imageView.image)
                }
        }).store(in: &cancelables)
    }

    override func configure(viewModel: VCViewModel) {
        super.configure(viewModel: viewModel)
        guard let vm = viewModel as? DrinkViewModel else {
            return
        }
        if let url = URL(string: vm.drink.strDrinkThumb ?? "") {
            imageView.imageFromURL(url: url)
        }
    }
}
