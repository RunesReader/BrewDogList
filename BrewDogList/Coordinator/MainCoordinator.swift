//
//  MainCoordinator.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import Foundation

final class MainCoordinator {
    
    // MARK: - Properties
    private var rootNavigationVC: MainNavigationController
    
    // MARK: - Initializations and Deallocation
    init(with navigationVC: MainNavigationController) {
        rootNavigationVC = navigationVC
    }
    
    // MARK: - Internal
    func start() {
        showStartScreen()
    }
    
    // MARK: - Private
    private func showStartScreen() {
        let handler: StartViewEventHandler = { [weak self] event in
            switch event {
            case .start:
                print("Show next screen")
            }
        }
        
        let controller = StartViewController(with: handler)
        rootNavigationVC.setViewControllers([controller], animated: true)
    }
}
