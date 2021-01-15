//
//  AlbumManager.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation

protocol AlbumDataDelegate {
    func didUpdateAlbum(albums: [AlbumData])
}

struct AlbumManager {
    
    var delegate: AlbumDataDelegate?
    
    func fetchAlbum(userId: Int) {
        performRequest(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/albums?userId=%7buserID%7d", userId: userId)
    }
    
    func performRequest(urlString: String, userId: Int) {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)/albums?userId=%7buserID%7d") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                if let safeData = data {
                    if let albums: [AlbumData] = self.parseJSON(albumData: safeData) {
                        self.delegate?.didUpdateAlbum(albums: albums)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(albumData: Data) -> [AlbumData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([AlbumData].self, from: albumData)
            var albums: [AlbumData] = []
            
            for index in decodedData {
                let userId = index.userId
                let id = index.id
                let title = index.title
                
                let album = AlbumData(userId: userId, id: id, title: title)
                
                albums.append(album)
            }
            return albums
        } catch {
            print(error)
            return []
        }
    }

    
}
