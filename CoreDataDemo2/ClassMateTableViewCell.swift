//
//  ClassMateTableViewCell.swift
//  CoreDataDemo
//
//  Created by Terry on 16/5/12.
//  Copyright © 2016年 Terry. All rights reserved.
//

import UIKit

class ClassMateTableViewCell: UITableViewCell {

    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var star: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
