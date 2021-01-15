//
//  PhotoViewController.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, PhotoManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var albumLabel: UILabel!
    
    var currentAlbum: AlbumData = AlbumData(userId: 0, id: 0, title: "")
    var photoManager: PhotoManager = PhotoManager()
    var photoList: [PhotoData] = []
    var cellReuseIdentifier = "PhotoColItem"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoManager.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        photoManager.fetchPhoto(userId: currentAlbum.userId, albumId: currentAlbum.id)
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo: PhotoData
        photo = photoList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        let cellImage = cell.viewWithTag(3000) as! UIImageView
        let cellLabel = cell.viewWithTag(3001) as! UILabel
        let imageURL = URL(string: photo.thumbnailUrl)!
        
        cellImage.loadImage(withUrl: imageURL)
        cellLabel.text = photo.title
        
        return cell
    }
    
    func updateUI() {
        albumLabel.text = currentAlbum.title
    }
    
    func didUpdatePhoto(photos: [PhotoData]) {
        DispatchQueue.main.async {
            self.photoList = photos
            self.collectionView.reloadData()
        }
    }
    
    
}

extension UIImageView {
    func loadImage(withUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
