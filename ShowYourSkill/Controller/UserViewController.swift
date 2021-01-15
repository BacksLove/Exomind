//
//  ViewController.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UserManagerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var userManager = UserManager()
    
    var userList: [UserData] = []
    var userSearchingList:[UserData] = []
    
    var cellReuseIdentifier = "UserlistItem"
    var searching : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        userManager.delegate = self
        searchBar.delegate = self
        
        userManager.fetchUser()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userSearchingList = userList.filter({$0.username.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return userSearchingList.count
        } else {
            return userList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user: UserData
        if searching {
            user = userSearchingList[indexPath.row]
        } else {
            user = userList[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let usernameLabel = cell.viewWithTag(1000) as! UILabel
        let nameLabel = cell.viewWithTag(1001) as! UILabel
        
        usernameLabel.text = user.username
        nameLabel.text = user.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user: UserData
        if searching {
            user = userSearchingList[indexPath.row]
        } else {
            user = userList[indexPath.row]
        }
        
        print(user.name)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "UserAlbumSegue", sender: user)
        
    }
    
    func didUpdateUser(user: [UserData]) {
        DispatchQueue.main.async {
            self.userList = user
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserAlbumSegue" {
            let newUser: UserData
            newUser = sender as! UserData
            var destination: AlbumViewController
            destination = segue.destination as! AlbumViewController
            destination.currentUser = newUser
        }
    }
    
}

