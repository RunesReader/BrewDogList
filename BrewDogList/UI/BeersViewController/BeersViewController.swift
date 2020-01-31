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
        static let infiniteScrollMargin = 3
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
    
    // MARK: - Initializations and Deallocation
    deinit {
        stopGetBeersInteractor()
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        requestNextPage()
    }
    
    // MARK: - Private
    private func setupUI() {
        title = Config.title
        tableView?.register(cellClass: BeerCell.self)
    }
    
    private func requestNextPage() {
        startGetBeersInteractor(itemsPerPage: Config.perPage, page: currentPage) { [weak self] models in
            if let this = self, models.isNotEmpty {
                this.currentPage += 1
                this.beers = this.beers + models
            }
        }
    }
    
    // MARK: - <UITableViewDataSource>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.className, for: indexPath) as? BeerCell else { return UITableViewCell() }
        cell.viewModel = BeerCell.ViewModel(with: beers[row])
        
        if row == beers.count - Config.infiniteScrollMargin {
            requestNextPage()
        }
        
        return cell
    }
}
