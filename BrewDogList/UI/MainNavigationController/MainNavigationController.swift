//
//  MainNavigationController.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

final class MainNavigationController: UINavigationController {
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private
    private func setupUI() {
        navigationBar.tintColor = UIColor.darkGray
    }
}
