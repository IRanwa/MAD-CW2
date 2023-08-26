//
//  UserCommentTableViewCell.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//

import UIKit

class UserCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserComment: UILabel!
    @IBOutlet weak var lblUserAndDate: UILabel!
    @IBOutlet weak var lblUserRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
