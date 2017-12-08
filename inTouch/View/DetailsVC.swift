//
//  DetailsVC.swift
//  inTouch
//
//  Created by surendra kumar on 12/8/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    var contact : MOCK_DATA?{
        didSet{
            print(self.contact)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        Bundle.main.loadNibNamed("DetailsVC", owner: self, options: nil)
    }

}
