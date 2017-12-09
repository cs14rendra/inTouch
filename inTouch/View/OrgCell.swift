//
//  OrgCell.swift
//  inTouch
//
//  Created by surendra kumar on 12/9/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit

class OrgCell: UITableViewCell {
    @IBOutlet weak var lb: UILabel!
    
    var contact : DetailsViewModelItem?{
        didSet{
            guard let org = contact as? Orgnanisation else {return}
            self.lb.text = org.orgnanisation
        }
    }

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
