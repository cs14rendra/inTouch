//
//  NumberCell.swift
//  inTouch
//
//  Created by surendra kumar on 12/9/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit

class NumberCell: UITableViewCell {
    @IBOutlet weak var lb: UILabel!
    var number : String?
    var contact : DetailsViewModelItem?{
        didSet{
            guard let number = contact as? Number else {return}
            self.lb.text = number.number
            self.number = number.number
        }
    }

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    @IBAction func call(_ sender: Any) {
        guard let num = number else {return}
        let _url = URL(string:"tel:/\(num)")
        guard  let url = _url else {
            return
        }
        if UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    @IBAction func sms(_ sender: Any) {
        guard let num = number else {return}
        let _url = URL(string:"sms:/\(num)")
        guard  let url = _url else {
            return
        }
        if UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
