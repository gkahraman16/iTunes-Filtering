//
//  ItemDetailVM.swift
//  HBCase
//
//  Created by Gozde Kahraman on 11.11.2021.
//

import Foundation
import RxSwift
import RxCocoa

class ItemDetailVM {
    let disposeBag = DisposeBag()
    let item = BehaviorRelay<ResultItem?>(value: nil)
    
    init(item: ResultItem){
        self.item.accept(item)
    }
}
