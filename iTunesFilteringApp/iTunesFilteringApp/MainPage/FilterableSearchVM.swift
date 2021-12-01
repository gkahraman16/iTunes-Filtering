//
//  FilterableSearchVM.swift
//  HBCase
//
//  Created by Gozde Kahraman on 11.11.2021.
//

import Foundation
import RxSwift
import RxCocoa

class FilterableSearchVM {
    let disposeBag = DisposeBag()
    let items = BehaviorRelay<[ResultItem?]?>(value: nil)
    var fetcher = ITunesSearchFetcher()
    let searchText = BehaviorRelay<String?>(value: nil)
    let selectedFilter = BehaviorRelay<String?>(value: "all")
    let pageStatus = BehaviorRelay<PageStatus>(value: .success)
    
    init(){
        bindSearch()
    }
    
    func bindSearch() {
        Observable.combineLatest(searchText,selectedFilter)
            .subscribe(onNext: { [weak self] text, filter in
                self?.filterSearchResults(with: text, mediaType: filter)
            }).disposed(by: disposeBag)
    }
    
    func filterSearchResults(with word: String?, mediaType: String?, limit: Int = 20) {
        guard let url = fetcher.makeSearchURL(withTerm: word, withMediaType: mediaType, withLimit: limit), word?.count ?? 0 > 2
        else { items.accept(nil)
            return }
        pageStatus.accept(.loading)
        URLRequest.load(resource: Resource<SearchResults>(url: url))
            .subscribe(onNext: { [weak self] result,status in
                self?.items.accept(result?.results)
                if result?.results?.count == 0 {
                    self?.pageStatus.accept(.noResult)
                }else {
                    self?.pageStatus.accept(status)
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    
}
