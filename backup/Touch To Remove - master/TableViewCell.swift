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
    //moon.setTitle("ready", for: .normal)
    @IBOutlet weak var countLb: UILabel!
    @IBOutlet weak var slugLb: UILabel!
    @IBOutlet weak var nConfLb: UILabel!
    //@IBOutlet weak var nDeathLb: UILabel!
    //@IBOutlet weak var tDeathLb: UILabel!
    //@IBOutlet weak var nRecLb: UILabel!
   // @IBOutlet weak var tRecLb: UILabel!
    //@IBOutlet weak var tConfirmed: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
