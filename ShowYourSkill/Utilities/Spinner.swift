//
//  Spinner.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 15/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import UIKit

fileprivate var sView : UIView?

extension UIViewController {
    
    func showLoader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Veuillez patienter", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        present(alert, animated: true, completion: nil)
        return alert
    }
    
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
    func showSpinner() {
        sView = UIView(frame: self.view.bounds)
        sView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = sView!.center
        spinner.startAnimating()
        sView?.addSubview(spinner)
        self.view.addSubview(sView!)
    }
    
    func removeSpinner() {
        sView?.removeFromSuperview()
        sView = nil
    }
    
}

