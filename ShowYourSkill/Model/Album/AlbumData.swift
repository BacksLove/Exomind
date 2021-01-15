//
//  AlbumData.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation

struct AlbumData: Codable {
    
    let userId: Int
    let id: Int
    let title: String
    
    init() {
        userId = 0
        id = 0
        title = ""
    }
    
}
