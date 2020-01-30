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
            print("Current number = \(currentPage)")
            print("Array count = \(beers.count)")
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
            self?.currentPage += 1
            self?.beers = models
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopGetBeersInteractor()
        clearData()
    }
    
    // MARK: - Private
    private func setupUI() {
        title = Config.title
        tableView?.register(cellClass: BeerCell.self)
    }
    
    private func clearData() {
        currentPage = Config.startPage
        beers = []
    }
    
    // MARK: - <UITableViewDataSource>
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.className, for: indexPath) as? BeerCell else { return UITableViewCell() }
        cell.viewModel = BeerCell.ViewModel(with: beers[indexPath.row])
        
        if indexPath.row == beers.count - 3 {
            startGetBeersInteractor(itemsPerPage: Config.perPage, page: currentPage) { [weak self] models in
                if let this = self, !models.isEmpty {
                    this.currentPage += 1
                    this.beers = this.beers + models
                }
            }
        }
        
        return cell
    }
}
