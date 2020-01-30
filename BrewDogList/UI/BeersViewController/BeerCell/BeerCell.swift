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
    }
    
    // MARK: - ViewModel
    final class ViewModel {
        
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var backView: UIView?
    
    // MARK: - Properties
    var viewModel: ViewModel = ViewModel() {
        didSet {
            
        }
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
    }
}
