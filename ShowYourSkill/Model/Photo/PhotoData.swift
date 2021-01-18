//
//  PhotoData.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 15/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation

struct PhotoData: Codable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    init() {
        albumId = 0
        id = 0
        title = ""
        url = ""
        thumbnailUrl = ""
    }
}
