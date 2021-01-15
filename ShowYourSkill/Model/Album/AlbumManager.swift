//
//  AlbumManager.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation
import CoreData

protocol AlbumDataDelegate {
    func didUpdateAlbum(albums: [AlbumData])
}

struct AlbumManager {
    
    let defaults = UserDefaults.standard
    var delegate: AlbumDataDelegate?
    
    func fetchAlbum(userId: Int) {
        //let param: String = String(userId)
        performRequest(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/albums?userId=\(userId)", userId: userId)
    }
    
    func performRequest(urlString: String, userId: Int) {
        
        if self.defaults.object(forKey: "Albums\(userId)") != nil {
            if let safeData = self.defaults.object(forKey: "Albums\(userId)") as? Data {
                if let albums: [AlbumData] = self.parseJSON(albumData: safeData) {
                    self.delegate?.didUpdateAlbum(albums: albums)
                }
            }
        } else {
            if let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)/albums?userId=\(userId)") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error ?? "")
                        return
                    }
                    if let safeData = data {
                        self.defaults.set(safeData, forKey: "Albums\(userId)")
                        if let albums: [AlbumData] = self.parseJSON(albumData: safeData) {
                            self.delegate?.didUpdateAlbum(albums: albums)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    func parseJSON(albumData: Data) -> [AlbumData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([AlbumData].self, from: albumData)
            
            for index in decodedData {
                print("affichage:  \(index.title)")
            }
            
            return decodedData
        } catch {
            print(error)
            return []
        }
    }
}
