//
//  FebVC.swift
//  inTouch
//
//  Created by surendra kumar on 12/9/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit

class FebVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var f = [Contacts](){
        didSet{
            self.tableView.reloadData()
        }
    }

    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ContactCell.nib, forCellReuseIdentifier: ContactCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FavContacts.shared.fetchFeb { (_contacts) in
            guard let contacts = _contacts else {return}
            self.f = contacts
        }
    }
}

    //MARK: - Extensions
//MARK: - UITableViewDataSource
extension FebVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemcount = f.count
        if itemcount <= 0{
            self.tableView.backgroundView = UIView()
            return 0
        }
        return itemcount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
        let contact = f[indexPath.row]
        cell.contact = contact
        return cell
    }
    
    
}
//MARK: - UITableViewDelegate
extension FebVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = f[indexPath.row]
        let vc = DetailsVC()
        vc.contact = contact
        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexpath) in
            print("delete")
            let number = self.f[indexPath.row].number
            let _object =  realm?.objects(feb.self).filter("number == '\(number)'").first
            if let object = _object {
                do{
                    try realm?.write {
                        realm?.delete(object)
                    }
                self.tableView.beginUpdates()
                self.f.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .top)
                self.tableView.endUpdates()
                self.showAlert(title: "Success", message: "Contact has been removed from Favorite, It is still in main contact list", buttonText: "OK")
                }catch{
                    print(error.localizedDescription)
                }
            }
           
        }
        return [action]
    }
}


