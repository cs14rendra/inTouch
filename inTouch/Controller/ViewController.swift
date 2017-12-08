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
    
    func applyFilter(text : String) -> Results<MOCK_DATA>{
        let uirealm = try! Realm()
        let namepredicate = NSPredicate(format: "name CONTAINS '\(text)'")
        let notepredicate = NSPredicate(format: "notes CONTAINS '\(text)'")
        let query = NSCompoundPredicate(orPredicateWithSubpredicates: [namepredicate,notepredicate])
        let a = uirealm.objects(MOCK_DATA.self).filter(query)
        return a
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
        filteredCandies = Array(applyFilter(text: searchText))
        tableView.reloadData()
    }
}

extension ViewController :  UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCandies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let candy: MOCK_DATA?
        if isFiltering() {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = nil
        }
        cell.textLabel!.text = candy?.name
        return cell
    }
    
}

extension ViewController :  UITableViewDelegate{
    
}
extension UIViewController{
    public func showAlert(title : String, message: String, buttonText: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

