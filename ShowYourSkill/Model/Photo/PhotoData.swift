//
//  PhotoData.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 15/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation

struct PhotoData: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
