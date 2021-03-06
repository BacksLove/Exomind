//
//  AlbumViewController.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    var albumList = [AlbumData]()
    var currentUser: UserData = UserData()
    var albumManager: AlbumManager = AlbumManager()
    var cellReuseIdentifier = "AlbumlistItem"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        albumManager.delegate = self
        
        albumManager.fetchAlbum(userId: currentUser.id)
        updateUI()
    }
    
    func updateUI() {
        titleLabel.text = "\("ALBUM_OF".localized()) \(currentUser.username)"
        albumLabel.text = "ALBUM_LIST".localized()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoSegue" {
            let newAlbum: AlbumData
            newAlbum = sender as! AlbumData
            var destination: PhotoViewController
            destination = segue.destination as! PhotoViewController
            destination.currentAlbum = newAlbum
        }
    }
}

// MARK - AlbumData

extension AlbumViewController: AlbumDataDelegate {
    func didUpdateAlbum(albums: [AlbumData]) {
        DispatchQueue.main.async {
            self.albumList = albums
            self.tableView.reloadData()
        }
    }
}

// MARK - TableView

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album: AlbumData
        album = albumList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let titleLabel = cell.viewWithTag(2000) as! UILabel
        titleLabel.text = album.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album: AlbumData
        album = albumList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "PhotoSegue", sender: album)
    }
}
