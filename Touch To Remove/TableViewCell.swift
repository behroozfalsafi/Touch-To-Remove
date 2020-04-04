//
//  TableViewCell.swift
//  LoadfromJSON
//
//  Created by Behrooz Falsafi on 3/27/20.
//  Copyright © 2020 Behrooz Falsafi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var moon: UIButton!
    @IBOutlet weak var countLb: UILabel!
    @IBOutlet weak var slugLb: UILabel!
    @IBOutlet weak var nConfLb: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
