//
//  PhotoViewController.swift
//  ShowYourSkill
//
//  Created by Boubakar Traore on 14/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    var currentAlbum: AlbumData = AlbumData()
    var photoManager: PhotoManager = PhotoManager()
    var photoList = [PhotoData]()
    var cellReuseIdentifier = "PhotoColItem"
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner()
        photoManager.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        photoManager.fetchPhoto(userId: currentAlbum.userId, albumId: currentAlbum.id)
        updateUI()
    }
    
    func updateUI() {
        albumTitleLabel.text = currentAlbum.title
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK - PhotoManager

extension PhotoViewController: PhotoManagerDelegate {
    func didUpdatePhoto(photos: [PhotoData]) {
        DispatchQueue.main.async {
            self.photoList = photos
            self.collectionView.reloadData()
        }
    }
}

// MARK - CollectionView

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.removeSpinner()
        let photo: PhotoData
        photo = photoList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        let cellImage = cell.viewWithTag(3000) as! UIImageView
        let cellLabel = cell.viewWithTag(3001) as! UILabel
        let imageData: Data = self.defaults.object(forKey: photo.thumbnailUrl) as! Data
        cellImage.image = UIImage(data: imageData)
        cellLabel.text = photo.title
        
        return cell
    }
}
