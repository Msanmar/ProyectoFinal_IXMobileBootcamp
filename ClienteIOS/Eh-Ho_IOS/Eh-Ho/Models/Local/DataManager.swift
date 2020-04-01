//
//  DataManager.swift
//  Eh-Ho
//
//  Created by Monica Sanmartin on 18/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation



protocol DatabaseDelegate {
    func initDefaultData()
    
    //ListCategories
    func deleteAllDataCategories()
    func saveCategories(response: Category) -> Bool
    func loadDataCategories() -> Array<Category>
    
    //TopicsCategory
    func deleteAllTopicsCategory(catId: Int)
    func saveTopicsCategory(catId: Int, response: Topic) -> Bool
    func loadDataTopics(catId: Int) -> Array<Topic>
  
    
    //PostsTopic
    func savePostsTopic(topicId: Int, response: Post) -> Bool
    func deleteAllPostsTopic(topicId: Int)
    func loadDataPosts(topicId: Int) -> Array<Post>
    
    //Single Topic
    func updateSingleTopic(topicId: Int, catId: Int, newTitle: String) -> Bool
    func loadSingleTopic(catId: Int, topicId: Int) -> Array<Topic>
    
    //Latest Topics
    func deleteAllLatestTopics()
    func saveLatestTopics(response: Topic) -> Bool
    func loadDataLatestTopics() -> Array<Topic>
   
}

class DataManager {
    private var mDatabaseProvider: DatabaseDelegate?
    private var mUserPreferences: UserDefaultsPreferences?
    
    init(){
        mDatabaseProvider = DatabaseCoreData()
        mUserPreferences = UserDefaultsPreferences()
       /* let date = Date()
        mUserPreferences?.saveDateCategories(date: date)*/
        
       
    
    }
    
    deinit {
        mDatabaseProvider = nil
        mUserPreferences = nil
    }
    
}

extension DataManager {

    
    // Funciones DataManager para Response tipo: List Categories
    func deleteAllDataCategories() { //Borrar toda la tabla-entity Cat
        mDatabaseProvider?.deleteAllDataCategories()
    }
    
    func loadResponseCategories() -> Array<Category> { //Mostrar toda la tabla-entity Cat
        return mDatabaseProvider?.loadDataCategories() ?? Array()
    }
    
    func saveCategories(response: Category) -> Bool { //Guardar la lista de Category en la BD Cat
        return mDatabaseProvider?.saveCategories(response:  response) ?? false
    }
    
    
    //Funciones DataManager para Response tipo: List Topics Category
    func deleteAllTopicsCategory(catId: Int){ // Borrar todos los topics de una category
        mDatabaseProvider?.deleteAllTopicsCategory(catId: catId)
        
    }
    
    func saveTopicsCategory(catId: Int, response: Topic) -> Bool { //Guardar la lista de topics de una category en la BD
        return mDatabaseProvider?.saveTopicsCategory(catId: catId, response: response) ?? false
    }
    
    func loadResponseTopics(catId: Int) -> Array<Topic> { //Mostrar todos los topics de una category
        return mDatabaseProvider?.loadDataTopics(catId: catId) ?? Array()
    }
    
    
    //Funciones DataManager para Response tipo: List Posts
    
    func savePostsTopic(topicId: Int, response: Post) -> Bool {// Guardar los posts de un topic
        return mDatabaseProvider?.savePostsTopic(topicId: topicId, response: response) ?? false
    }
    
    func deleteAllPostsTopic(topicId: Int) { // Borrar todos los topics de una category
        mDatabaseProvider?.deleteAllPostsTopic(topicId: topicId)
        
    }
    
    func loadResponsePosts(topicId: Int) -> Array<Post> { //Mostrar todos los topics de una category
        return mDatabaseProvider?.loadDataPosts(topicId: topicId) ?? Array()
    }
    
    
    // Funciones DataManager para Response tipo: SingleTopic
    func loadSingleTopic(catId: Int, topicId: Int) -> Topic {
        return (mDatabaseProvider?.loadSingleTopic(catId: catId, topicId: topicId).first)!
    }
   
    func updateSingleTopic(topicId: Int, catId: Int, newTitle: String) -> Bool {
        return(mDatabaseProvider?.updateSingleTopic(topicId: topicId, catId: catId, newTitle: newTitle) ?? false)
    
    }
    
    func saveSingleTopic(topicId: Int, catId: Int, response: Topic) -> Bool {
         print("Save Single Topic data manager")
        return true
    }
    
    
    // TODO: deleteSingleTopic(catId:?, topicId:?)
    // Borrar todos los posts y borrar el topic
    
    
    //Funciones DataManager para Response tipo: LatestTopics
    func deleteAllLatestTopics(){
        mDatabaseProvider?.deleteAllLatestTopics()
       
    }
    
    func saveLatestTopics(response: Topic) -> Bool { //Guardar la lista de latest topics en la BD
        //return mDatabaseProvider?.saveTopicsCategory(catId: catId, response: response) ?? false
        return mDatabaseProvider?.saveLatestTopics(response:  response) ?? false
   
    }
    
    func loadResponseLatestTopics() -> Array<Topic>{ //Devolver todos los latest topics
        return mDatabaseProvider?.loadDataLatestTopics() ?? Array()
        
    }
    
    
}
