//
//  NotesCell.swift
//  inTouch
//
//  Created by surendra kumar on 12/9/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {
    @IBOutlet weak var lb: UILabel!
    
    var contact : DetailsViewModelItem?{
        didSet{
            guard let notes = contact as? Notes else {return}
            self.lb.text = notes.notes
        }
    }

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
