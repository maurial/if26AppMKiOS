//
//  MarkTableViewCell.swift
//  if26AppMK
//
//  Created by if26-grp3 on 20/12/2017.
//  Copyright © 2017 if26-grp3. All rights reserved.
//

import UIKit

class MarkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var subjectCodeLabel: UILabel!
    @IBOutlet weak var subjectMarkLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
