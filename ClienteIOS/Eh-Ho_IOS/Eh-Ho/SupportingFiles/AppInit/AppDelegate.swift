//
//  AppDelegate.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit
import CoreData




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

  private let databaseCoreDataName = "Eh-Ho_Database"
    private var mUserPreferences = UserDefaultsPreferences()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: databaseCoreDataName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        })
        
        return container
    }()
    
    
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
      
        let ok_net = DetectNetwork()
        if ok_net.connected() {
            print("APP Delegate => Connected")
            
            
            let dateNetOK = Date()-100
            mUserPreferences.saveDateCategories(date: dateNetOK)
            mUserPreferences.saveDateLatestTopics(date: dateNetOK)
            mUserPreferences.saveDatePosts(date: dateNetOK)
            mUserPreferences.saveDateTopics(date: dateNetOK)
            mUserPreferences.saveDateSingleTopic(date: dateNetOK)
            
        } else
        {
            print("APP Delegate => Not connected")
            
            
            mUserPreferences.saveDateCategories(date: Date())
            mUserPreferences.saveDateLatestTopics(date: Date())
            mUserPreferences.saveDatePosts(date: Date())
            mUserPreferences.saveDateTopics(date: Date())
            mUserPreferences.saveDateSingleTopic(date: Date())
        }
        
      
        
        let tabBar = TabBarController(topicsController: TopicsRouter.configureModule(), categoriesController: CategoriesRouter.configureModule(), newTopicController: NewTopicRouter.configureModule())
        window?.rootViewController = tabBar
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }
    
   


}

