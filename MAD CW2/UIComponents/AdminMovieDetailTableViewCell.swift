//
//  AdminMovieDetailTableViewCell.swift
//  MAD CW2
//
//  Created by user239258 on 8/23/23.
//

import UIKit

class AdminMovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieGenresLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
