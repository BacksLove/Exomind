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
    
    var delegate: UserManagerDelegate?
    
    func fetchUser() {
        performRequest(urlString: userURL)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: userURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                if let safeData = data {
                    if let user: [UserData] = self.parseJSON(userData: safeData) {
                        self.delegate?.didUpdateUser(user: user)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(userData: Data) -> [UserData] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([UserData].self, from: userData)
            var users: [UserData] = []
            
            for index in decodedData {
                let id = index.id
                let name = index.name
                let username = index.username
                let phone = index.phone
                let email = index.email
                let website = index.website
                
                let user = UserData(id: id, name: name, username: username, email: email, phone: phone, website: website)
                users.append(user)
            }
            return users
        } catch {
            print(error)
            return []
        }
    }
    
}

