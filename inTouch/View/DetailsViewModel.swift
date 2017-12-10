//
//  DetailsViewModel.swift
//  inTouch
//
//  Created by surendra kumar on 12/9/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import Foundation
import UIKit

enum DetailsViewModelItemType {
    case name
    case number
    case notes
    case city
    case org
}

protocol DetailsViewModelItem {
    //MARK: - Properties
    var type: DetailsViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class DetailsViewModel: NSObject{
    var items = [DetailsViewModelItem]()
    init(_data : Contacts?) {
        guard let data = _data else {return}
        items.append(Name(name: data.name))
        items.append(Number(number: "\(data.number)"))
        items.append(Notes(notes: data.notes))
        items.append(Orgnanisation(orgnanisation: data.organisation))
        items.append(City(city: data.city))
    }
}

    //MARK: - Extensions
extension DetailsViewModel : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .name:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: indexPath) as? NameCell{
                cell.contact = item
                return cell
            }
    
        case .number:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NumberCell.identifier, for: indexPath) as? NumberCell{
                cell.contact = item
                return cell
            }
        case .notes:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NotesCell.identifier, for: indexPath) as? NotesCell{
                cell.contact = item
                return cell
            }
        case .city:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as? CityCell{
                cell.contact = item
                return cell
            }
        case .org:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OrgCell.identifier, for: indexPath) as? OrgCell{
                cell.contact = item
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}

class Name : DetailsViewModelItem{
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    var type: DetailsViewModelItemType {
        return .name
    }
    var sectionTitle: String {
        return ""
    }
    var rowCount: Int {
        return 1
    }
}

class Number : DetailsViewModelItem{
    
    var number: String
    
    init(number: String) {
        self.number = number
    }
    var type: DetailsViewModelItemType {
        return .number
    }
    var sectionTitle: String {
        return ""
    }
    var rowCount: Int {
        return 1
    }
}

class Notes : DetailsViewModelItem{
    
    var notes: String
    
    init(notes: String) {
        self.notes = notes
    }
    var type: DetailsViewModelItemType {
        return .notes
    }
    var sectionTitle: String {
        return ""
    }
    var rowCount: Int {
        return 1
    }
}

class Orgnanisation : DetailsViewModelItem{
    
    var orgnanisation: String
    
    init(orgnanisation: String) {
        self.orgnanisation = orgnanisation
    }
    var type: DetailsViewModelItemType {
        return .org
    }
    var sectionTitle: String {
        return "Orgnanisation"
    }
    var rowCount: Int {
        return 1
    }
}

class City : DetailsViewModelItem{
    
    var city: String
    
    init(city: String) {
        self.city = city
    }
    var type: DetailsViewModelItemType {
        return .city
    }
    var sectionTitle: String {
        return "City"
    }
    var rowCount: Int {
        return 1
    }
}

