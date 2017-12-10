//
//  FavContacts.swift
//  inTouch
//
//  Created by surendra kumar on 12/10/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import Foundation

class FavContacts{
    private static let _shared = FavContacts()
    public static var shared : FavContacts{
        return self._shared
    }
   
    func fetchFeb(completion : (Array<Contacts>?)->()){
        let _data = realm?.objects(feb.self)
        guard let data = _data else {return}
        let allNumber = Array(data)
        var mkd = [Contacts]()
        for number in allNumber{
            let _actulaData = self.fetchActualData(forNumber: number.number)
            if let actualData = _actulaData{
                mkd.append(actualData)
            }
        }
        completion(mkd)
    }
    
   private  func fetchActualData(forNumber number: String) -> Contacts?{
        let query = NSPredicate(format: "number == '\(number)'")
        let _mk = realm?.objects(Contacts.self).filter(query)
        if let mk = _mk{
            // assuming evreyone get unique number
            let data = Array(mk).first
            return data
        }
        return nil
    }
    
}
