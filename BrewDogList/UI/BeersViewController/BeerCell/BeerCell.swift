//
//  BeerCell.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

final class BeerCell: UITableViewCell, ClassNaming {
    
    // MARK: - Constants
    struct Config {
        static let backRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 1.0
        static let borderColor = UIColor.gray.cgColor
    }
    
    // MARK: - ViewModel
    final class ViewModel {
        var imageURL = String()
        var name = String()
        var tagline = String()
        var description = String()
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var backView: UIView?
    @IBOutlet weak var roundView: UIView?
    @IBOutlet weak var beerImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var taglineLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    // MARK: - Properties
    var viewModel: ViewModel = ViewModel() {
        didSet {
            LoadImageService.loadImage(with: .medium, urlString: viewModel.imageURL, imageView: beerImageView)
            nameLabel?.text = viewModel.name
            taglineLabel?.text = viewModel.tagline
            descriptionLabel?.text = viewModel.description
        }
    }
    
    private var views: [UIView?] {
        return [backView, beerImageView]
    }
    
    // MARK: - NSObject
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        viewModel = ViewModel()
    }
    
    // MARK: - Private
    private func setupUI() {
        backView?.layer.cornerRadius = Config.backRadius
        backView?.layer.masksToBounds = true
        
        if let roundView = roundView {
            roundView.layer.cornerRadius = min(roundView.bounds.height, roundView.bounds.width) / 2.0
            roundView.layer.borderColor = Config.borderColor
            roundView.layer.borderWidth = Config.borderWidth
            roundView.layer .masksToBounds = true
        }
    }
}

extension BeerCell.ViewModel {
    convenience init(with model: Beer) {
        self.init()
        
        imageURL = model.imageURL
        name = model.name
        tagline = model.tagline
        description = model.description
    }
}
