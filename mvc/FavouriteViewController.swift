//
//  FavouriteViewController.swift
//  mvc
//
//  Created by Mac on 27/4/23.
//

import UIKit
import SnapKit

class FavouriteViewController: UIViewController {
    
    private let userDefaults = UserDefaults.standard
    

    private lazy var favouritesTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .cyan
        view.rowHeight = 150
        return view
    }()
   
    var products: [Product] = UsDef.shared.savedProductsArray
    
    func setupTableView(){
        favouritesTableView.register(FavoriteTableViewCel.self, forCellReuseIdentifier: FavoriteTableViewCel.reuceID)
        favouritesTableView.dataSource = self
        favouritesTableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFavUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableview), name: NSNotification.Name("reloadTableView"), object: nil)
    }
    
    func setupFavUI(){
        view.addSubview(favouritesTableView)
        favouritesTableView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
    }
    
   @objc func reloadTableview(){
        favouritesTableView.reloadData()
    }
}






extension FavouriteViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return UsDef.shared.savedProductsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favouritesTableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCel.reuceID, for: indexPath) as? FavoriteTableViewCel else{fatalError()}
        let item = UsDef.shared.savedProductsArray[indexPath.row]
        cell.display(item: item )
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteCell(_ sender: UIButton){
        let index = sender.tag
        UsDef.shared.savedProductsArray.remove(at: index)
        favouritesTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .middle)
        favouritesTableView.reloadData()
    }
    
}


extension FavouriteViewController: ProductActions{
    func favoriteTap(index: Int) {
        ()
    }
    
    func deleteTap(index: Int) {
        ()
    }
    
    
}

