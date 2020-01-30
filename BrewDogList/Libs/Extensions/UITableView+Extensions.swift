//
//  UITableView+Extensions.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cellClass: AnyClass) {
        self.register(cell: String(describing: cellClass))
    }
    
    func register(cell: String) {
        let nib = UINib.init(nibName: cell, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cell)
    }
}
