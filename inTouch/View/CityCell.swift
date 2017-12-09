//
//  CityCell.swift
//  inTouch
//
//  Created by surendra kumar on 12/9/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var lb: UILabel!
    
    var contact : DetailsViewModelItem?{
        didSet{
            guard let city = contact as? City else {return}
            self.lb.text = city.city
        }
    }

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
