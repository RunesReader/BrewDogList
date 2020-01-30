//
//  UIViewController+Extensions.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? , message: String?, actions: [UIAlertAction]? = [UIAlertAction(title: "OK", style: .default, handler: nil)]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let _ = actions?.map{ alertController.addAction($0) }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert(_ error: String?) {
        showAlert(title: "Error", message: error)
    }
}
