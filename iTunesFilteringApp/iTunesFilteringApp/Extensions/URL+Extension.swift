//
//  URLExtension.swift
//  HBCase
//
//  Created by Gozde Kahraman on 11.11.2021.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<(T?,PageStatus)> {
        
        return Observable.from([resource.url])
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
            }.map { (response,data) -> (T?,PageStatus) in
                if 200 ..< 300 ~= response.statusCode {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let result = try? decoder.decode(T.self, from: data)
                    
                    return (result, .success)
                } else {
                    return (nil,.error)
                }
            }.asObservable()
    
    }
}
