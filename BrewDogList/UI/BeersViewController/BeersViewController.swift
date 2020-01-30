//
//  BeersViewController.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

final class BeersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GetBeers {
    
    // MARK: - Constants
    struct Config {
        static let startPage = 1
        static let perPage = 20
        static let title = "Beers List"
    }
    
    // MARK: - IBOutlets
    @IBOutlet var mainView: BeersView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var loadingView: LoadingView?
    
    // MARK: - Properties
    private var beers = [Beer]() {
        didSet {
            tableView?.reloadData()
        }
    }
    private var currentPage = Config.startPage
    var getBeersInteractor: NetworkInteractor<[Beer]>?
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startGetBeersInteractor(itemsPerPage: Config.perPage, page: currentPage) { [weak self] models in
            self?.beers = models
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopGetBeersInteractor()
    }
    
    // MARK: - Private
    private func setupUI() {
        title = Config.title
        tableView?.register(cellClass: BeerCell.self)
    }
    
    
    // MARK: - <UITableViewDataSource>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.className, for: indexPath) as? BeerCell else { return UITableViewCell() }
        cell.viewModel = BeerCell.ViewModel(with: beers[indexPath.row])
        
        return cell
    }
}
