//
//  User.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation

struct UserData: Codable {
    
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    
    init() {
        id = 0
        name = ""
        username = ""
        email = ""
        phone = ""
        website = ""
    }
    
}
