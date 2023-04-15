//
//  AlertExt.swift
//  RestaurantRNG
//
//  Created by Eric Crawford on 4/15/23.
//

import UIKit

extension UIViewController {
    
    /// Shows an alert with the given description or default text if nil.
    func showGenericAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Unknown error")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}
