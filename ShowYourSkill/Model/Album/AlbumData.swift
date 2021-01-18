//
//  AlbumData.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation

struct AlbumData: Codable {
    
    var userId: Int
    var id: Int
    var title: String
    
    init() {
        userId = 0
        id = 0
        title = ""
    }
    
}
