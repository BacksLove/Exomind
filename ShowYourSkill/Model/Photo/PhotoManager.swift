//
//  PhotoManager.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 15/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation

protocol PhotoManagerDelegate {
    func didUpdatePhoto(photos: [PhotoData])
}

struct PhotoManager {
    
    var delegate: PhotoManagerDelegate?
    
    func fetchPhoto(userId: Int, albumId: Int) {
        performRequest(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/photos?albumId=\(albumId)", userId: userId, albumId: albumId)
    }
    
    func performRequest(urlString: String, userId: Int, albumId: Int) {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)/photos?albumId=\(albumId)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                if let safeData = data {
                    if let photos: [PhotoData] = self.parseJSON(photoData: safeData) {
                        self.delegate?.didUpdatePhoto(photos: photos)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(photoData: Data) -> [PhotoData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([PhotoData].self, from: photoData)
            var photos: [PhotoData] = []
            
            for index in decodedData {
                
                let albumId = index.albumId
                let id = index.id
                let title = index.title
                let url = index.url
                let thumbnailUrl = index.thumbnailUrl
                
                let photo = PhotoData(albumId: albumId, id: id, title: title, url: url, thumbnailUrl: thumbnailUrl)
                
                photos.append(photo)
            }
            return photos
        } catch {
            print(error)
            return []
        }
    }

    
}
