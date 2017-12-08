//
//  ViewController.swift
//  inTouch
//
//  Created by surendra kumar on 12/8/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftRichString

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let section = ["Name", "Notes","Organisation","City","PhoneNumber"]
    let red = Style("", {
        $0.color = UIColor.red
    })
    
    var searchText : String?
    var names = [MOCK_DATA](){
        didSet{
          self.tableView.reloadData()
        }
    }
    var notes = [MOCK_DATA](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var organisation = [MOCK_DATA](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var city = [MOCK_DATA](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var number = [MOCK_DATA](){
        didSet{
            self.tableView.reloadData()
        }
    }
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
    }
    
   
    @IBAction func get(_ sender: Any) {
    }
    
    func applyFilter(text : String){
        self.searchText = text
        APIManager.shared.getContactDetails(text: text) { name,note,org,city,num in
            if let _name = name{
                self.names = _name
            }
            if let _org = org {
                self.organisation = _org
            }
            if let _note = note {
                self.notes = _note
            }
            if let _city = city {
                self.city = _city
            }
            
            if let _number = num{
                self.number = _number
            }
            
        }
       
    }
    
    func totalItemCount()-> Int{
        return self.names.count + self.notes.count + self.organisation.count + self.notes.count + self.number.count
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
}

extension ViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
   
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        applyFilter(text: searchText)
    }
    
}


extension ViewController :  UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //print(totalItemCount())
        //print(isFiltering())
        if totalItemCount() <= 0 && !isFiltering(){
            return ""
        }
        return self.section[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0 :
            return  isFiltering() && self.names.count == 0  ? 1 : self.names.count
        case 1 :
            return  isFiltering() && self.notes.count == 0 ? 1 : self.notes.count
        case 2 :
            return  isFiltering() && self.organisation.count == 0 ? 1 : self.organisation.count
        case 3 :
            return  isFiltering() && self.city.count == 0 ? 1 : self.city.count
        case 4 :
            return  isFiltering() && self.number.count == 0 ? 1 : self.number.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.section {
        case 0 :
            if self.names.count <= 0 {
              cell.textLabel?.text = "No results!"
               
            }else{
                let text = self.names[indexPath.row].name
                let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
                cell.textLabel?.attributedText = attributedText
            }
        case 1 :
            if self.notes.count <= 0 {
                cell.textLabel?.text = "No results!"
                
            }else{
                let text = self.notes[indexPath.row].notes
                let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
                cell.textLabel?.attributedText = attributedText
            }
        
       case 2 :
            if self.organisation.count <= 0 {
                cell.textLabel?.text = "No results!"
                
            }else{
                let text = self.organisation[indexPath.row].organisation
                let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
                cell.textLabel?.attributedText = attributedText
            }
        case 3 :
            if self.city.count <= 0 {
                cell.textLabel?.text = "No results!"
                
            }else{
                let text = self.city[indexPath.row].city
                let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
                cell.textLabel?.attributedText = attributedText
            }
        case 4 :
            if self.number.count <= 0 {
                cell.textLabel?.text = "No results!"
                
            }else{
                let text = "\(self.number[indexPath.row].number)"
                let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
                cell.textLabel?.attributedText = attributedText
            }
        default :
            break
        }
        return cell
    }
}

extension ViewController :  UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath)
        let vc = DetailsVC()
        switch indexPath.section {
        case 0:
            vc.contact = self.names[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        case 1:
            vc.contact = self.notes[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        case 2:
            vc.contact = self.organisation[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        case 3:
            vc.contact = self.city[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        case 4:
            vc.contact = self.number[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let title = view as? UITableViewHeaderFooterView{
            title.textLabel?.textColor = UIColor.red
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let firstactin = UITableViewRowAction(style: .default, title: "Delete", handler: {(action, indexpath) in
            do{
               try self.deleteData(at: indexPath)
            }catch{
               print(error.localizedDescription)
            }
            print("deleted")
        })
        let secondtactin = UITableViewRowAction(style: .default, title: "share", handler: {(action, indexpath) in
            print("share")
        })
        
        firstactin.backgroundColor = UIColor.gray
        secondtactin.backgroundColor = UIColor.green
        return [firstactin,secondtactin]
    }
}

extension ViewController{
    func deleteData(at indexPath : IndexPath) throws{
        switch indexPath.section {
        case 0:
            let item = self.names[indexPath.row]
            let realm = try! Realm()
            try realm.write{
                    realm.delete(item)
                    self.tableView.beginUpdates()
                    self.names.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .top)
                    self.tableView.endUpdates()
            }
        case 1:
            let item = self.notes[indexPath.row]
            let realm = try! Realm()
            try realm.write{
                realm.delete(item)
                self.tableView.beginUpdates()
                self.notes.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .top)
                self.tableView.endUpdates()
            }
            
        case 2:
            let item = self.organisation[indexPath.row]
            let realm = try! Realm()
            try realm.write{
                realm.delete(item)
                self.tableView.beginUpdates()
                self.organisation.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .top)
                self.tableView.endUpdates()
            }
        case 3:
            let item = self.city[indexPath.row]
            let realm = try! Realm()
            try realm.write{
                realm.delete(item)
                self.tableView.beginUpdates()
                self.city.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .top)
                self.tableView.endUpdates()
            }
        case 4:
            let item = self.number[indexPath.row]
            let realm = try! Realm()
            try realm.write{
                realm.delete(item)
                self.tableView.beginUpdates()
                self.number.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .top)
                self.tableView.endUpdates()
            }
        default:
            break
        }
    }
}
extension UIViewController{
    public func showAlert(title : String, message: String, buttonText: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

