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
    
    func showSpinner() {
         sView = UIView(frame: self.view.bounds)
        sView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let spinner = UIActivityIndicatorView(style: .large)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 25))
        label.text = "DOWNLOADING".localized()
        label.textColor = UIColor.black
        spinner.center = sView!.center
        label.center = sView!.center
        spinner.startAnimating()
        sView?.addSubview(spinner)
        sView?.addSubview(label)
        self.view.addSubview(sView!)
    }
    
    func removeSpinner() {
        sView?.removeFromSuperview()
        sView = nil
    }
    
}

