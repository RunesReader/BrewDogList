//
//  StartViewController.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

enum StartViewEvent {
    case start
}

typealias StartViewEventHandler = (StartViewEvent) -> Swift.Void

final class StartViewController: UIViewController {
    
    // MARK: - Constants
    struct Config {
        static let title = "Start Screen"
    }
    
    // MARK: - IBOutlets
    @IBOutlet var mainView: StartView?
    
    // MARK: - Properties
    private let eventHandler: StartViewEventHandler
    
    // MARK: - Initializations and Deallocation
    init(with eventHandler: @escaping StartViewEventHandler) {
        self.eventHandler = eventHandler
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - IBActions
    @IBAction func goButtonTapped(_ sender: UIButton) {
        eventHandler(.start)
    }
    
    // MARK: - Private
    private func setupUI() {
        title = Config.title
    }
}
