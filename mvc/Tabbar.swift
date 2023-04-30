//
//  Tabbar.swift
//  mvc
//
//  Created by Mac on 27/4/23.
//

import Foundation
import UIKit
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildViewControllers()
    }
    
    private func setupChildViewControllers() {
        let mainViewController = ViewController()
        let favouriteViewController = FavouriteViewController()
        
        let mainIcon = UIImage(systemName: "house.fill")
        let favouriteIcon = UIImage(systemName: "heart")
        
        viewControllers = [generateNavigatonController(rootViewController: mainViewController, image: mainIcon!), generateNavigatonController(rootViewController: favouriteViewController, image: favouriteIcon!)]
    }
    
    
    func generateNavigatonController(rootViewController: UIViewController, image: UIImage) -> UIViewController {
        let navigaionController = UINavigationController(rootViewController: rootViewController)
        navigaionController.tabBarItem.image = image
        return navigaionController
    }
    
}
