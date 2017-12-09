//
//  ContactCell.swift
//  inTouch
//
//  Created by surendra kumar on 12/8/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var lb: UILabel!
    @IBOutlet weak var img: UIImageView!
    var contact : MOCK_DATA?{
        didSet{
            guard let name = contact?.name  else {return}
            self.lb.text = name
        }
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        self.img.image = nil
    }
}
