//
//  ItemViewCell.swift
//  HBCase
//
//  Created by Gozde Kahraman on 11.11.2021.
//

import UIKit

class ItemViewCell: UICollectionViewCell {

    @IBOutlet var frameView: UIView! {
        didSet {
            frameView.applyShadowCardViewStyle()
        }
    }
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var productImage: UIImageView! {
        didSet {
            productImage.layer.cornerRadius = 5
            productImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
    }
    
    @IBOutlet var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func configure(with data: ResultItem?){
        titleLabel.text = data?.collectionName ?? "-"
        bodyLabel.text = data?.collectionPrice?.priceFormatted ?? "-"
        releaseDate.text = data?.releaseDate?.dateFormatted(format: "dd.MM.yyyy") ?? "-"
        frameView.applyMediaTypeStyle(mediaType: data?.kind)
        
        if let url = data?.artworkUrl100, let imgData = try? Data(contentsOf: url) {
            productImage.image = UIImage(data: imgData)
        }else {
            productImage.backgroundColor = .lightGray
        }
    }
}


private extension UIView {
    func applyMediaTypeStyle(mediaType: MediaType?){
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        containerView.layer.cornerRadius = 5
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        addSubview(containerView)
        var imgName = "questionmark"
        switch mediaType {
        case .movie:
            containerView.backgroundColor = .systemYellow
            imgName = "film"
        case .music:
            containerView.backgroundColor = .purple
            imgName = "music.note"
        case .ebook:
            containerView.backgroundColor = .systemGreen
            imgName = "book.fill"
        case .podcast:
            containerView.backgroundColor = .systemBlue
            imgName = "mic.fill"
        default:
            containerView.backgroundColor = .darkGray
        }
        let img = UIImage(systemName: imgName)
        let imageView = UIImageView(image: img)
        imageView.tintColor = .white
        imageView.frame = CGRect(x: 6, y: 6, width: 18, height: 18)
        containerView.addSubview(imageView)
    }
}
