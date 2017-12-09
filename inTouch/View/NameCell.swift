//
//  NameCell.swift
//  inTouch
//
//  Created by surendra kumar on 12/9/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {

    @IBOutlet weak var lb: UILabel!
    
    var contact : DetailsViewModelItem?{
        didSet{
            guard let name = contact as? Name else {return}
            self.lb.text = name.name
        }
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
