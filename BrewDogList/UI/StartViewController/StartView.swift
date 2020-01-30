//
//  StartView.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

final class StartView: UIView {
    
    // MARK: - Constants
    struct Config {
        static let buttonTitle = "Let's go!"
    }
    
    // MARK: - ViewModel
    final class ViewModel {
        var buttonTitle = Config.buttonTitle
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var goButton: UIButton?
    
    // MARK: - Properties
    var viewModel: ViewModel = ViewModel() {
        didSet {
            goButton?.setTitle(viewModel.buttonTitle, for: .normal)
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
        guard let button = goButton else { return }
        goButton?.layer.cornerRadius = min(button.bounds.width, button.bounds.height) / 2
        goButton?.layer.masksToBounds = true
    }
}
