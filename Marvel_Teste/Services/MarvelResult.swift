//
//  MarvelResult.swift
//  Marvel_Teste
//
//  Created by Rafael Gabriel on 13/10/2018.
//  Copyright © 2018 Rafael Gabriel. All rights reserved.
//

import Foundation

struct MarvelResult: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: MarvelData
}

struct MarvelData: Codable {
    let offset, limit, total, count: Int
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics: Comics
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}

struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [Comic]
    let returned: Int
}

struct Comic: Codable {
    let resourceURI: String
    let name: String
}
