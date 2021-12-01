//
//  File.swift
//  HBCase
//
//  Created by Gozde Kahraman on 10.11.2021.
//

import Foundation

struct SearchResults: Codable {
    var results: [ResultItem]?
}

struct ResultItem: Codable {
    var collectionPrice: Double?
    var collectionName: String?
    var artworkUrl100: URL?
    var releaseDate: Date?
    var kind: MediaType?
    var collectionExplicitness: Explicitness?
    var longDescription: String?
    var primaryGenreName: String?
    var artistName: String?
    
    func getDetailList() -> [(String, String?)] {
        let detailList = [("Artist Name", artistName), ("Release Date", releaseDate?.dateFormatted(format: "dd.MM.yyyy")), ("Genre", primaryGenreName), ("Description", longDescription)]
        
        return detailList.filter{ !($0.1?.isEmpty ?? true)}
    }
}

enum MediaType: String, Codable {
    case music = "song"
    case movie = "feature-movie"
    case ebook
    case podcast
    case other
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = MediaType(rawValue: label) ?? .other
    }
}

enum Explicitness: String, Codable {
    case explicit
    case notExplicit
    case other
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = Explicitness(rawValue: label) ?? .other
    }
}
