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
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.addSubview(imageView)
        scrollView.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true

        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = .red
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        onAppear.send()
    }
    
    override func bind(viewModel: VCViewModel) {
        let input = DrinkViewModelInput(onAppear: onAppear.eraseToAnyPublisher())
        
        let output = (viewModel as! DrinkViewModel).transform(input: input)
        
        output.viewState
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [unowned self] state in
                switch state {
                case .success(let drink):
                    guard let vm = self.viewModel as? DrinkViewModel else {
                        break
                    }
                    vm.drink = drink
                    self.generateSubviews(viewModel: viewModel)
                case .failure(let error):
                    print("error\(error)")
                case .share(let drink):
                    self.delegate?.didPressShare(drink: drink,
                                                 image: imageView.image)
                }
        }).store(in: &cancelables)
    }
    
    override func generateSubviews(viewModel: VCViewModel) {
        super.generateSubviews(viewModel: viewModel)
        
        guard let vm = viewModel as? DrinkViewModel else {
            return
        }
        if let url = URL(string: vm.drink.strDrinkThumb ?? "") {
            imageView.imageFromURL(url: url)
        }
        
        stackView.removeAllArrangedSubviews()
        stackView.addArrangedSubview(imageView)
        do {
            let allProperties = try vm.drink.allProperties()

            allProperties.forEach { (key: String, value: Any) in
                if let string = value as? String {
                    let label = UILabel()
                    label.text = "\(key) \n \(string)"
                    label.numberOfLines = 2
                    label.translatesAutoresizingMaskIntoConstraints = false
                    stackView.addArrangedSubview(label)
                }
            }
            
        } catch _ {

        }
    }
}
