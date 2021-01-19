//
//  StringExtension.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 19/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation

extension String {
    
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
    
}
