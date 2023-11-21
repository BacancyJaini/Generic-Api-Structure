//
//  UIViewController+Extension.swift
//  GenericApiStructure
//
//  Created by user on 21/11/23.
//

import UIKit

extension UIViewController {
    func show(title: String = Constants.kEmpty, message: String = Constants.kEmpty, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
    
    func showAlert(title: String = Constants.kEmpty, message: String = Constants.kEmpty, okTitle: String = Constants.okAlert, cancelTitle: String?, okAction: ((_ action: UIAlertAction) -> ())?, cancelAction: ((_ action: UIAlertAction) -> ())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: okTitle, style: .default, handler: okAction)
        alertController.addAction(action)
        
        if let cancelTitle {
            let action = UIAlertAction(title: okTitle, style: .cancel, handler: cancelAction)
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
}
