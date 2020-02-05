//
//  MyExtensions.swift
//  CitiesWeather
//
//  Created by Abraham Escamilla Pinelo on 04/02/20.
//  Copyright © 2020 Abraham Escamilla Pinelo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /**
     Creates and presents an alert on the ViewController is called.
     - Parameter title: the title of the alertcontroller. The default value is "Dypaq"
     - Parameter message: the message to be displayed on the alert. The default value is nil.
     - Parameter type: The UIAlertControllerStyle of the AlertController. The default is .alert
     - Parameter actions: An array of the actions that the alert is going to have. The default value is an action with title "Aceptar" and no closure.
     */
    func createAlertView(_ title: String?, _ message: String? = nil, type : UIAlertController.Style = .alert ,actions: UIAlertAction...) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: type)
        actions.forEach { (action) in
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion:nil)
    }
    
    func showAlertOneButtonWith(alertTitle: String, alertMessage: String, buttonTitle: String, handler:  ((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let button = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        
        alert.addAction(button)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertTwoButtonsWith(
        alertTitle: String,
        alertMessage: String,
        firstButtonTitle: String,
        firstButtonStyle: UIAlertAction.Style,
        firstButtonHandler: ((UIAlertAction) -> Void)? = nil,
        secondtButtonTitle: String,
        secondButtonStyle: UIAlertAction.Style,
        secondButtonHandler: ((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let firstButton = UIAlertAction(title: firstButtonTitle, style: firstButtonStyle, handler: firstButtonHandler)
        
        let secondButton = UIAlertAction(title: secondtButtonTitle, style: secondButtonStyle, handler: secondButtonHandler)
        
        
        
        alert.addAction(firstButton)
        alert.addAction(secondButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}
