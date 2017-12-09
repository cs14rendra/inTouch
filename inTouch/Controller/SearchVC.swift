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
    let section = ["Name","PhoneNumber","Organisation","City", "Notes"]
    let red = Style("", {
        $0.color = UIColor.red
    })
    
    var searchText : String?
    var names = [Contacts](){
        didSet{
          self.tableView.reloadData()
        }
    }
    var notes = [Contacts](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var organisation = [Contacts](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var city = [Contacts](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var number = [Contacts](){
        didSet{
            self.tableView.reloadData()
        }
    }
    let searchController = UISearchController(searchResultsController: nil)
    var emptyView : UIView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for anyone"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.tableView.register(ContactCell.nib, forCellReuseIdentifier: ContactCell.identifier)
        let mynib = Bundle.main.loadNibNamed("EmptyV", owner: self, options: nil)
        self.emptyView = mynib?.first as? UIView
        self.emptyView?.frame = self.view.bounds
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:)))
        self.emptyView?.addGestureRecognizer(tap)
        
    }
   
    @objc func tap(_ sender: UITapGestureRecognizer) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
            self.tableView.backgroundView = emptyView
            self.tableView.separatorStyle = .none
            return ""
        }else{
            self.tableView.backgroundView = nil
        }
        self.tableView.separatorStyle = .singleLine
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
            return  isFiltering() && self.number.count == 0 ? 1 : self.number.count
        case 2 :
            return  isFiltering() && self.organisation.count == 0 ? 1 : self.organisation.count
        case 3 :
            return  isFiltering() && self.city.count == 0 ? 1 : self.city.count
        case 4 :
            return  isFiltering() && self.notes.count == 0 ? 1 : self.notes.count
        default:
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        switch indexPath.section {
        case 0 :
            let c = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
            c.img.image = UIImage(named: "user")
            if self.names.count <= 0 {
              c.lb.text = "No results!"
              c.selectionStyle = .none
            }else{
                let text = self.names[indexPath.row].name
                let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
                c.lb.attributedText = attributedText
            }
            return c
        case 1 :
            let c = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
            c.img.image = UIImage(named: "call")
            if self.number.count <= 0 {
                c.lb.text = "No results!"
                cell.selectionStyle = .none
                
            }else{
                let text = "\(self.number[indexPath.row].number)"
                let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
                c.lb.attributedText = attributedText
            }
            return c
       case 2 :
        let c = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
        c.img.image = UIImage(named: "org")
        if self.organisation.count <= 0 {
            c.lb.text = "No results!"
            cell.selectionStyle = .none
            
        }else{
            let text = "\(self.organisation[indexPath.row].organisation)"
            let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
            c.lb.attributedText = attributedText
        }
        return c
        case 3 :
            let c = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
            c.img.image = UIImage(named: "city")
            if self.city.count <= 0 {
                c.lb.text = "No results!"
                cell.selectionStyle = .none
                
            }else{
                let text = "\(self.city[indexPath.row].city)"
                let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
                c.lb.attributedText = attributedText
            }
            return c
        case 4 :
            let c = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
            c.img.image = UIImage(named: "notes")
            if self.notes.count <= 0 {
                c.lb.text = "No results!"
                c.selectionStyle = .none
            }else{
                let text = self.notes[indexPath.row].notes
                let attributedText = text.set(styles: red, pattern: "\(searchText!)", options: .caseInsensitive)
                c.lb.attributedText = attributedText
            }
            return c
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
        //let nav = UINavigationController(rootViewController: vc)
        
        switch indexPath.section {
        case 0:
            guard self.names.count > 0 else {return}
            vc.contact = self.names[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        case 1:
            guard self.number.count > 0 else {return}
            vc.contact = self.number[indexPath.row]
            self.present(vc, animated: true, completion: nil)
           
        case 2:
            guard self.organisation.count > 0 else {return}
            vc.contact = self.organisation[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        case 3:
            guard self.city.count > 0 else {return}
            vc.contact = self.city[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        case 4:
            guard self.notes.count > 0 else {return}
            vc.contact = self.notes[indexPath.row]
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
        let secondtactin = UITableViewRowAction(style: .default, title: "Fav", handler: {(action, indexpath) in
            print("feb")
            // TODO DO All"
            let section = indexPath.section
            switch section{
            case 0 :
                let numberString = self.names[indexPath.row].number
                self.savefeb(forNumber: numberString)
            case 1 :
                let numberString = self.number[indexPath.row].number
                self.savefeb(forNumber: numberString)
            case 2 :
                let numberString = self.organisation[indexPath.row].number
                self.savefeb(forNumber: numberString)
            case 3 :
                let numberString = self.city[indexPath.row].number
                self.savefeb(forNumber: numberString)
            case 4 :
                let numberString = self.notes[indexPath.row].number
                self.savefeb(forNumber: numberString)
            default: break
            }
        })
        
        firstactin.backgroundColor = UIColor.red
        secondtactin.backgroundColor = UIColor.gray
        return [firstactin,secondtactin]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController{
    func savefeb(forNumber number: String){
        let obj = feb()
        obj.number = number
        do{
            try  realm?.write {
                realm?.add(obj)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
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
            let item = self.number[indexPath.row]
            let realm = try! Realm()
            try realm.write{
                realm.delete(item)
                self.tableView.beginUpdates()
                self.number.remove(at: indexPath.row)
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
            
            let item = self.notes[indexPath.row]
            let realm = try! Realm()
            try realm.write{
                realm.delete(item)
                self.tableView.beginUpdates()
                self.notes.remove(at: indexPath.row)
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

