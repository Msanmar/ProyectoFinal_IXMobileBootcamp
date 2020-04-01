//
//  TabBarController.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let topicsController: UIViewController
    let categoriesController: UIViewController
    let newTopicController: UIViewController
    
    init(topicsController: UIViewController, categoriesController: UIViewController, newTopicController: UIViewController) {
        self.topicsController = topicsController
        self.categoriesController = categoriesController
        self.newTopicController = newTopicController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    private func configureTabBar() {
        self.delegate = self
        let topicsController = self.topicsController
        let categoriesController = self.categoriesController
        let newTopicController = self.newTopicController
        
        topicsController.tabBarItem = UITabBarItem(title: "Latest Topics", image: nil, selectedImage: nil)
        categoriesController.tabBarItem = UITabBarItem(title: "Categories", image: nil, selectedImage: nil)
        newTopicController.tabBarItem = UITabBarItem(title: "New Topic", image: nil, selectedImage: nil)
        
        
        //Colores del tabBar
         self.tabBar.barTintColor = UIColor.black
         self.tabBar.barStyle = .blackOpaque
         self.tabBar.tintColor = UIColor.orange

        
        //self.tabBar.barTintColor = .white
        let navigTopics = UINavigationController(rootViewController: topicsController)
        let navigCategories = UINavigationController(rootViewController: categoriesController)
        let navigNewTopic = UINavigationController(rootViewController: newTopicController)
        
        topicsController.title = "Latest Topics"
        categoriesController.title = "Categories"
        newTopicController.title = "New Topic"
        
        
        let controllers = [ navigCategories, navigTopics, navigNewTopic]
        //let controllers = [navigTopics,navigCategories]
        self.setViewControllers(controllers, animated: true)
        
        //self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    }

}

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
  
        switch (item.title) {
        case "Latest Topics":
            print("Seleccionado Topics")
        case "Categories":
            print("Seleccionado Categories")
           // categoriesController.viewDidLoad()
        case "New Topic":
            print("Seleccionado Create new Topic")
           
        default:
            print("Ninguna de las dos")
        }
        
    }
    
}
