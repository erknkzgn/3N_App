//
//  CategoryCellTableViewCell.swift
//  3N
//
//  Created by Erkan Kızgın on 5.10.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    var title: UILabel = {
        let label = UILabel()
        label.text = "asdfs"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(title)
        title.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, paddingTop: 2, paddingLeft: 10, paddingBottom: 2, paddingRight: 10, width: 70, height: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }

}
