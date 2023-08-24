//
//  MultipleOptionsTableViewCell.swift
//  MAD CW2
//
//  Created by user239258 on 8/24/23.
//

import UIKit

class MultipleOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLbl: UILabel!
    @IBOutlet weak var optionCheckMarkImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
