//
//  ViewController.swift
//  inTouch
//
//  Created by surendra kumar on 12/8/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var filteredCandies = [MOCK_DATA]()
    let section = ["name", "notes","organisation","city","PhoneNumber"]
    
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
        APIManager.shared.getContactDetails(text: text) { name,note,org,city,number in
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
            
            if let _number = number{
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
        if totalItemCount() <= 0 && !isFiltering(){
            return ""
        }
        return self.section[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0{
            return  isFiltering() && self.names.count == 0  ? 1 : self.names.count
        }
        if section == 1{
            return  isFiltering() && self.notes.count == 0 ? 1 : self.notes.count
        }
        if section == 2{
            return  isFiltering() && self.organisation.count == 0 ? 1 : self.organisation.count
        }
        if section == 3{
            return  isFiltering() && self.city.count == 0 ? 1 : self.city.count
        }
        if section == 4{
            return  isFiltering() && self.city.count == 0 ? 1 : self.number.count
        }
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let candy: MOCK_DATA?
//        if isFiltering() {
//            candy = filteredCandies[indexPath.row]
//        } else {
//            candy = nil
//        }
//        cell.textLabel!.text = candy?.name
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.section == 0{
            if self.names.count <= 0 {
              cell.textLabel?.text = "Did Not Match"
               
            }else{
               cell.textLabel?.text = self.names[indexPath.row].name
            }
            
        }
        if indexPath.section == 1{
            if self.notes.count <= 0 {
                cell.textLabel?.text = "Did Not Match Notes"
                
            }else{
                cell.textLabel?.text = self.notes[indexPath.row].notes
            }
        }
        
        if indexPath.section == 2{
            if self.organisation.count <= 0 {
                cell.textLabel?.text = "Did Not Match"
                
            }else{
                cell.textLabel?.text = self.organisation[indexPath.row].organisation
            }
            
        }
        if indexPath.section == 3{
            if self.city.count <= 0 {
                cell.textLabel?.text = "Did Not Match"
                
            }else{
                cell.textLabel?.text = self.city[indexPath.row].city
            }
            
        }
        if indexPath.section == 4{
            if self.number.count <= 0 {
                cell.textLabel?.text = "Did Not Match"
                
            }else{
                cell.textLabel?.text = "\(self.number[indexPath.row].number)"
            }
            
        }
        return cell
    }
    
}

extension ViewController :  UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
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
}
extension UIViewController{
    public func showAlert(title : String, message: String, buttonText: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

