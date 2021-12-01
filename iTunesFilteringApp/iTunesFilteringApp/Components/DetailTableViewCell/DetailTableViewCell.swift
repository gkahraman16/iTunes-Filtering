//
//  DetailTableViewCell.swift
//  HBCase
//
//  Created by Gozde Kahraman on 13.11.2021.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: (String,String?)?) {
        titleLabel.text = data?.0
        descriptionLabel.text = data?.1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
