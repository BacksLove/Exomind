//
//  UserManager.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import Foundation

protocol UserManagerDelegate {
    func didUpdateUser(user: [UserData])
}

struct UserManager {
    
    let userURL = "https://jsonplaceholder.typicode.com/users"
    let defaults = UserDefaults.standard
    
    var delegate: UserManagerDelegate?
    
    func fetchUser() {
        performRequest(urlString: userURL)
    }
    
    func performRequest(urlString: String) {
        
        if self.defaults.object(forKey: "Users") != nil {
            if let safeData = self.defaults.object(forKey: "Users") as? Data {
                if let user: [UserData] = self.parseJSON(userData: safeData) {
                    self.delegate?.didUpdateUser(user: user)
                }
            }
            
        } else {
            if let url = URL(string: userURL) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error ?? "")
                        return
                    }
                    if let safeData = data {
                        self.defaults.set(safeData, forKey: "Users")
                        if let user: [UserData] = self.parseJSON(userData: safeData) {
                            self.delegate?.didUpdateUser(user: user)
                        }
                        
                    }
                }
                task.resume()
            }
        }
    }
    
    func parseJSON(userData: Data) -> [UserData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([UserData].self, from: userData)
            return decodedData
        } catch {
            print(error)
            return []
        }
    }
    
}

