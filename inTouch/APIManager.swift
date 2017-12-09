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
    
    func getContactDetails(text: String, completion: ((Array<MOCK_DATA>?,Array<MOCK_DATA>?,Array<MOCK_DATA>?,Array<MOCK_DATA>?,Array<MOCK_DATA>?))->()){
        guard let _realm = realm else {return}
        let uirealm = _realm
        let number = Int(text)
        var _num : Array<MOCK_DATA>?
        if number != nil {
            let numberPredicate = NSPredicate(format: "number == \(number!)")
            let numbers = uirealm.objects(MOCK_DATA.self).filter(numberPredicate)
            _num = Array(numbers)
        }
        let namepredicate = NSPredicate(format: "name CONTAINS '\(text)'")
        let notepredicate = NSPredicate(format: "notes CONTAINS '\(text)'")
        let organisationpredicate = NSPredicate(format: "organisation CONTAINS '\(text)'")
        let citypredicate = NSPredicate(format: "city CONTAINS '\(text)'")
        let namequery = NSCompoundPredicate(orPredicateWithSubpredicates: [namepredicate])
        let notequery = NSCompoundPredicate(orPredicateWithSubpredicates: [notepredicate])
        let names = uirealm.objects(MOCK_DATA.self).filter(namequery)
        let _names  = Array(names)
        let notes = uirealm.objects(MOCK_DATA.self).filter(notequery)
        let _notes = Array(notes)
        let org = uirealm.objects(MOCK_DATA.self).filter(organisationpredicate)
        let _organisation  = Array(org)
        let c = uirealm.objects(MOCK_DATA.self).filter(citypredicate)
        let _city  = Array(c)
        completion((_names,_notes,_organisation,_city,_num))
    }
}
