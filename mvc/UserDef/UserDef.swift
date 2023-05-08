//
//  UserDef.swift
//  mvc
//
//  Created by Mac on 7/5/23.
//

import Foundation
class UsDef{
    
    static let shared = UsDef()
    
    var defaults = UserDefaults.standard
    
    var savedProductsArray: [Product]{
        get{
            if let data = defaults.value(forKey: "savedProductsArray") as? Data{
                return try! PropertyListDecoder().decode([Product].self,from: data)
            } else{
                return [Product]()
            }
        }set{
            if let data = try? PropertyListEncoder().encode(newValue){
                defaults.set(data, forKey: "savedProductsArray")
            }
        }
    }
    
    func saveProducts(id: Int, title: String, description: String, price: Int, thumbnail: String){
        let product = Product(id: id, title: title, description: description, price: price, thumbnail: thumbnail)
        savedProductsArray.insert(product, at: 0)
    }
}
