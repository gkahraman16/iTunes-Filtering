//
//  File.swift
//  HBCase
//
//  Created by Gozde Kahraman on 10.11.2021.
//

import Foundation

struct ITunesSearchApi {
    static let scheme = "https"
    static let host = "itunes.apple.com"
    static let path = "/search"
}

class ITunesSearchFetcher {
    func makeSearchURL(
        withTerm term: String?, withMediaType media: String?, withLimit limit: Int) -> URL? {
      var components = URLComponents()
      components.scheme = ITunesSearchApi.scheme
      components.host = ITunesSearchApi.host
      components.path = ITunesSearchApi.path
      
        
      components.queryItems = [
        URLQueryItem(name: "media", value: media),
        URLQueryItem(name: "limit", value: String(limit))
      ]
        if let term = term {
            components.queryItems?.append(URLQueryItem(name: "term", value: term))
        }
      
        return components.url
    }
}
