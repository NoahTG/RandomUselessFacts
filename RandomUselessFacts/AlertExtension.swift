//
//  AlertExtension.swift
//  VirtualTourist
//
//  Created by NTG on 12/21/19.
//  Copyright © 2019 NTG. All rights reserved.
//


import Foundation
import UIKit

extension UIViewController {
    
    // Reusable method for presenting a standard Error Alert.
    ///- Parameters:
    ///     - title:  the message to be displayed to the user.
    ///     - message:  Detailed body message.
    /// - Returns: the configured error alert controller.
    
    func showAlert(title: String, message: String?){
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK",
                                        style: .default,
                                        handler: nil))
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    func showDeleteFactAlert() {
        let alertVC = UIAlertController(title: "Delete Fact",
                                        message: "Do you want to delete this fact?",
                                        preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Cancel",
                                        style: .cancel,
                                        handler: nil))
        
        alertVC.addAction(UIAlertAction(title: "Delete",
                                        style: .destructive,
                                        handler: {
            (alert: UIAlertAction!) -> Void in
        }))
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
}
