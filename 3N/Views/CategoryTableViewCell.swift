//
//  CategoryCellTableViewCell.swift
//  3N
//
//  Created by Erkan Kızgın on 5.10.2022.
//

import UIKit

class CategoryCellTableViewCell: UITableViewCell {

    let title: UILabel = {
        var label = UILabel()
        label.text = "Deneme"
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubview(title)
        title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
