//
//  DetailsVC.swift
//  inTouch
//
//  Created by surendra kumar on 12/8/17.
//  Copyright © 2017 surendra kumar. All rights reserved.
//

import UIKit
import ParallaxHeader
import SnapKit
import FontAwesome_swift

class DetailsVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    var ViewModel : DetailsViewModel?
    var imageName : String?
    var contact : Contacts?{
        didSet{
            ViewModel = DetailsViewModel(_data: contact)
            if let number = contact?.number{
                let numInt = Int(number)
                if let _n = numInt{
                    let imageNumber = _n % 15
                    imageName = "\(imageNumber)"
                    setHeader(imageName: imageName!)
                }
                
            }else{
                setHeader(imageName: "defaultImage")
            }
        }
    }
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = ViewModel
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.sectionIndexBackgroundColor = UIColor.red
        tableView.register(NameCell.nib, forCellReuseIdentifier: NameCell.identifier)
        tableView.register(NumberCell.nib, forCellReuseIdentifier: NumberCell.identifier)
        tableView.register(NotesCell.nib, forCellReuseIdentifier: NotesCell.identifier)
        tableView.register(CityCell.nib, forCellReuseIdentifier: CityCell.identifier)
        tableView.register(OrgCell.nib, forCellReuseIdentifier: OrgCell.identifier)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func setHeader(imageName : String){
        let image = UIImage(named: imageName)
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.setTitle("Search", for: .normal)
        btn.addTarget(self, action: #selector(DetailsVC.backButtonPressed), for: .touchUpInside)
        self.view.addSubview(btn)
        let imageView = UIImageView(image: image )
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.blurView.setup(style: .dark, alpha: 1.0).enable()
        self.tableView.parallaxHeader.view = imageView
        self.tableView.parallaxHeader.height = 250
        self.tableView.parallaxHeader.minimumHeight = 145
        self.tableView.parallaxHeader.mode = .centerFill
        self.tableView.parallaxHeader.parallaxHeaderDidScrollHandler =
        { p in
            p.view.blurView.alpha = 1 - p.progress
        }
        let roundIcon = UIImageView(
            frame: CGRect(x: 0, y: 0, width: 100, height: 100)
        )
        roundIcon.image = image
        roundIcon.layer.borderColor = UIColor.white.cgColor
        roundIcon.layer.borderWidth = 2
        roundIcon.layer.cornerRadius = roundIcon.frame.width / 2
        roundIcon.clipsToBounds = true
        imageView.blurView.blurContentView?.addSubview(roundIcon)
        roundIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        btn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(45)
            make.left.equalTo(5)
            make.top.equalTo(20)
        }
    }
    
    @objc func backButtonPressed(){
        dismiss(animated: true, completion: nil)
    }
    override func loadView() {
        Bundle.main.loadNibNamed("DetailsVC", owner: self, options: nil)
    }
    @objc func done(){
        self.dismiss(animated: true, completion: nil)
    }
}

    //MARK: - Extensions
extension DetailsVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let v = view as? UITableViewHeaderFooterView {
            v.backgroundView?.backgroundColor = UIColor.clear
            v.textLabel?.textColor = UIColor.red
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}


