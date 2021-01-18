//
//  ShowYourSkillTests.swift
//  ShowYourSkillTests
//
//  Created by Boubakar Traore on 15/01/2021.
//  Copyright © 2021 Boubakar Traore. All rights reserved.
//

@testable import ShowYourSkill
import XCTest

class ShowYourSkillTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    func test_photo_info_set_correctly () {
        var photo = PhotoData()
        XCTAssertNotNil(photo)
        
        photo.albumId = 1
        photo.id = 2
        photo.title = "le petit chien"
        photo.url = "lepetitchien.png"
        photo.thumbnailUrl = "chien.png"
        
        XCTAssertEqual(photo.albumId, 1)
        XCTAssertEqual(photo.id , 2)
        XCTAssertEqual(photo.title, "le petit chien")
        XCTAssertEqual(photo.url, "lepetitchien.png")
        XCTAssertEqual(photo.thumbnailUrl, "chien.png")
    }
    
    func test_album_info_set_correctly() {
        var album = AlbumData()
        XCTAssertNotNil(album)
        
        album.id = 2
        album.userId = 4
        album.title = "Dossier"
        
        XCTAssertEqual(album.userId, 4)
        XCTAssertEqual(album.id , 2)
        XCTAssertEqual(album.title, "Dossier")
    }
    
    func test_user_info_set_correctly() {
        var user = UserData()
        XCTAssertNotNil(user)
        
        user.id = 1
        user.name = "Boubakar"
        user.email = "boubakar@mail.com"
        user.phone = "1234 5678 10"
        user.username = "Bacar"
        user.website = "boubakar.com"
        
        XCTAssertEqual(user.id , 1)
        XCTAssertEqual(user.name, "Boubakar")
        XCTAssertEqual(user.email, "boubakar@mail.com")
        XCTAssertEqual(user.phone, "1234 5678 10")
        XCTAssertEqual(user.username, "Bacar")
        XCTAssertEqual(user.website, "boubakar.com")
        
    }
    
}
