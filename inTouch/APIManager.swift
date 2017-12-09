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
        let numberPredicate = NSPredicate(format: "number CONTAINS '\(text)'")
        let namepredicate = NSPredicate(format: "name CONTAINS '\(text)'")
        let notepredicate = NSPredicate(format: "notes CONTAINS '\(text)'")
        let organisationpredicate = NSPredicate(format: "organisation CONTAINS '\(text)'")
        let citypredicate = NSPredicate(format: "city CONTAINS '\(text)'")
        let namequery = NSCompoundPredicate(orPredicateWithSubpredicates: [namepredicate])
        let notequery = NSCompoundPredicate(orPredicateWithSubpredicates: [notepredicate])
        let numberQuery = NSCompoundPredicate(orPredicateWithSubpredicates: [numberPredicate])
        let names = uirealm.objects(Contacts.self).filter(namequery)
        let numbers = uirealm.objects(Contacts.self).filter(numberQuery)
        let _num = Array(numbers)
        let _names  = Array(names)
        let notes = uirealm.objects(Contacts.self).filter(notequery)
        let _notes = Array(notes)
        let org = uirealm.objects(Contacts.self).filter(organisationpredicate)
        let _organisation  = Array(org)
        let c = uirealm.objects(Contacts.self).filter(citypredicate)
        let _city  = Array(c)
        
        completion((_names,_notes,_organisation,_city,_num))
    }
}
