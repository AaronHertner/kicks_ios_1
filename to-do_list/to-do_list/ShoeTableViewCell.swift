//
//  ShoeTableViewCell.swift
//  to-do_list
//
//  Created by User on 2020-08-22.
//  Copyright © 2020 aaronhertner. All rights reserved.
//

import UIKit

class ShoeTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: CustomControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

