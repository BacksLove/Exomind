//
//  PhotoManager.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 15/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoManagerDelegate {
    func didUpdatePhoto(photos: [PhotoData])
}

struct PhotoManager {
    
    var delegate: PhotoManagerDelegate?
    let defaults = UserDefaults.standard
    
    func fetchPhoto(userId: Int, albumId: Int) {
        performRequest(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/photos?albumId=\(albumId)", userId: userId, albumId: albumId)
    }
    
    func performRequest(urlString: String, userId: Int, albumId: Int) {
        if self.defaults.object(forKey: "\(userId)Photos\(albumId)") != nil {
            if let safeData = self.defaults.object(forKey: "\(userId)Photos\(albumId)") as? Data {
                if let photos: [PhotoData] = self.parseJSON(photoData: safeData) {
                    self.delegate?.didUpdatePhoto(photos: photos)
                }
            }
        } else {
            if let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)/photos?albumId=\(albumId)") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error ?? "")
                        return
                    }
                    if let safeData = data {
                        self.defaults.set(safeData, forKey: "\(userId)Photos\(albumId)")
                        if let photos: [PhotoData] = self.parseJSON(photoData: safeData) {
                            self.delegate?.didUpdatePhoto(photos: photos)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    func parseJSON(photoData: Data) -> [PhotoData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([PhotoData].self, from: photoData)
            if self.defaults.object(forKey: decodedData[0].thumbnailUrl) == nil {
                for index in decodedData {
                    let imageThumbnailURL = URL(string: index.thumbnailUrl)!
                    let imageThumbnailData = try Data(contentsOf: imageThumbnailURL)
                    self.defaults.set(imageThumbnailData, forKey: index.thumbnailUrl)
                }
            }
            return decodedData
        } catch {
            print(error)
            return []
        }
    }
    
    
}
