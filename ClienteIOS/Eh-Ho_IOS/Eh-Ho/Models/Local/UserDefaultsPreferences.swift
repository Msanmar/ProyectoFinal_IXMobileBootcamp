//
//  UserDefaultsPreferences.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 18/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation



class UserDefaultsPreferences {
    
    
   // private let keyUserTaskStateSelected = "TASK_STATE_SELECTED"
    private let keyDateListCategories = "DATE_LIST_CATEGORIES"
    private let keyDateListTopicsCategory = "DATE_LIST_TOPICS_CATEGORY"
    private let keyDateListPostsTopic = "DATE_LIST_POSTS_TOPIC"
    private let keyDateLatestTopics = "DATE_LATEST_TOPICS"
    private let keyDateSingleTopic = "DATE_SINGLE_TOPIC"
    

    
    func saveDateCategories(date: Date) {
        UserDefaults.standard.set(date, forKey: keyDateListCategories) as? Date
    }

    func saveDateTopics(date: Date) {
        UserDefaults.standard.set(date, forKey: keyDateListTopicsCategory) as? Date
    }
    
    func saveDatePosts(date: Date) {
        UserDefaults.standard.set(date, forKey: keyDateListPostsTopic) as? Date
    }
    
    func saveDateLatestTopics(date: Date) {
        UserDefaults.standard.set(date, forKey: keyDateLatestTopics) as? Date
    }
    
    func saveDateSingleTopic(date: Date) {
         UserDefaults.standard.set(date, forKey: keyDateSingleTopic) as? Date
    }
    
    
func checkTimeIntervalCategories() -> Int {
        let  date2 = UserDefaults.standard.object(forKey: keyDateListCategories)
    
    print("Segundos de intervalo \(Int(Date().timeIntervalSince(date2 as! Date)))")
    return (Int(Date().timeIntervalSince(date2 as! Date)))
    
    
    }
    
    
    func checkTimeIntervalTopics() -> Int {
        let  date3 = UserDefaults.standard.object(forKey: keyDateListTopicsCategory)
        
        print("Segundos de intervalo \(Int(Date().timeIntervalSince(date3 as! Date)))")
        return (Int(Date().timeIntervalSince(date3 as! Date)))
        
        
    }
    
    func checkTimeIntervalPosts() -> Int {
        let  date = UserDefaults.standard.object(forKey: keyDateListPostsTopic)
        
        //print("Segundos de intervalo \(Int(Date().timeIntervalSince(date4 as! Date)))")
        return (Int(Date().timeIntervalSince(date as! Date)))
        
        
    }
 
    
    
    func checkTimeIntervalLatestTopics() -> Int {
        let date = UserDefaults.standard.object(forKey: keyDateLatestTopics) as! Date
       
       //  print("Fecha recuperada: \(date)")
       
     
        return (Int(Date().timeIntervalSince(date)))
    }
    
    func checkTimeIntervalSingleTopic() -> Int {
        let date = UserDefaults.standard.object(forKey: keyDateSingleTopic) as! Date
        
        //  print("Fecha recuperada: \(date)")
        
        
        return (Int(Date().timeIntervalSince(date)))
    }
    
    
}
