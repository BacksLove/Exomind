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
    
    var currentAlbum: AlbumData = AlbumData()
    var photoManager: PhotoManager = PhotoManager()
    var photoList = [PhotoData]()
    var cellReuseIdentifier = "PhotoColItem"
    
    let defaults = UserDefaults.standard
    
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
        let imageData: Data = self.defaults.object(forKey: photo.thumbnailUrl) as! Data

        cellImage.image = UIImage(data: imageData)
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

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

