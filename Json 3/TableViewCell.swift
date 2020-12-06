//
//  TableViewCell.swift
//  Json 3
//
//  Created by Sebastian Salazar Reyes on 12/27/18.
//  Copyright © 2018 Sebastian Salazar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var moneyConverted1: UIView!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
