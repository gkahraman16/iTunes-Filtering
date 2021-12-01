//
//  ItemDetailVC.swift
//  HBCase
//
//  Created by Gozde Kahraman on 11.11.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ItemDetailVC: UIViewController{
    var viewModel: ItemDetailVM?
    let disposeBag = DisposeBag()
    
    @IBOutlet var itemImage: UIImageView!{
        didSet {
            itemImage.layer.cornerRadius = 5
            itemImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        }
    }
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemMediaTypeLabel: UILabel!
    @IBOutlet var headerSW: UIStackView! {
        didSet {
            headerSW.applyShadowCardViewStyle()
        }
    }
    @IBOutlet var explicitnessView: UIView!
    @IBOutlet var detailTable: DynamicSizedTableView! {
        didSet {
            detailTable.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
            detailTable.applyShadowCardViewStyle()
        }
    }
    @IBOutlet var itemPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnTap = true
        navigationController?.hidesBarsOnSwipe = true
        bind()
    }
    
    func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.item
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] item in
                guard let url = item?.artworkUrl100,
                      let data = try? Data(contentsOf: url) else { return }
                self?.itemImage.image = UIImage(data: data)
                self?.itemNameLabel.text = item?.collectionName ?? "-"
                self?.itemPriceLabel.text = item?.collectionPrice?.priceFormatted ?? "-"
                self?.itemMediaTypeLabel.text = item?.kind?.rawValue ?? "-"
                self?.explicitnessView.isHidden = item?.collectionExplicitness != .explicit
                self?.detailTable.reloadData()
            }).disposed(by: disposeBag)
        
    }

}

extension ItemDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel?.item.value?.getDetailList().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell else {
            fatalError("DetailTableViewCell is not found")
        }
        let data = viewModel?.item.value?.getDetailList()[indexPath.row]
        cell.configure(data: data)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

