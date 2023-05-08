//
//  maincontroller.swift
//  mvc
//
//  Created by Mac on 27/4/23.
//

import Foundation
import UIKit
import SnapKit
class ViewController: UIViewController{
    
    private var controller: MainController?
    
    private var searchBar = UISearchBar()
    
    private var isSearching = false
    
    private var filtredProd = [Product](){
        didSet{
            productsCollectionView.reloadData()
        }
    }
    
    
    
    
    lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .cyan
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        //setup serch
        controller = MainController(view: self)
        setupSubviews()
        view.backgroundColor = .cyan
        controller?.fetchProducts()
        self.searchBar.delegate = self
    }
    
    @objc func editingChanged() {
        getUserProduct()
        //        print(searchTextField.text!)
    }
    func getUserProduct(){
        //       controller?.findProducts(searchText: searchTextField.text ?? "")
        //        return searchTextField.text ?? ""
    }
    private  func setupSubviews() {
        view.addSubview(productsCollectionView)
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalTo(productsCollectionView.snp.top).inset(100)
            make.height.equalTo(100)
        }
    }
    func reloadProductsCollectionView() {
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
        }
    }
}
    
   





extension ViewController: UICollectionViewDataSource {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isSearching{
        return filtredProd.count
    }else{
        return controller?.getProducts().count ?? 0
        
    }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
    
    
    
    if isSearching {
        cell.fill(product: filtredProd[indexPath.row])
    }else{
        cell.fill(product: (controller?.getProducts()[indexPath.row])!)
    }
    
    cell.favouriteButton.tag = indexPath.item
    cell.favouriteButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    return cell
}
    
    @objc func buttonClicked(_ sender: UIButton) {
        let tapedtag = sender.tag

        let a = controller?.getProducts()[tapedtag]
        
//        for i in UsDef.shared.savedProductsArray{
//
            UsDef.shared.saveProducts(id:a?.id ?? 0, title: a?.title ?? "nil", description: a?.description ?? "d", price: a!.price ?? 0, thumbnail: a?.thumbnail ?? "d")
        NotificationCenter.default.post(name: NSNotification.Name("reloadTableView"), object: nil)
//        }
        
        print(UsDef.shared.savedProductsArray)//
    }
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let alert = UIAlertController(title: "Alert title", message: "Alert message", preferredStyle: .alert)
    let action2 = UIAlertAction(title: "Cancel", style: .cancel)
    alert.addAction(action2)
    
    let action3 = UIAlertAction(title: "Хотите перейти", style: .destructive) { [self] result in
        let vc = DetailViewController()
        vc.titleNameChangec = self.controller?.getProducts()[indexPath.row].title
        vc.imagePhone.kf.setImage(with: URL(string: (controller?.getProducts()[indexPath.row].thumbnail)!))
        vc.descriptionChange = self.controller?.getProducts()[indexPath.row].description
        self.present(vc, animated: true)
    }
    alert.addAction(action3)
    self.present(alert, animated: true)
}
}
    
    extension ViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (view.frame.width / 2) - 20, height: 290)
        }
    }

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filtredProd.removeAll()
        
//        if searchBar.text == "" {
//            isSearching = false
//            productsCollectionView.reloadData()
//        }else{
//            isSearching = true
//            filtredProd = controller?.getProducts().filter({(item)-> Bool in
//                return (item.title.localizedCaseInsensitiveContains(String(searchBar.text!)))!}) ?? "pzda"
//            productsCollectionView.reloadData()
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        productsCollectionView.reloadData()
    }
    
}



