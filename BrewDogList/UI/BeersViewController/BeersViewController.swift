//
//  BeersViewController.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

final class BeersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Constants
    struct Config {
        static let startPage = 1
        static let title = "Beers List"
    }
    
    // MARK: - IBOutlets
    @IBOutlet var mainView: BeersView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var loadingView: LoadingView?
    
    // MARK: - Properties
    private var beers = [Beer]()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private
    private func setupUI() {
        title = Config.title
        tableView?.register(cellClass: BeerCell.self)
    }
    
    // MARK: - <UITableViewDataSource>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.className, for: indexPath) as? BeerCell else { return UITableViewCell() }
        
        return cell
    }
}
