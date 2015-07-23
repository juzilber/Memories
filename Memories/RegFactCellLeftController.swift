//
//  RegFactCellLeftController.swift
//  Memories
//
//  Created by Thiago Gallego on 23/07/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class RegFactCellLeftController: UITableViewCell {

    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var datePicker: UITextField!
    @IBOutlet var subtitleTextView: UITextView!
    @IBOutlet var audioButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
