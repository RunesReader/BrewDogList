//
//  LoadingView.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    func show() {
        if self.isHidden {
            self.isHidden = false
            UIView.animate(withDuration: 0.25) {
                self.alpha = 0.75
            }
        }
    }
    
    func hide(completion: (() -> ())?  = nil) {
        if !self.isHidden {
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 0
            }) { _ in
                self.isHidden = true
                if let completion = completion {
                    completion()
                }
            }
        }
    }
}
