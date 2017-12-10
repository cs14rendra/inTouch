//
//  Model.swift
//  inTouch
//
//  Created by surendra kumar on 12/8/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import Foundation
import RealmSwift

class APIManager{
    private static let _shared = APIManager()
    public static var shared : APIManager{
        return self._shared
    }
    
    func getContactDetails(text: String, completion: ((Array<Contacts>?,Array<Contacts>?,Array<Contacts>?,Array<Contacts>?,Array<Contacts>?))->()){
        guard let _realm = realm else {return}
        let uirealm = _realm
/*
         Realm have limited Search feature on Interger. better to change model and store
         Int as String to better Search and user experience.
 */
        let numberQuery = NSPredicate(format: "number CONTAINS '\(text)'")
        let namequery = NSPredicate(format: "name CONTAINS '\(text)'")
        let notequery = NSPredicate(format: "notes CONTAINS '\(text)'")
        let organisationquery = NSPredicate(format: "organisation CONTAINS '\(text)'")
        let cityquery = NSPredicate(format: "city CONTAINS '\(text)'")
        let names = uirealm.objects(Contacts.self).filter(namequery)
        let numbers = uirealm.objects(Contacts.self).filter(numberQuery)
        let notes = uirealm.objects(Contacts.self).filter(notequery)
        let org = uirealm.objects(Contacts.self).filter(organisationquery)
        let c = uirealm.objects(Contacts.self).filter(cityquery)
        let _num = Array(numbers)
        let _names  = Array(names)
        let _notes = Array(notes)
        let _organisation  = Array(org)
        let _city  = Array(c)
        completion((_names,_notes,_organisation,_city,_num))
    }
}
