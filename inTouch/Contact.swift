//
//  Contact.swift
//  inTouch
//
//  Created by surendra kumar on 12/8/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import Foundation
import RealmSwift

class Contacts: Object{
    @objc dynamic var name : String = ""
    /*
     Realm have limited Search feature on Interger. better to change model and store
     Int as String to better Search and user experience.
     */
    @objc  dynamic var number : String = ""
    @objc dynamic var notes : String = ""
    @objc dynamic var organisation : String = ""
    @objc dynamic var city : String = ""
}


